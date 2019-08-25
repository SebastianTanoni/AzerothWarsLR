library BloodElfModConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(3)
            call f.registerObjectLimit('hhes', -UNLIMITED)      //Elven Warrior
            call f.registerObjectLimit('nbel', UNLIMITED)       //Blood Elf Warrior
            call f.registerObjectLimit('hspt', 12)              //Spell Breaker
            call f.registerObjectLimit('n048', 6)               //Blood Mage
            call f.registerObjectLimit('n00A', -6)              //Farstrider
            call f.registerObjectLimit('n063', -UNLIMITED)      //Magus 
            call f.registerObjectLimit('R029', -UNLIMITED)      //Magus Adept Training
    endfunction
    
endlibrary
