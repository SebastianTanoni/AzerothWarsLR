library LegionMasteryConfig initializer OnInit requires FactionMod

    globals
        constant integer FACTIONMOD_MASTERY_INFERNO = 78
        constant integer FACTIONMOD_MASTERY_DOOM = 79
        constant integer FACTIONMOD_MASTERY_VOID = 80
        constant integer FACTIONMOD_MASTERY_FELSTEEL = 81
    endglobals

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Inferno Mastery
        set f = FactionMod.create(FACTIONMOD_MASTERY_INFERNO)
            call f.registerObjectLimit('ninf', 4)   //Infernal

        //Doom Mastery
        set f = FactionMod.create(FACTIONMOD_MASTERY_DOOM)
            call f.registerObjectLimit('n04O', 2)   //Doom Guard

        //Void Mastery     
        set f = FactionMod.create(FACTIONMOD_MASTERY_VOID)
            call f.registerObjectLimit('n04U', 2)   //Nether Dragon

        //Felsteel Mastery     
        set f = FactionMod.create(FACTIONMOD_MASTERY_FELSTEEL)
            call f.registerObjectLimit('n04L', 2)   //Infernal Juggernaut 
            call f.registerObjectLimit('u00K', 2)   //Fel Reaver   
                 
    endfunction
    
endlibrary                                         
