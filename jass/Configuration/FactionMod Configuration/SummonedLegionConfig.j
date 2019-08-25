library SummonedLegionConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(4)
            call f.registerObjectLimit('n04U', 4)              //Nether Dragon
            call f.registerObjectLimit('n04K', UNLIMITED)      //Succubus
            call f.registerObjectLimit('ninf', 12)             //Infernal
            call f.registerObjectLimit('n04H', UNLIMITED)      //Felguard
            call f.registerObjectLimit('n04I', 12)             //Overlord
            call f.registerObjectLimit('n04J', UNLIMITED)      //Fel Stalker
            call f.registerObjectLimit('n04L', 6)              //Infernal Juggernaut
            call f.registerObjectLimit('r02D', UNLIMITED)      //Mo'arg Constitution
            call f.registerObjectLimit('n04O', 6)              //Doom Guard
            call f.registerObjectLimit('ndmg', UNLIMITED)      //Demon Gate
            call f.registerObjectLimit('o01V', 4)              //Eredar Elder Warlock
            call f.registerObjectLimit('n04T', UNLIMITED)      //Nether Dragon Roost

    endfunction
    
endlibrary
