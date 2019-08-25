library SoloNightElfConfigs initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Sentinels solo path
        set f = FactionMod.create(37)
             call f.registerObjectLimit('eaoe', UNLIMITED)   //Ancient of Lore
             call f.registerObjectLimit('eaow', UNLIMITED)   //Ancient of Wind
             call f.registerObjectLimit('n05H', UNLIMITED)   //Furbolg
             call f.registerObjectLimit('edcm', UNLIMITED)   //Druid of the Claw
             call f.registerObjectLimit('edry', UNLIMITED)   //Dryad
             call f.registerObjectLimit('emtg', 12)          //Mountain Giant
             call f.registerObjectLimit('efdr', 6)           //Faerie Dragon 
             call f.registerObjectLimit('echm', 4)           //Chimaera
             call f.registerObjectLimit('edot', UNLIMITED)   //Druid of the Talon 
             call f.registerObjectLimit('e016', UNLIMITED)   //Druid of the Growth 

            //Druids solo path
        set f = FactionMod.create(38)
            call f.registerObjectLimit('eaom', UNLIMITED)   //Ancient of War
            call f.registerObjectLimit('e00V', UNLIMITED)   //Temple of Elune
            call f.registerObjectLimit('ebal', 6)           //Glaive Thrower
            call f.registerObjectLimit('ehpr', 6)           //Hippogryph Rider
            call f.registerObjectLimit('earc', UNLIMITED)   //Archer
            call f.registerObjectLimit('esen', UNLIMITED)   //Huntress
            call f.registerObjectLimit('e006', UNLIMITED)   //Priestess
            call f.registerObjectLimit('n06C', UNLIMITED)   //Trapper
            call f.registerObjectLimit('nwat', UNLIMITED)   //Nightblade  
    endfunction
    
endlibrary
