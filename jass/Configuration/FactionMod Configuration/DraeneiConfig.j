library DraeneiConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(24)
            call f.registerObjectLimit('ndh4', UNLIMITED)      //Draenei Haven
            call f.registerObjectLimit('ndrt', 6)              //Ashtongue Assassin
            call f.registerObjectLimit('ndrs', 6)              //Draenei Seer
            call f.registerObjectLimit('ndrn', UNLIMITED)      //Draenei Vindicator
            call f.registerObjectLimit('ndsa', 2)              //Salamander      
    endfunction
    
endlibrary
