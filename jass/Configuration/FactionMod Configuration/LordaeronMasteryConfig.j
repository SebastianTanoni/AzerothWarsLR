library LordaeronMasteryConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Soldier Mastery
        set f = FactionMod.create(29)
            call f.registerObjectLimit('hfoo', -UNLIMITED)  //Footman
            call f.registerObjectLimit('h029', UNLIMITED)   //Veteran Footman
            
        //Empowerment Mastery
        set f = FactionMod.create(30)
            call f.registerObjectLimit('h00F', 2)           //Lordaeron Paladin
            call f.registerObjectLimit('h06B', 2)           //Grand Crusader
            call f.registerObjectLimit('h06D', 2)           //Silver Hand Veteran Paladin        
    endfunction
    
endlibrary                                         
