library TempestKeepConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Acquired when 
        set f = FactionMod.create(27)
            call f.registerObjectLimit('n048', 6)      //Blood Mage
            call f.registerObjectLimit('hspt', 12)     //Spell Breaker
    endfunction
    
endlibrary
