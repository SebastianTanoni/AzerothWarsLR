/* library ValiantCharge initializer OnInit requires Filters

    globals
        private constant integer     ABIL_ID = 'A00B'
        private constant real        VELOCITY = 2000.             //Units per second
        private constant real        DISTANCE = 800.
        private constant string      EFFECT = "war3mapImported\\Valiant Charge.mdx"
        
        private constant real        DAMAGE_BASE = 100.
        private constant real        DAMAGE_LEVEL = 100.
        private constant real        RADIUS = 100.
        
        private constant group       TEMP_GROUP = CreateGroup()
    endglobals

    struct ValiantCharge        
        unit caster = null
        real velocity = 0
        real distance = 0
        real maxDistance = 0
        real angle = 0          //In radians
        group alreadyHit
        effect sfx = null
        
        private method destroy takes nothing returns nothing   
            call UnitEnableCollision(this.caster)
            call DestroyEffect(this.sfx)
            call DestroyGroup(alreadyHit)
            set this.caster = null
            call this.stopPeriodic()
            call this.deallocate()
        endmethod        
        
        private method doDamage takes nothing returns nothing
            local unit u = null
            
            set P = GetOwningPlayer(this.caster)  
            call GroupEnumUnitsInRange(TempGroup,GetUnitX(caster),GetUnitY(caster),RADIUS,Condition(function EnemyAliveFilter))
            loop
                set u = FirstOfGroup(TempGroup)
                exitwhen u == null
                if not IsUnitInGroup(u, this.alreadyHit) then
                    call Damage_Spell(this.caster, u, DAMAGE_BASE)
                else
                    call GroupAddUnit(this.alreadyHit, u)
                endif
                call GroupRemoveUnit(TempGroup,u)
            endloop              
        endmethod
        
        private method periodic takes nothing returns nothing               
            local real realVelocity = RMinBJ(this.velocity/T32_FPS, this.maxDistance - this.distance)
            local real destinationX = 0
            local real destinationY = 0
            if this.distance < this.maxDistance then
                set destinationX = GetUnitX(this.caster) + realVelocity * Cos(this.angle)
                set destinationY = GetUnitY(this.caster) + realVelocity * Sin(this.angle)
                if IsTerrainPathable(destinationX, destinationY, PATHING_TYPE_WALKABILITY) == false then
                    call SetUnitX(this.caster, destinationX)
                    call SetUnitY(this.caster, destinationY)
                    call SetUnitFacing(this.caster, this.angle * bj_RADTODEG)
                    set this.distance = this.distance + realVelocity
                    call this.doDamage()
                else
                    call this.destroy()
                endif
            else
                call this.destroy()
            endif

        endmethod
        
        implement T32x   
        
        static method create takes unit cast, real velocity, real maxDistance, real angle returns thistype
            local thistype this = thistype.allocate()
            
            set this.caster = cast
            set this.velocity = velocity
            set this.distance = 0
            set this.maxDistance = maxDistance
            set this.angle = angle
            
            set this.sfx = AddSpecialEffectTarget(EFFECT,this.caster, "origin") 

            set this.alreadyHit = CreateGroup()
            call UnitDisableCollision(cast)
            call this.startPeriodic()
            
            return this
        endmethod        
        
    endstruct
    
    private function Cast takes nothing returns nothing
        local unit caster 
        local integer level   
        local real casterX
        local real casterY
        local real targetX
        local real targetY
        
        if GetSpellAbilityId() == ABIL_ID then
            set caster = GetTriggerUnit()
            set level = GetUnitAbilityLevel(caster, ABIL_ID) 
            set casterX = GetUnitX(caster)
            set casterY = GetUnitY(caster)
            set targetX = GetSpellTargetX()
            set targetY = GetSpellTargetY()
            call ValiantCharge.create(caster, VELOCITY, RMinBJ(DISTANCE,GetDistanceBetweenPoints(casterX, casterY, targetX, targetY)), Atan2(targetY - casterY, targetX - casterX))
        endif
    
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trig, Condition(function Cast))
    endfunction    

endlibrary */