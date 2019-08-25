library GoldrinnLossConfig initializer OnInit requires FactionMod
    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(20)
            call f.registerObjectLimit('n08C', -UNLIMITED)      //Goldrinn
    endfunction
    
endlibrary
