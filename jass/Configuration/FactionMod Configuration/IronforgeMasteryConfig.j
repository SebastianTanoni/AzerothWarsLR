library IronforgeMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Fortification Mastery
        set f = FactionMod.create(33)
            call f.registerObjectLimit('h010', UNLIMITED)   //Sentinel Tower
                 
    endfunction
    
endlibrary                                         
