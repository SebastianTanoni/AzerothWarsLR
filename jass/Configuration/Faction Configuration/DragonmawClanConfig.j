library DragonmawClanConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(23)
            //Fel Horde tier 2 research, mutually exclusive with Shadowmoon Clan Reformed
            call f.registerObjectLimit('nbwm', 2)              //Ancient Black Dragon
            call f.registerObjectLimit('nbdk', 2)              //Black Drake
            call f.registerObjectLimit('o00H', -UNLIMITED)     //Shattered Hand Executioner
            call f.registerObjectLimit('nbdm', UNLIMITED)      //Blackrock Dragonspawn
    endfunction
    
endlibrary
