

library ShadowmoonClanRemnantsConfig initializer OnInit requires FactionMod
    //Fel Horde tier 2 research, mutually exclusive with Dragonmaw Clan
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(15)
            call f.registerObjectLimit('nina', 4)      //Infernal Juggernaut
            call f.registerObjectLimit('n06Y', 1)      //Dimensional Gateway
            call f.registerObjectLimit('o01V', 4)      //Eredar Elder Warlock
    endfunction
    
endlibrary
