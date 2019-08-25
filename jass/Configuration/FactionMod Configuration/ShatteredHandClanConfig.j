library ShatteredHandClanConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(22)
            //Fel Horde tier 1 research, mutually exclusive with Shadow Council Reformed
            call f.registerObjectLimit('o01H', 6)              //Burning Bladelord
            call f.registerObjectLimit('o00H', -UNLIMITED)     //Burning Blademaster
            call f.registerObjectLimit('o01L', 6)              //Shattered Hand Executioner
            call f.registerObjectLimit('ogrk', 12)             //Forest Troll Warlord
    endfunction
    
endlibrary
