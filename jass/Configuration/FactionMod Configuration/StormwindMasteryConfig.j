library StormwindMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Shipwright Guild Mastery
        set f = FactionMod.create(34)
            call f.registerObjectLimit('h060', 1)   //Arathor Flagship
            call f.registerObjectLimit('h024', UNLIMITED)   //Light House
            call f.registerObjectLimit('h061', UNLIMITED)   //Naval Outpost
                 
    endfunction
    
endlibrary                                         
