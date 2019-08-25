library UnleashFrostmourne initializer OnInit requires Projectile, SpellHelpers

    globals    
        private constant integer    ABIL_ID         = 'A0YT'
        private constant real       RADIUS          = 700.
        private constant real       DAMAGE          = 60.
        private constant real       DAMAGE_LEVEL    = 40.   //Spell gains this damage per projectile for each level it has (including 1)
        private constant real       HEAL_RATIO      = 0.5   //This has to be expressed as a percentage of the damage value
        private constant real       REANIMATE_DUR   = 70.
        private constant real       PERIOD          = 0.1   //Fires projectiles every x period
        
        private constant string     EFFECT          = "Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl"
        private constant real       EFFECT_SCALE    = 0.5
        
        private constant string     PROJ_EFFECT     = "Abilities\\Weapons\\ZigguratMissile\\ZigguratMissile.mdl"
        private constant real       PROJ_SPEED      = 600.
        private constant real       PROJ_ARC        = 0.2
        private constant real       PROJ_Z_OFFSET   = 50.       //Probably don't touch this
        private constant real       PROJ_Z_OFFSET_START = 110.  //So that the projectiles spawn above the caster's head
        private constant real       PROJ_RADIUS     = 70.
    endglobals

    private function OnUnitImpact takes projectile p, unit u returns nothing
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        
        //Projectile hit its target
        if u != p.sourceUnit and (u == p.targetUnit or p.targetUnit == null) then
            call p.terminate() 
            if IsUnitEnemy(u,P) and IsUnitAlive(u) and not IsUnitType(u, UNIT_TYPE_UNDEAD) then     //Organic hostile
                call UnitDamageTarget(p.sourceUnit, u, p.damageDealt, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            elseif IsUnitAlly(u,P) and IsUnitAlive(u) and IsUnitType(u, UNIT_TYPE_UNDEAD) then      //Undead friendly
                call UnitHeal(p.sourceUnit, u, p.damageDealt*HEAL_RATIO)
            elseif IsUnitCorpse(u) and not IsUnitType(u, UNIT_TYPE_RESISTANT) then                  //Corpse
                call UnitReanimate(p.sourceUnit, u, REANIMATE_DUR)
            endif  
        endif
    
    endfunction

    private struct Fury
        unit       cas = null
        effect     sfx = null
        real       tick = 0.00
        
        real       x  = 0.00
        real       y  = 0.00
        real       z  = 0.00
        real       damage = 0.
        real       period = 0.
        
        method destroy takes nothing returns nothing
            call DestroyEffect(this.sfx)
            
            set this.cas = null
            set this.sfx = null
            
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        private method createProjectile takes unit caster, real x, real y, unit target, real damage returns nothing
            local real       casterX = x
            local real       casterY = y
            local real       targetX = GetUnitX(target)
            local real       targetY = GetUnitY(target)
            local real       targetZ = GetPositionZ(targetX,targetY)
            local real       ang  = Atan2((targetY - casterY),(targetX - casterX))
            local projectile proj = 0
            
            //---------------------------------------------------------
            set proj = projectile.create(casterX,casterY,PROJ_Z_OFFSET+PROJ_Z_OFFSET_START,ang)
            
            set proj.sourceUnit          = caster
            set proj.owningPlayer        = GetOwningPlayer(caster)
            set proj.effectPath          = PROJ_EFFECT
            set proj.damageDealt         = damage
            set proj.scaleSize           = 1.00

            set proj.allowExpiration     = true
            set proj.allowDeathSfx       = true
            set proj.allowArcAnimReset   = true
            set proj.allowUnitCollisions = true
            
            set proj.unitHitRadius       = PROJ_RADIUS
            
            set proj.onUnit              = OnUnitImpact

            set proj.targetUnit = target
            set proj.allowTargetHoming = true
            set proj.zOffset = PROJ_Z_OFFSET    //This is actually for the target
            
            call proj.projectArcing(targetX,targetY,GetPositionZ(targetX,targetY) + PROJ_Z_OFFSET,PROJ_SPEED,PROJ_ARC) 
        endmethod

        private static method targetFilter takes nothing returns boolean
            local unit u = GetFilterUnit()
            if GetUnitAbilityLevel(GetFilterUnit(),'Avul') > 0 then
                return false
            elseif IsUnitEnemy(u,P) and IsUnitAlive(u) and not IsUnitType(u, UNIT_TYPE_UNDEAD) then //Organic hostile
                return true
            elseif IsUnitAlly(u,P) and IsUnitAlive(u) and IsUnitType(u, UNIT_TYPE_UNDEAD) and GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(u, UNIT_STATE_MAX_LIFE) then //Undead friendly
                return true
            elseif IsUnitCorpse(u) and not IsUnitType(u, UNIT_TYPE_RESISTANT) then //Corpse
                return true
            endif
            return false
        endmethod

        private method findTarget takes nothing returns nothing
            local unit u
            local group g = CreateGroup()
            
            set P = GetOwningPlayer(this.cas)
            call GroupEnumUnitsInRange(g,this.x,this.y,RADIUS,Condition(function Fury.targetFilter))
            
            set u = GroupPickRandomUnit(g)
            
            if u != null then
                call this.createProjectile(this.cas, this.x, this.y, u, this.damage)
            endif
            
            call DestroyGroup(g)
        endmethod

        private method periodic takes nothing returns nothing
            
            if this.tick >= T32_FPS * this.period then
                call this.findTarget()
                set this.tick = 0     
            endif
            
            set this.tick = this.tick+1
        endmethod
        
        implement T32x
        
        static method create takes unit cast, real x, real y, real damage, real period returns thistype
            local thistype this = thistype.allocate()
            
            set this.cas = cast
            set this.sfx = AddSpecialEffect(EFFECT,x,y)
            set this.tick = 1.00
            
            set this.x  = x
            set this.y  = y
            set this.z  = 20.00 + GetPositionZ(x,y)
            set this.damage = damage
            set this.period = period
            
            call BlzSetSpecialEffectScale(this.sfx,EFFECT_SCALE)
            call BlzSetSpecialEffectColor(this.sfx, 0, 0, 255)
            call this.startPeriodic()
            
            return this
        endmethod
    endstruct

    globals
        private Fury array Furies
    endglobals

    private function StopChannel takes nothing returns nothing
        if GetSpellAbilityId() == ABIL_ID then
            call Furies[GetUnitId(GetTriggerUnit())].destroy()
        endif
    endfunction

    private function StartChannel takes nothing returns nothing
        local unit u = GetTriggerUnit()
        if GetSpellAbilityId() == ABIL_ID then
            set Furies[GetUnitId(u)] = Fury.create(u, GetUnitX(u), GetUnitY(u), DAMAGE+GetHeroLevel(u)*DAMAGE_LEVEL, PERIOD)
        endif
    endfunction
    
    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_CHANNEL )
        call TriggerAddCondition( trig, Condition(function StartChannel) )

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
        call TriggerAddCondition( trig, Condition(function StopChannel) )
    endfunction 

endlibrary
