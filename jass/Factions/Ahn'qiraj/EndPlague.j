library EndPlague initializer OnInit

    globals
        trigger EndPlagueTrigger = null
    endglobals

    private function Actions takes nothing returns nothing
    	call DisableTrigger( gg_trg_Plague_Cauldrons )
    	call DisableTrigger( gg_trg_Plague_Command )
    	call DisableTrigger( gg_trg_Plague_Conversion )
    	call DisableTrigger( gg_trg_Plague_Timer )
    	call DisableTrigger( gg_trg_Plague_Turn_On )
    endfunction

    private function OnInit takes nothing returns nothing
        set EndPlagueTrigger = CreateTrigger()
        call TriggerAddCondition(EndPlagueTrigger, Condition(function Actions))
    endfunction

endlibrary
