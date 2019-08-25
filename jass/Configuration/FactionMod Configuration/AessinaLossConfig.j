library AessinaLossConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(18)
            call f.registerObjectLimit('e009', -UNLIMITED)      //Tortolla
    endfunction
    
endlibrary
