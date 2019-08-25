//Enables and disables the Legion menu when a player takes the Burning Legion faction

library DemonGroupMenuVisibility initializer OnInit requires DemonGroupMenu, Event, Persons, LegionConfig

    private function ChangesFaction takes nothing returns nothing
        if GetTriggerPerson().getPlayer() == GetLocalPlayer() then
            if GetTriggerPerson().getFaction().getId() == FACTION_LEGION then
                call BlzFrameSetVisible(LegionBarBackdrop, true)
            elseif GetChangingPersonPrevFaction().getId() == FACTION_LEGION then
                call BlzFrameSetVisible(LegionBarBackdrop, false)
            endif
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        local Person tempPerson = Persons[GetPlayerId(GetLocalPlayer())]
        call OnPersonFactionChange.register(trig)
        call TriggerAddCondition(trig, Condition(function ChangesFaction))

        if tempPerson != 0 then 
            if tempPerson.getFaction().getId() == FACTION_LEGION then
                call BlzFrameSetVisible(LegionBarBackdrop, true)
            endif
        endif
    endfunction    

endlibrary