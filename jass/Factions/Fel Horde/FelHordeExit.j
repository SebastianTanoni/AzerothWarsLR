library FelHordeExit initializer OnInit

    globals
        trigger FelHordeExitTrigger = null
    endglobals

    private function Actions takes nothing returns nothing
    	call DisableTrigger( gg_trg_Demon_Gate_1_Spawn)
        call DisableTrigger( gg_trg_Demon_Gate_2_Spawn)
        call DisableTrigger( gg_trg_Demon_Gate_3_Spawn)
        call DisableTrigger( gg_trg_Demon_Gate_Turn_On)
        call DisableTrigger( gg_trg_Demon_Gate_Turn_Off)
    endfunction

    private function OnInit takes nothing returns nothing
        set FelHordeExitTrigger = CreateTrigger()
        call TriggerAddCondition(FelHordeExitTrigger, Condition(function Actions))
    endfunction

endlibrary
