library Eventwildhammer

    //Ironforge gains Falstad Wildhammer, access to the Wildhammer FactionMod, and all units in Aerie Peak.
    //If Ironforge is not in the game, then Stormwind gains the units only.
    //This event is called by other events. 

    function DoWildhammer
        local player recipient = Player(PLAYER_NEUTRAL_AGGRESSIVE)

        if PersonsByFaction[4] != 0 then                    //Ironforge
            set tempPerson = PersonsByFaction[4]
            set recipient = tempPerson.getPlayer()
        elseif PersonsByFaction[10] != 0 then                 //Stormwind
            set tempPerson = PersonsByFaction[10]
            set recipient = tempPerson.getPlayer()                                
        endif
    endfunction

endlibrary