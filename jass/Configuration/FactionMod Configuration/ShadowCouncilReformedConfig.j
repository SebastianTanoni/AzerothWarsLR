library ShadowCouncilReformedConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(21)
            call f.registerObjectLimit('o01H', -UNLIMITED)     //Burning Bladelord
            call f.registerObjectLimit('o00H', -UNLIMITED)     //Burning Blademaster
            call f.registerObjectLimit('n086', 6)              //Death Knight
    endfunction
    
endlibrary
