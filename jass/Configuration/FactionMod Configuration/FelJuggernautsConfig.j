
library FelJuggernautsConfig initializer OnInit requires FactionMod
    //Awarded to the Fel Horde when they destroy Thelsamar and Darkshire
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(14)
            call f.registerObjectLimit('nina', 2)      //Infernal Juggernaut
    endfunction
    
endlibrary
