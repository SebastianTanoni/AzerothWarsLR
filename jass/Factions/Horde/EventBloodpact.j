library EventBloodpact

    globals
        private constant integer RESEARCH_BLOODPACT = 'R004'
    endglobals

    function DoBloodpact takes nothing returns nothing
        local Person tempPerson = 0

        //Frostwolf
        set tempPerson = PersonsByFaction[7]
        if PersonsByFaction[7] != 0 then
            call SetPlayerTechResearched(tempPerson.getPlayer(), RESEARCH_BLOODPACT, 1)
            call tempPerson.setFaction(17)
        endif

        //Warsong
        set tempPerson = PersonsByFaction[8]
        if PersonsByFaction[8] != 0 then
            call SetPlayerTechResearched(tempPerson.getPlayer(), RESEARCH_BLOODPACT, 1)
            call tempPerson.setFaction(18)
            if GetPlayerTechCount(tempPerson.getPlayer(), 'R02O', false) > 0 then   //Rite of Blood
                call tempPerson.applyFactionMod(9)
            endif
            if GetPlayerTechCount(tempPerson.getPlayer(), 'R02Q', false) > 0 then   //Rite of Strength
                call tempPerson.applyFactionMod(8)
            endif            
        endif
    endfunction

endlibrary