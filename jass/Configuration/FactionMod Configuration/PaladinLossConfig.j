library PaladinLossConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(26)
            call f.registerObjectLimit('h00F', -UNLIMITED)      //Lordaeron Paladin
    endfunction
    
endlibrary
