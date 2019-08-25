library SentinelsMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Aerial Expertise Mastery
        set f = FactionMod.create(35)
            call f.registerObjectLimit('e00C', 4)   //Hippogryph Rider Captain
        
        //Lost Heritage Mastery
        set f = FactionMod.create(36)
            call f.registerObjectLimit('nnmg', 12)   //Redeemed Highborne         
                 
    endfunction
    
endlibrary                                         
