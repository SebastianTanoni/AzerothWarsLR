library NagaMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Beast Taming Mastery
        set f = FactionMod.create(31)
            call f.registerObjectLimit('ndsa', 1)   //Salamander
            call f.registerObjectLimit('nsgb', 1)   //Sea Giant Behemoth
            call f.registerObjectLimit('nahy', 1)   //Ancient Hydra
                 
    endfunction
    
endlibrary                                         
