library UrsocLossConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(19)
            call f.registerObjectLimit('u05F', -UNLIMITED)      //Ursoc
    endfunction
    
endlibrary
