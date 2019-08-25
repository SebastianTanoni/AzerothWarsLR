library SteamTankConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(10)
            call f.registerObjectLimit('h01P', 3)           //Steam Tank
            call f.registerObjectLimit('h03R', UNLIMITED)   //Tinker
    endfunction
    
endlibrary
