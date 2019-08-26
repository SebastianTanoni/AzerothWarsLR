library BlackHole initializer OnInit

    globals
        private constant integer    ABIL_ID                        = 'A00C'
        private constant real       DURATION                       = 16.

        private constant real       DAMAGE_BASE = 20.
        private constant real       DAMAGE_LEVEL = 20.
        private constant real       PULL = 200.   //How far to pull units per second

        private constant string     EFFECT    = "war3mapImported\\Void Disc.mdx"
        private constant real       EFFECT_SCALE = 1.3
        private constant real       RADIUS = 600

        private keyword BlackHole
        private BlackHole array BlackHoles      //For attaching to channeler unit
        private unit TempUnit = null
        private group TempGroup = CreateGroup()
    endglobals

    private struct BlackHole
        unit       cas = null
        real       tick = 0.
        real       duration = 0.
        real       fullDuration = 0.
        
        effect     sfx = null
        
        real       x  = 0.
        real       y  = 0.
        real       z  = 0.
        real       radius = 0.
        real       damage = 0.
        
        method destroy takes nothing returns nothing
            call DestroyEffect(this.sfx)

            set this.cas = null
            set this.sfx = null
            
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        private method suck takes nothing returns nothing
            local unit u = null
            local real x = 0
            local real y = 0
            local real ang = 0
            local real dist = 0
            set P = GetOwningPlayer(this.cas)  
            call GroupEnumUnitsInRange(TempGroup,this.x,this.y,this.radius,Condition(function EnemyAliveFilter))
            loop
                set u = FirstOfGroup(TempGroup)
                exitwhen u == null
                set x = GetUnitX(u)
                set y = GetUnitY(u)
                set dist = GetDistanceBetweenPoints(x, y, this.x, this.y)
                if not IsUnitType(u, UNIT_TYPE_RESISTANT) then
                    set ang = GetAngleBetweenPoints(x, y, this.x, this.y)
                    call SetUnitX(u, x + (PULL/T32_FPS)*Cos(ang))
                    call SetUnitY(u, y + (PULL/T32_FPS)*Sin(ang))
                endif
                call GroupRemoveUnit(TempGroup,u)
            endloop             
        endmethod

        private method periodic takes nothing returns nothing    
            set this.tick = this.tick+1
            set this.duration = this.duration - 1./T32_FPS

            if this.duration >= 0 then  
                call this.suck()
            endif
                
            if this.duration == 0 then
                call this.destroy()
            endif

        endmethod
        
        implement T32x
        
        static method create takes unit cast, real x, real y, real damage, real radius, real duration returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0
            local boolean b = false
            
            set this.cas = cast

            set this.x  = x
            set this.y  = y
            set this.z  = 20.00 + GetPositionZ(x,y)  
            set this.damage = damage        
            set this.radius = radius
            set this.duration = duration
            
            set this.sfx = AddSpecialEffect(EFFECT,x,y)
            call BlzSetSpecialEffectScale(this.sfx, EFFECT_SCALE)
            
            call this.startPeriodic()
            
            return this
        endmethod
    endstruct

    private function Cast takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer i = 0
        local boolean b = false
        
        if GetSpellAbilityId() == ABIL_ID then
            set BlackHoles[GetUnitId(u)] = BlackHole.create(u, GetSpellTargetX(), GetSpellTargetY(), DAMAGE_BASE+GetUnitAbilityLevel(u, ABIL_ID)*DAMAGE_LEVEL, RADIUS, DURATION)
        endif
    endfunction
    
    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_CAST )
        call TriggerAddCondition( trig, Condition(function Cast) )
    endfunction 
    
endlibrary