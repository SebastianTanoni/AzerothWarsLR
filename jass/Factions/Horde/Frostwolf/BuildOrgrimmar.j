library BuildOrgrimmar initializer OnInit

    globals
        private constant real ORGRIMMAR_TIMER = 600.     //How long it takes for Orgrimmar to be built instantly
        private constant integer GOLD = 100
        private constant integer LUMBER = 350

        private trigger TriggerEntersRegion = null
        private trigger TriggerTimer = null
    endglobals

    private function BuildOrgrimmar takes nothing returns nothing
        local group tempGroup = CreateGroup()
        local unit u
        local Person tempPerson = 0
        local player recipient = Player(PLAYER_NEUTRAL_AGGRESSIVE)

        if PersonsByFaction[7] != 0 then                        //Frostwolf
            set tempPerson = PersonsByFaction[7]
            set recipient = tempPerson.getPlayer()          
        elseif PersonsByFaction[8] != 0 then                    //Warsong
            set tempPerson = PersonsByFaction[8]
            set recipient = tempPerson.getPlayer()                     
        endif

        //Transfer all Neutral Passive units in Orgrimmar to one of the above factions
        call GroupEnumUnitsInRect(tempGroup, gg_rct_Orgrimmar, null)
        set u = FirstOfGroup(tempGroup)
        loop
        exitwhen u == null
            if GetOwningPlayer(u) == Player(PLAYER_NEUTRAL_PASSIVE) then
                call SetUnitInvulnerable(u, false)
                call SetUnitOwner(u, recipient, true)
            endif
            call GroupRemoveUnit(tempGroup, u)
            set u = FirstOfGroup(tempGroup)
        endloop
        //Give resources and display message
        call AdjustPlayerStateBJ(GOLD, recipient, PLAYER_STATE_RESOURCE_GOLD )
        call AdjustPlayerStateBJ(LUMBER, recipient, PLAYER_STATE_RESOURCE_LUMBER )  
        call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Thrall has established Orgrimmar.")      

        //Cleanup
        call DestroyGroup (TempGroup)
        call DestroyTrigger(TriggerEntersRegion)      
        call DestroyTrigger(TriggerTimer)  
        set recipient = null
        set tempGroup = null
    endfunction

    private function TimerEnds takes nothing returns nothing
        call BuildOrgrimmar()
    endfunction

    private function EntersRegion takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit()) == 'Othr' then   //This is Thrall
            call BuildOrgrimmar()
        endif
    endfunction    

    private function OnInit takes nothing returns nothing
        set TriggerEntersRegion = CreateTrigger()
        call TriggerRegisterEnterRectSimple(TriggerEntersRegion, gg_rct_Orgrimmar)
        call TriggerAddCondition(TriggerEntersRegion, Condition(function EntersRegion))

        set TriggerTimer = CreateTrigger()
        call TriggerRegisterTimerEvent(TriggerTimer, ORGRIMMAR_TIMER, false)
        call TriggerAddCondition(TriggerTimer, Condition(function TimerEnds))        
    endfunction

endlibrary