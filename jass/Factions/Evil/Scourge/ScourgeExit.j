library ScourgeExit initializer OnInit

    globals
        trigger ScourgeExitTrigger = null
    endglobals

    private function Actions takes nothing returns nothing
        local Person scourgePerson = PersonsByFaction[0]
        local player scourgePlayer = null
        local integer i = 0
        
        loop
        exitwhen ScourgeFogModifiers[i] == null
            call DestroyFogModifier(ScourgeFogModifiers[i])
            set ScourgeFogModifiers[i] = null
            set i = i + 1
        endloop

    	call DisableTrigger( gg_trg_Plague_Cauldrons )
    	call DisableTrigger( gg_trg_Plague_Command )
    	call DisableTrigger( gg_trg_Plague_Conversion )
    	call DisableTrigger( gg_trg_Plague_Timer )
    	call DisableTrigger( gg_trg_Plague_Turn_On )
    endfunction

    private function OnInit takes nothing returns nothing
        set ScourgeExitTrigger = CreateTrigger()
        call TriggerAddCondition(ScourgeExitTrigger, Condition(function Actions))
    endfunction

endlibrary
