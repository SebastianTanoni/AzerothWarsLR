library ScarletCrusadeConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(0)
            call f.registerObjectLimit('h06C', UNLIMITED)       //Halls of Glory 
            call f.registerObjectLimit('h066', UNLIMITED)       //Scarlet Zealot
            call f.registerObjectLimit('h069', UNLIMITED)       //Scarlet Battlemage
            call f.registerObjectLimit('h065', UNLIMITED)       //Scarlet Crusader Knight
            call f.registerObjectLimit('h067', 8)               //Scarlet Paladin
            call f.registerObjectLimit('h00T', UNLIMITED)       //Scarlet Monastery
            call f.registerObjectLimit('h06A', UNLIMITED)       //Inquisitor
            call f.registerObjectLimit('h06B', 6)               //Grand Crusader
            call f.registerObjectLimit('R04F', UNLIMITED)       //Scarlet Mage Initiate Training
            call f.registerObjectLimit('e011', 8)               //Gryphon Knight
            
            call f.registerObjectLimit('hkni', -UNLIMITED)       //Knight
            call f.registerObjectLimit('h00F', -UNLIMITED)       //Lordaeron Paladin
            
    endfunction
    
endlibrary
