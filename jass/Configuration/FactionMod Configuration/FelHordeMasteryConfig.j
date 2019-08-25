library FelHordeMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Fel Blood Mastery
        set f = FactionMod.create(32)
            call f.registerObjectLimit('ndfl', 1)   //Defiled Fountain of Life
                 
    endfunction
    
endlibrary                                         
