library MasteryFelsteel initializer OnInit requires Persons, LegionMasteryConfig

    globals
        private constant integer RESEARCH_ID = 'R01Y'
    endglobals

    private function Research takes nothing returns nothing
        local DemonType tempDemonType = 0
        local Person tempPerson = 0
        if GetResearched() == RESEARCH_ID then
            set tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
                if tempPerson != 0 then
                    call tempPerson.applyFactionMod(FACTIONMOD_MASTERY_FELSTEEL)
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