library SatyrConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(6)
            //Structures
            call f.registerObjectLimit('ncta', UNLIMITED)   //Corrupted Tree of Ages
            call f.registerObjectLimit('ncaw', UNLIMITED)   //Corrupted Ancient of War

            //Units
            call f.registerObjectLimit('nstl', UNLIMITED)   //Satyr Soulstealer
            call f.registerObjectLimit('n03V', 4)           //Corrupted Broodmother
            call f.registerObjectLimit('n03T', 2)           //Corrupted Guardian
            call f.registerObjectLimit('nsty', UNLIMITED)   //Satyr Warrior
            call f.registerObjectLimit('nsat', UNLIMITED)   //Satyr Trickster
            call f.registerObjectLimit('nsth', 4)           //Satyr Hellcaller

            //Upgrades

            //Masteries         
    endfunction
    
endlibrary
