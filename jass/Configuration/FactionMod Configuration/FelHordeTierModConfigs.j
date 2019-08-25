library FelHordeTierModConfigs initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Note that the Fel Horde starts with -1 in both Tier 2 options, so they need both of the below to unlock it
        
        //Tier 1 research complete
        set f = FactionMod.create(39)
             call f.registerObjectLimit('R047', 1)          //Shadowmoon Clan Remnants
             call f.registerObjectLimit('R036', 1)          //Dragonmaw Clan

        //Stormwind and The Great Forge destroyed
        set f = FactionMod.create(40)
             call f.registerObjectLimit('R047', 1)          //Shadowmoon Clan Remnants
             call f.registerObjectLimit('R036', 1)          //Dragonmaw Clan
             
    endfunction
    
endlibrary
