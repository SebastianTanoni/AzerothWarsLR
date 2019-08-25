library AbyssalMaw initializer OnInit requires T32, Math, Filters, SpellHelpers

    globals
        private constant integer ABIL_ID = 'A10L'

        private constant real DAMAGE_BASE = 22.5  //Per second
        private constant real DAMAGE_LEVEL = 7.5
        private constant real RADIUS = 150
        private constant real CONSUME_DISTANCE = 10    //How far away the unit gets eaten at
        private constant real VELOCITY = 1000 //How fast the unit gets pulled into the maw
        private constant real HEAL_PERCENTAGE = 0.1 //How much of the victim's health to heal for
        private constant real Z_OFFSET = 100    //How high above the caster he pulls the units into (gaping maw stuff)
        private constant real DURATION = 4.     //How long units should be eaten for before they get spat out

        private constant string EFFECT_CONSUME = "Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl"
        private constant string EFFECT_HEAL = "Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl"
        private constant real EFFECT_SCALE_CONSUME = 0.7
        private constant real EFFECT_SCALE_HEAL = 2

        private constant real ARC_RATIO = 0.4
        private constant real SPIT_DISTANCE_MIN = 200.
        private constant real SPIT_DISTANCE_MAX = 900.
        private constant real SPIT_VELOCITY = 400.
    endglobals

    private struct MawVictim
        private unit victim = null
        private unit caster = null
        private real damage = 0
        private real velocity = 0
        private real fullDistance = 0
        private real spitX = 0
        private real spitY = 0
        private real tick = 0
        private real duration = 0
        private real durationMax = 0
        private integer state = 0   //0 for flying, 1 for being eaten inside the caster, and 2 for being spat out

        private method destroy takes nothing returns nothing
            call ShowUnit(this.victim, true)
            call PauseUnit(this.victim, false)

            call SetUnitFlyHeight(this.victim, 0, 1000)
            call UnitRemoveAbility(this.victim, 'Amrf')    //Crow form
            call UnitRemoveType(this.victim, UNIT_TYPE_FLYING)
            call SetUnitPathing(this.victim, true)

            set this.victim = null
            set this.caster = null
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        private method spitPeriodic takes nothing returns nothing
            local real victimX = GetUnitX(victim)
            local real victimY = GetUnitY(victim)
            local real angle = GetAngleBetweenPoints(victimX, victimY, this.spitX, this.spitY)
            local real distance = GetDistanceBetweenPoints(this.spitX, this.spitY, victimX, victimY)
            local real arcHeight = this.fullDistance - RAbsBJ(this.fullDistance/2 - distance)*2
            local real realVelocity = RMinBJ(this.velocity/T32_FPS, distance)
            local real destinationX = victimX + realVelocity * Cos(angle)
            local real destinationY = victimY + realVelocity * Sin(angle)
            if distance > 200 and not IsTerrainPathable(destinationX, destinationY, PATHING_TYPE_FLYABILITY) then
                call SetUnitX(this.victim, destinationX)
                call SetUnitY(this.victim, destinationY)
                call SetUnitFlyHeight(this.victim, Z_OFFSET+(arcHeight)*ARC_RATIO, 1000)
                call BlzSetUnitStringField(this.victim, UNIT_SF_SHADOW_IMAGE_UNIT, "Shadow")
            else
                call this.destroy()
            endif                  
        endmethod

        private method consumeFinish takes nothing returns nothing
            local effect tempSfx = AddSpecialEffect(EFFECT_CONSUME, GetUnitX(this.victim), GetUnitY(this.victim))
            local real tempDist = 0
            local real tempAngle = 0
            call BlzSetSpecialEffectScale(tempSfx, EFFECT_SCALE_CONSUME)
            call DestroyEffect(tempSfx)

            call SetUnitAnimation(this.caster, "attack")
            call QueueUnitAnimation(this.caster, "stand")

            set tempDist = GetRandomReal(SPIT_DISTANCE_MIN, SPIT_DISTANCE_MAX)
            set tempAngle = GetRandomReal(0, 360)
            call SetUnitX(this.victim, GetUnitX(this.caster))
            call SetUnitY(this.victim, GetUnitY(this.caster))
            set this.spitX = GetPolarOffsetX(GetUnitX(this.caster), tempDist, tempAngle)
            set this.spitY = GetPolarOffsetY(GetUnitY(this.caster), tempDist, tempAngle)
            set this.fullDistance = GetDistanceBetweenPoints(this.spitX, this.spitY, GetUnitX(victim), GetUnitY(victim))
            set this.velocity = SPIT_VELOCITY
            set this.state = 2
        endmethod

        private method consumePeriodic takes nothing returns nothing
            local effect tempSfx = null

            set this.tick = this.tick + 1
            set this.duration = this.duration + 1

            if this.tick/T32_FPS == 1 then
                call UnitDamageTarget(this.caster, this.victim, this.damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                call UnitHeal(this.caster, this.victim, HEAL_PERCENTAGE * RMaxBJ(GetUnitState(this.victim, UNIT_STATE_MAX_LIFE), this.damage))
                set tempSfx = AddSpecialEffectTarget(EFFECT_HEAL, this.caster, "origin")
                call BlzSetSpecialEffectScale(tempSfx, EFFECT_SCALE_HEAL)
                call DestroyEffect(tempSfx)
                set this.tick = 0
            endif

            if this.duration == this.durationMax or not IsUnitAliveBJ(this.victim) then
                call ShowUnit(this.victim, true)
                call this.consumeFinish()
            endif

            set tempSfx = null
        endmethod

        private method consumeStart takes nothing returns nothing
            local effect tempSfx = AddSpecialEffect(EFFECT_CONSUME, GetUnitX(this.victim), GetUnitY(this.victim))
            local real tempDist = 0
            local real tempAngle = 0
            call BlzSetSpecialEffectScale(tempSfx, EFFECT_SCALE_CONSUME)
            call DestroyEffect(tempSfx)

            call SetUnitAnimation(this.caster, "attack")
            call QueueUnitAnimation(this.caster, "stand")        
            call ShowUnit(this.victim, false)
            call SetUnitPathing(this.victim, false)
            set this.state = 1
        endmethod

        private method pullPeriodic takes nothing returns nothing
            local real destinationX = 0
            local real destinationY = 0
            local real casterX = GetUnitX(caster)
            local real casterY = GetUnitY(caster)
            local real victimX = GetUnitX(victim)
            local real victimY = GetUnitY(victim)
            local real angle = GetAngleBetweenPoints(victimX, victimY, casterX, casterY)
            local real distance = GetDistanceBetweenPoints(casterX, casterY, victimX, victimY)
            local real arcHeight = this.fullDistance - RAbsBJ(this.fullDistance/2 - distance)*2
            local real realVelocity = RMinBJ(this.velocity/T32_FPS, distance)
            if distance > CONSUME_DISTANCE then
                set destinationX = victimX + realVelocity * Cos(angle)
                set destinationY = victimY + realVelocity * Sin(angle)
                call SetUnitX(this.victim, destinationX)
                call SetUnitY(this.victim, destinationY)
                call SetUnitFlyHeight(this.victim, Z_OFFSET+(arcHeight-CONSUME_DISTANCE)*ARC_RATIO, 1000)
                call BlzSetUnitStringField(this.victim, UNIT_SF_SHADOW_IMAGE_UNIT, "ShadowFlyer")
            else
                call this.consumeStart()
            endif            
        endmethod

        method periodic takes nothing returns nothing
            if this.state == 2 then
                call this.spitPeriodic()
            elseif this.state == 1 then
                call this.consumePeriodic()
            else
                call this.pullPeriodic()
            endif
        endmethod

        implement T32x

        static method create takes unit caster, unit victim, real damage, real velocity, real durationMax returns thistype 
            local thistype this = thistype.allocate()
            set this.caster = caster
            set this.victim = victim
            set this.damage = damage
            set this.velocity = velocity
            set this.fullDistance = GetDistanceBetweenPoints(GetUnitX(caster), GetUnitY(caster), GetUnitX(victim), GetUnitY(victim))
            set this.durationMax = durationMax*T32_FPS
            call PauseUnit(this.victim, true)
            call UnitAddAbility(this.victim, 'Amrf')    //Crow form
            call UnitAddType(this.victim, UNIT_TYPE_FLYING)

            call this.startPeriodic()
            return this
        endmethod
    endstruct

    private function Cast takes nothing returns nothing
        local unit u
        local unit caster
        local integer level        

        if GetSpellAbilityId() == ABIL_ID then
            set caster = GetTriggerUnit()
            set level = GetUnitAbilityLevel(caster, ABIL_ID)             
			set P = GetOwningPlayer(caster)
			call GroupEnumUnitsInRange(TempGroup,GetSpellTargetX(),GetSpellTargetY(),RADIUS,Condition(function UnitEnemyAliveFilter))
			loop
				set u = FirstOfGroup(TempGroup)
				exitwhen u == null
                if not IsUnitType(u, UNIT_TYPE_FLYING) then
				    call MawVictim.create(caster, u, DAMAGE_BASE + DAMAGE_LEVEL*level, VELOCITY, DURATION)
                endif
				call GroupRemoveUnit(TempGroup,u)
			endloop
		endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trig, Condition(function Cast))
    endfunction 

endlibrary