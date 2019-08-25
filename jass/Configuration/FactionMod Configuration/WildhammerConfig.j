
library WildhammerConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(13)
            call f.registerObjectLimit('n04F', UNLIMITED)      //Wildhammer War Golem
            call f.registerObjectLimit('hgry', 3)              //Gryphon Rider
    endfunction
    
endlibrary
