library InsurgentsConfig initializer OnInit requires FactionMod

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(5)
        //Disabling default Legion data
            //Strutures
            call f.registerObjectLimit('u017', -UNLIMITED)   //Nether Portal
            call f.registerObjectLimit('u00H', -UNLIMITED)   //Legion Defensive Pylon
            call f.registerObjectLimit('u00I', -UNLIMITED)   //Improved Defensive Pylon
            call f.registerObjectLimit('u015', -UNLIMITED)   //Hellforge
            call f.registerObjectLimit('u00F', -UNLIMITED)   //Nazrethim Summoning Spire
            call f.registerObjectLimit('n040', -UNLIMITED)   //Mo'arg Forge

            //Units
            call f.registerObjectLimit('u00D', -UNLIMITED)   //Eredar Summoner
            call f.registerObjectLimit('u007', -6)           //Dreadlord
            call f.registerObjectLimit('h027', -UNLIMITED)   //Shadow Priest
            call f.registerObjectLimit('n04p', -UNLIMITED)   //Warlock
            call f.registerObjectLimit('n04k', -UNLIMITED)   //Succubus
            call f.registerObjectLimit('nvdw', -UNLIMITED)   //Voidwalker
            call f.registerObjectLimit('n04J', -UNLIMITED)   //Felstalker
            call f.registerObjectLimit('o01G', -12)          //Orc Cavalry
            call f.registerObjectLimit('o01F', -12)          //Beserker       

            //Upgrades
            call f.registerObjectLimit('R02C', -UNLIMITED)   //Acute SEnsors
            call f.registerObjectLimit('R02A', -UNLIMITED)   //Chaos Infusion
            call f.registerObjectLimit('R003', -UNLIMITED)   //Nether Strands
            call f.registerObjectLimit('R028', -UNLIMITED)   //Shadow Priest Adept Training
            call f.registerObjectLimit('R04G', -UNLIMITED)   //Sight of Sargeras
            call f.registerObjectLimit('R027', -UNLIMITED)   //Warlock Adept Training

            //Masteries
            call f.registerObjectLimit('R020', -UNLIMITED)   //Demonic Power Mastery
            call f.registerObjectLimit('R01N', -UNLIMITED)   //Mo'arg Battle Mastery
            call f.registerObjectLimit('R01M', -UNLIMITED)   //Nazrethim Elite Mastery
            
        //Enabling undead Legion data      
            //Structures
            call f.registerObjectLimit('unpl', UNLIMITED)   //Necropolis   
            call f.registerObjectLimit('unp1', UNLIMITED)   //Halls of the Dead 
            call f.registerObjectLimit('unp2', UNLIMITED)   //Black Citadel 
            call f.registerObjectLimit('uzig', UNLIMITED)   //Ziggurat 
            call f.registerObjectLimit('uzg1', UNLIMITED)   //Spirit Tower 
            call f.registerObjectLimit('uzg2', UNLIMITED)   //Nerubian Tower 
            call f.registerObjectLimit('uaod', UNLIMITED)   //Altar of Darkness 
            call f.registerObjectLimit('usep', UNLIMITED)   //Crypt 
            call f.registerObjectLimit('ugrv', UNLIMITED)   //Graveyard 
            call f.registerObjectLimit('uslh', UNLIMITED)   //Slaughterhouse 
            call f.registerObjectLimit('ubon', UNLIMITED)   //Boneyard      
            call f.registerObjectLimit('utom', UNLIMITED)   //Tomb of Relics   
            call f.registerObjectLimit('ushp', UNLIMITED)   //Undead Shipyard
            call f.registerObjectLimit('u002', UNLIMITED)   //Improved Spirit Tower
            call f.registerObjectLimit('u003', UNLIMITED)   //Improved Nerubian Tower
            
            //Units
            call f.registerObjectLimit('uaco', UNLIMITED)   //Acolyte
            call f.registerObjectLimit('ushd', UNLIMITED)   //Shade
            call f.registerObjectLimit('ugho', UNLIMITED)   //Ghoul
            call f.registerObjectLimit('nzom', UNLIMITED)   //Zombie
            call f.registerObjectLimit('uabo', UNLIMITED)   //Abomination
            call f.registerObjectLimit('umtw', 6)           //Meat Wagon
            call f.registerObjectLimit('ucry', UNLIMITED)   //Crypt Fiend
            call f.registerObjectLimit('ugar', 8)           //Gargoyle
            call f.registerObjectLimit('uban', UNLIMITED)   //Banshee
            call f.registerObjectLimit('unec', UNLIMITED)   //Necromancer
            call f.registerObjectLimit('uobs', 2)           //Obsidian Statue
            call f.registerObjectLimit('ufro', 4)           //Frost Wyrm
            call f.registerObjectLimit('nska', UNLIMITED)   //Skeleton Archer
            call f.registerObjectLimit('u01A', 6)           //Dreadlord Insurgent
            call f.registerObjectLimit('ubsp', 8)           //Destroyer
            
            //Upgrades
            call f.registerObjectLimit('Ruba', UNLIMITED)   //Banshee Adept Training
            call f.registerObjectLimit('Rubu', UNLIMITED)   //Burrow
            call f.registerObjectLimit('Ruex', UNLIMITED)   //Exhume Corpses
            call f.registerObjectLimit('Rufb', UNLIMITED)   //Freezing Breath
            call f.registerObjectLimit('Rugf', UNLIMITED)   //Ghoul Frenzy
            call f.registerObjectLimit('Ruwb', UNLIMITED)   //Web 
        
            //Masteries
            call f.registerObjectLimit('R00Q', UNLIMITED)   //Frozen Death Mastery
            call f.registerObjectLimit('R01X', UNLIMITED)   //Plague Engineering Mastery            
    endfunction
    
endlibrary
