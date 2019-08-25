library KultirasConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(7)
            //Structures
            call f.registerObjectLimit('h06G', UNLIMITED)   //Kul Tiras Barracks

            //Units
            call f.registerObjectLimit('h01H', 6)           //Fleet Commander
            call f.registerObjectLimit('h06F', 24)          //Kul Tiras Rifleman
            call f.registerObjectLimit('o01A', 8)           //Naval Cannon

            //Upgrades

            //Masteries         
    endfunction
    
endlibrary
