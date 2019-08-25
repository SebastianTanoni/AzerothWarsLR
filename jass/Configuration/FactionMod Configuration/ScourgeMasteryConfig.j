library ScourgeMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Plague Engineering Mastery
        set f = FactionMod.create(28)
            call f.registerObjectLimit('nfgl', 2)     //Flesh Golem
            call f.registerObjectLimit('umtw', 2)     //Meat Wagon
    endfunction
    
endlibrary
