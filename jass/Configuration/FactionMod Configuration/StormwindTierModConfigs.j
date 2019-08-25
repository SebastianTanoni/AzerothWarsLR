library StormwindTierModConfigs initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        //Used in Stormwind's extravagent tier system

        //Wizard's Sanctum
        set f = FactionMod.create(50)
             call f.registerObjectLimit('R03T', UNLIMITED)      //Electric Strike Ritual
             call f.registerObjectLimit('R03U', UNLIMITED)      //Solar Flare Ritual
             
        //Cathedral of Light
        set f = FactionMod.create(51)
            call f.registerObjectLimit('R03A', UNLIMITED)       //Focus In the Light
            call f.registerObjectLimit('R02W', UNLIMITED)       //Sanctuary of Light
             
        //SI:7 Headquarters
        set f = FactionMod.create(52)
            call f.registerObjectLimit('R03E', UNLIMITED)       //Sabo Training
            call f.registerObjectLimit('R038', UNLIMITED)       //Enforcer Training
             
        //Champion's Hall
        set f = FactionMod.create(53)
            call f.registerObjectLimit('R02Y', UNLIMITED)       //Battle Tactics
            call f.registerObjectLimit('R03D', UNLIMITED)       //Veteran Guard                               
        
        //Battle Tactics
        set f = FactionMod.create(54)
            call f.registerObjectLimit('h03K', -UNLIMITED)      //Marshal
            call f.registerObjectLimit('h014', 12)              //Marshal (Offensive)
            call f.registerObjectLimit('R03B', 1)               //Exploit Weakness
            call f.registerObjectLimit('R02Z', 1)               //Reflective Plating             

        //Veteran Guard
        set f = FactionMod.create(55)
            call f.registerObjectLimit('h03K', -UNLIMITED)      //Marshal
            call f.registerObjectLimit('h03U', 12)              //Marshal (Offensive)
            call f.registerObjectLimit('R03B', UNLIMITED)       //Exploit Weakness
            call f.registerObjectLimit('R02Z', UNLIMITED)       //Reflective Plating   
             
        //Exploit Weakness
        set f = FactionMod.create(56)
            call f.registerObjectLimit('h04C',UNLIMITED)        //Swordsman
            call f.registerObjectLimit('h02O',-UNLIMITED)       //Militia
            call f.registerObjectLimit('R030', UNLIMITED)       //Code of Chivalry
            call f.registerObjectLimit('R031', UNLIMITED)       //Elven Refugees             
             
        //Reflective Plating
        set f = FactionMod.create(57)
            call f.registerObjectLimit('h04C',UNLIMITED)        //Swordsman
            call f.registerObjectLimit('h02O',-UNLIMITED)       //Militia
            call f.registerObjectLimit('R030', UNLIMITED)       //Code of Chivalry
            call f.registerObjectLimit('R031', UNLIMITED)       //Elven Refugees             
             
        //Code of Chivalry
        set f = FactionMod.create(58)
             call f.registerObjectLimit('h01B', UNLIMITED)      //Outrider
             call f.registerObjectLimit('h054', -UNLIMITED)     //Stormwind Knight                
             
        //Elven Refugees
        set f = FactionMod.create(59)
             call f.registerObjectLimit('h00A', -UNLIMITED)     //Spearman
             call f.registerObjectLimit('h05N', UNLIMITED)      //Marksman       
             
        //Saboteur Training
        set f = FactionMod.create(60)  
            call f.registerObjectLimit('h009', -12)             //Brigadier
            call f.registerObjectLimit('h03Z', 12)              //Saboteur      
            call f.registerObjectLimit('R03F', UNLIMITED)       //Assassin Training
            call f.registerObjectLimit('R03K', UNLIMITED)       //Skirmisher Training
             
        //Enforcer Training
        set f = FactionMod.create(61)
            call f.registerObjectLimit('h009', -12)             //Brigadier
            call f.registerObjectLimit('h05M', 12)              //Enforcer
            call f.registerObjectLimit('R03F', UNLIMITED)       //Assassin Training
            call f.registerObjectLimit('R03K', UNLIMITED)       //Skirmisher Training 
             
        //Assassin Training
        set f = FactionMod.create(62)
            call f.registerObjectLimit('h00A', -UNLIMITED)      //Spearman
            call f.registerObjectLimit('h05T', UNLIMITED)       //Assassin
            call f.registerObjectLimit('R032', UNLIMITED)       //SI:7 Elite Training
             
        //Skirmisher Training
        set f = FactionMod.create(63)
            call f.registerObjectLimit('h00A', -UNLIMITED)      //Spearman
            call f.registerObjectLimit('h05U', UNLIMITED)       //Skirmisher       
            call f.registerObjectLimit('R032', UNLIMITED)       //SI:7 Elite Training
            
        //SI:7 Elite
        set f = FactionMod.create(64)
            call f.registerObjectLimit('h05V', 6)               //SI:7 Agent  
               
        //Focus In The Light
        set f = FactionMod.create(65)
            call f.registerObjectLimit('R02X', UNLIMITED)       //Holy Mending   
            call f.registerObjectLimit('R03C', UNLIMITED)       //Runic Constitution  
             
        //Sanctuary of Light
        set f = FactionMod.create(66)
            call f.registerObjectLimit('R02X', UNLIMITED)       //Holy Mending   
            call f.registerObjectLimit('R03C', UNLIMITED)       //Runic Constitution  
             
        //Runic Constitution
        set f = FactionMod.create(67)
            call f.registerObjectLimit('R03R', UNLIMITED)       //Reginald Windsor 
            call f.registerObjectLimit('R03P', UNLIMITED)       //Archbishop Benedictus    
            
        //Holy Mending
        set f = FactionMod.create(68)
            call f.registerObjectLimit('R03R', UNLIMITED)       //Reginald Windsor 
            call f.registerObjectLimit('R03P', UNLIMITED)       //Archbishop Benedictus                
             
        //Archbishop Benedictus Aid
        set f = FactionMod.create(69)
            call f.registerObjectLimit('n09N', 6)               //Bishop of Light
                                                                      
        //Reginald Windsor Aid
        set f = FactionMod.create(70)
            call f.registerObjectLimit('n09N', 6)               //Bishop of Light
                  
        //Electric Strike Ritual
        set f = FactionMod.create(71)
            call f.registerObjectLimit('R03V', UNLIMITED)       //Stromgarde
            call f.registerObjectLimit('R03W', UNLIMITED)       //Honor Hold            
             
        //Solar Flare Ritual
        set f = FactionMod.create(72)
            call f.registerObjectLimit('R03V', UNLIMITED)       //Stromgarde
            call f.registerObjectLimit('R03W', UNLIMITED)       //Honor Hold         
             
        //Mages of Stromgarde
        set f = FactionMod.create(73)
            call f.registerObjectLimit('R03X', UNLIMITED)       //High Sorcerer Andromath
            call f.registerObjectLimit('R03Y', UNLIMITED)       //Katrana Prestor     
             
        //Knowledge of Honor Hold
        set f = FactionMod.create(74)
            call f.registerObjectLimit('R03X', UNLIMITED)       //High Sorcerer Andromath
            call f.registerObjectLimit('R03Y', UNLIMITED)       //Katrana Prestor     
             
        //High Sorcerer Andromath Aid
        set f = FactionMod.create(75)
            call f.registerObjectLimit('n05L', 6)               //Conjurer
             
        //Katrana Prestor Aid
        set f = FactionMod.create(76)
            call f.registerObjectLimit('n05L', 6)               //Conjurer                                                                                                                                         
             
    endfunction
    
endlibrary
