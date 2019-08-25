library SilvermoonLossConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(25)
            call f.registerObjectLimit('n00A', -UNLIMITED)      //Farstrider
    endfunction
    
endlibrary
