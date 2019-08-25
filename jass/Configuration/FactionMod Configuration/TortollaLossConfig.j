library TortollaLossConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(17)
            call f.registerObjectLimit('e007', -UNLIMITED)      //Tortolla
    endfunction
    
endlibrary
