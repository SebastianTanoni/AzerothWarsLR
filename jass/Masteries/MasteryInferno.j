library MasteryInferno initializer OnInit requires Persons, LegionMasteryConfig, DemonType, DemonTypeConfig

    //Allows you to train 4 additional Infernals. Increases the damage and range of Meteor Instantiation to 25%.
    //Increases the duration of Infernals by 100%. 

    globals
        private constant integer RESEARCH_ID = 'R01M'

        private constant real DURATION_MULTIPLIER = 2.00
        private constant real DAMAGE_MULTIPLIER = 1.25
        private constant real RANGE_MULTIPLIER = 1.25
    endglobals

    private function Research takes nothing returns nothing
        local DemonType tempDemonType = 0
        local Person tempPerson = 0
        if GetResearched() == RESEARCH_ID then
            set tempDemonType = DemonType.demonsByUnitId['ninf']      //Infernal
                call tempDemonType.setDuration(tempDemonType.duration * DURATION_MULTIPLIER)     
                call tempDemonType.setInstantiationDamage(tempDemonType.instantiationDamage * DAMAGE_MULTIPLIER)
                call tempDemonType.setInstantiationRange(tempDemonType.instantiationRange * RANGE_MULTIPLIER)     
            set tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
                if tempPerson != 0 then
                    call tempPerson.applyFactionMod(FACTIONMOD_MASTERY_INFERNO)
                endif
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH  )
        call TriggerAddCondition(trig, Condition(function Research))    
    endfunction

endlibrary