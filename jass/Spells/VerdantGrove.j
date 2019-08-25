library VerdantGrove initializer OnInit requires Filters, DummyCaster

    globals
        private constant integer    ABIL_ID                        = 'A00G'
        private constant integer    DUMMY_ABIL_ID                  = 'Aenw' //Must be a copy of Entangling Roots
        private constant real       DURATION                       = 16.

        private constant real       DAMAGE_BASE = 20.
        private constant real       DAMAGE_LEVEL = 20.

        private constant string     EFFECT    = "war3mapImported\\Point Target.mdx"
        private constant real       EFFECT_SCALE = 1.3
        private constant real       RADIUS = 300

        private constant real       EFFECT_FADE        = 1.    //How long it takes the SFX to fade in
        private constant integer    EFFECT_ALPHA       = 200   //How much alpha the fully faded in target reticule has
    endglobals

  private function CastRoots takes unit target, real damage, real duration returns nothing
    local ability tempAbility = null
    call UnitAddAbility(DUMMY, DUMMY_ABIL_ID)
    set tempAbility = BlzGetUnitAbility(DUMMY, DUMMY_ABIL_ID)
    call BlzSetUnitAbilityCooldown(DUMMY, DUMMY_ABIL_ID, 0, 0.)
    call BlzSetUnitAbilityManaCost(DUMMY, DUMMY_ABIL_ID, 0, 0)
    call BlzSetAbilityRealLevelField(tempAbility, ABILITY_RLF_DURATION_NORMAL, 0, duration)
    call BlzSetAbilityRealLevelField(tempAbility, ABILITY_RLF_DURATION_HERO, 0, duration/4)
    call BlzSetAbilityRealLevelField(tempAbility, ABILITY_RLF_DAMAGE_PER_SECOND_EER1, 0, damage)
    call IssueTargetOrder(DUMMY, "entanglingroots", target)
    call UnitRemoveAbility(DUMMY, DUMMY_ABIL_ID)
  endfunction

    private struct VerdantGrove
        unit       cas = null
        real       tick = 0.
        real       duration = 0.
        
        effect     sfx = null
        
        integer    alpha = 0
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

        private method entangleAll takes nothing returns nothing
            local unit u = null
            local real x = 0
            local real y = 0
            local real dist = 0
            local group tempGroup = CreateGroup()
            set P = GetOwningPlayer(this.cas)  
            call GroupEnumUnitsInRange(tempGroup,this.x,this.y,this.radius,Condition(function EnemyAliveFilter))
            loop
                exitwhen BlzGroupGetSize(tempGroup) == 0
                set u = FirstOfGroup(tempGroup)
                set x = GetUnitX(u)
                set y = GetUnitY(u)
                set dist = GetDistanceBetweenPoints(x, y, this.x, this.y)
                if dist <= RADIUS then
                  call CastRoots(u, this.damage, DURATION)
                endif
                call GroupRemoveUnit(tempGroup,u)
            endloop       
            call DestroyGroup(tempGroup)
            set tempGroup = null      
        endmethod

        private method periodic takes nothing returns nothing    
            set this.tick = this.tick+1
            set this.duration = this.duration - 1./T32_FPS

            if this.duration >= 0 then  
                if this.alpha <= EFFECT_ALPHA then
                    set this.alpha = this.alpha+R2I(EFFECT_ALPHA/(EFFECT_FADE*T32_FPS))
                    call BlzSetSpecialEffectAlpha(this.sfx, this.alpha)
                endif
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
            call BlzSetSpecialEffectScale(this.sfx, RADIUS/69)
            call BlzSetSpecialEffectColor(this.sfx, 50, 255, 50)
            call BlzSetSpecialEffectTimeScale(this.sfx,0)
            call BlzSetSpecialEffectAlpha(this.sfx, 0)

            call this.entangleAll()
            
            call this.startPeriodic()
            
            return this
        endmethod
    endstruct

    private function Cast takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer i = 0
        local boolean b = false
        
        if GetSpellAbilityId() == ABIL_ID then
          call VerdantGrove.create(u, GetSpellTargetX(), GetSpellTargetY(), DAMAGE_BASE+GetUnitAbilityLevel(u, ABIL_ID)*DAMAGE_LEVEL, RADIUS, DURATION)
        endif
    endfunction
    
    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_CAST )
        call TriggerAddCondition( trig, Condition(function Cast) )
    endfunction 
    
endlibrary