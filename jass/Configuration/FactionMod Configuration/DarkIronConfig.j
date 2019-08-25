library DarkIronConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(12)
            call f.registerObjectLimit('n02D', UNLIMITED)      //Dark Iron War Golem
            call f.registerObjectLimit('h041', 12)             //Fire Tank
    endfunction
    
endlibrary
