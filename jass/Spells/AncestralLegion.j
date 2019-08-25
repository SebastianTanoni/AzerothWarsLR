
library AncestralLegion initializer OnInit requires AIDS, Filters, SpellHelpers
    
    //*CONFIGURATION*
    globals
        private constant integer ABIL_ID = 'A0YX'
        private constant real    DURATION  = 60.0
        
        private constant real    HEALTH_BONUS_BASE = 0.2      //These refer to the % extra amount of that stat an Ancestor gets
        private constant real    HEALTH_BONUS_LEVEL = 0.1   //The level ones are for each additional hero level, including level 1
        private constant real    DAMAGE_BONUS_BASE = 0.2
        private constant real    DAMAGE_BONUS_LEVEL = 0.1

        private constant integer SUMMON_CAP_BASE = 12
        private constant integer SUMMON_CAP_LEVEL = 6

        private constant real    REMEMBER_CHANCE = 1.0      //Chance for Cairne to remember a Tauren that dies
        
        private constant integer TAUREN_ID = 'otau'
        
        private constant string  EFFECT = "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl"
        private constant string  EFFECT_DEATH = "Abilities\\Spells\\Orc\\Disenchant\\DisenchantSpecialArt.mdl"
    endglobals

    //*NOT CONFIG*
    globals
        private group UnitsWithAncestralLegion = CreateGroup()
        private group Ancestors = CreateGroup()
        private integer array TaurenCount

        private string array ExtendedTooltips

        private integer DiedId   //Necessary because unit group enumerators don't take parameters    
    endglobals

    private function RewriteTooltip takes unit u, integer taurenCount returns nothing
        local integer i = 0
        loop
        exitwhen i == 3
            call BlzSetAbilityExtendedTooltip(ABIL_ID, ExtendedTooltips[i] + "|n|n|cffDA9531Remembered Tauren:|r " + I2S(taurenCount), i)
            set i = i + 1
        endloop
    endfunction

    private function Cast takes nothing returns nothing
        local unit caster
        local integer casterId
        local integer level
        local integer i = 0
        local unit u
        local integer summonCount = 0
        
        if GetSpellAbilityId() == ABIL_ID then   
            set caster = GetTriggerUnit()
            set casterId = GetUnitId(caster)
            set level = GetUnitAbilityLevel(caster, ABIL_ID)
            
            set summonCount = IMinBJ(SUMMON_CAP_BASE + GetUnitAbilityLevel(caster, ABIL_ID) * SUMMON_CAP_LEVEL, TaurenCount[casterId])

            loop
            exitwhen i >= summonCount
                set u = CreateSummon(GetOwningPlayer(caster), TAUREN_ID, GetSpellTargetX(), GetSpellTargetY(), GetUnitFacing(caster), DURATION)
                call DestroyEffect(AddSpecialEffect(EFFECT, GetUnitX(u), GetUnitY(u)))
                call SetUnitVertexColor(u, 200, 165, 50, 150)
                call GroupAddUnit(Ancestors, u)
                call ScaleUnitBaseDamage(u, 1 + DAMAGE_BONUS_BASE + DAMAGE_BONUS_LEVEL*level, 0)
                call ScaleUnitMaxHP(u, 1 + HEALTH_BONUS_BASE + HEALTH_BONUS_LEVEL*level)
                set TaurenCount[casterId] = TaurenCount[casterId] -1
                set i = i + 1
            endloop
            
            call RewriteTooltip(caster, TaurenCount[casterId])
        endif
    endfunction
    
    private function Remember takes nothing returns nothing
        local unit u = GetEnumUnit()
        local integer uId = GetUnitId(u)
        if DiedId == TAUREN_ID then
            set TaurenCount[uId] = TaurenCount[uId] + 1
        endif
        call RewriteTooltip(u, TaurenCount[uId])
    endfunction

    private function Death takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local integer i = GetUnitTypeId(u)
        if i == TAUREN_ID then 
            if not IsUnitType(u, UNIT_TYPE_SUMMONED) and not IsUnitType(u, UNIT_TYPE_UNDEAD) and GetRandomReal(0,1) < REMEMBER_CHANCE then
                set DiedId = i
                call ForGroup(UnitsWithAncestralLegion, function Remember)
            endif
        endif
        
        if IsUnitInGroup(u, Ancestors) then
            call DestroyEffect(AddSpecialEffect(EFFECT, GetUnitX(u), GetUnitY(u)))
            call GroupRemoveUnit(Ancestors,u)
            call RemoveUnit(u)
        endif
    endfunction

    private function Learn takes nothing returns nothing
        if GetLearnedSkill() == ABIL_ID then        
            call GroupAddUnit(UnitsWithAncestralLegion, GetTriggerUnit())
        endif        
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trig, Condition(function Cast))

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( trig, Condition(function Death))       

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_HERO_SKILL )
        call TriggerAddCondition( trig, Condition(function Learn))
        
        set ExtendedTooltips[0] = BlzGetAbilityExtendedTooltip(ABIL_ID, 0)
        set ExtendedTooltips[1] = BlzGetAbilityExtendedTooltip(ABIL_ID, 1)
        set ExtendedTooltips[2] = BlzGetAbilityExtendedTooltip(ABIL_ID, 2)
    endfunction
    
endlibrary