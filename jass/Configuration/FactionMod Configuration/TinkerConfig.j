library TinkerConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(24)
            call f.registerObjectLimit('h03R', UNLIMITED)      //Tinker
    endfunction
    
endlibrary
