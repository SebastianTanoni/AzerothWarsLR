library QuelthalasMobilizationConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(2)
            call f.registerObjectLimit('hhes', -UNLIMITED)      //Elven Warrior
            call f.registerObjectLimit('nbel', UNLIMITED)       //Blood Elf Warrior
            call f.registerObjectLimit('hspt', 12)              //Spell Breaker
            call f.registerObjectLimit('n048', 6)               //Blood Mage
            call f.registerObjectLimit('nggr', 4)               //Granite Golem       
    endfunction
    
endlibrary
