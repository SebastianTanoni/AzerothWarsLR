library StormwindLossConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(11)
            call f.registerObjectLimit('h05F', -UNLIMITED)      //Stormwind Champion
    endfunction
    
endlibrary
