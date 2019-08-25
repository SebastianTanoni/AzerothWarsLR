library MasterVoid requires Persons, LegionMasteryConfig, DemonType, DemonTypeConfig

    //Increases the Rematerialization chance of Voidwalkers, Nether Drakes and Nether Dragons to 30%.
    //Increases the hit points of Voidwalkers by 150.

    globals
        private constant integer RESEARCH_ID = 'R020'
    endglobals

    private function Research takes nothing returns nothing
        local DemonType tempDemonType = 0
        local Person tempPerson = 0
        if GetResearched() == RESEARCH_ID then
            set tempDemonType = DemonType.demonsByUnitId['nvdw']      //Voidwalker
                call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_HIGH)     
            set tempDemonType = DemonType.demonsByUnitId['n04U']      //Nether Dragon
                call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_HIGH) 
            set tempDemonType = DemonType.demonsByUnitId['n070']      //Nether Drake
                call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_HIGH) 
            set tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
                if tempPerson != 0 then
                    call tempPerson.applyFactionMod(FACTIONMOD_MASTERY_VOID)
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