


library BlackTempleLossConfig initializer OnInit requires FactionMod
    //Fel Horde loses the Black Temple
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(16)
            call f.registerObjectLimit('o01H', -UNLIMITED)      //Burning Bladelord
            call f.registerObjectLimit('o00H', -UNLIMITED)      //Burning Blademaster
            call f.registerObjectLimit('o01L', -UNLIMITED)      //Shattered Hand Executioner
    endfunction
    
endlibrary
