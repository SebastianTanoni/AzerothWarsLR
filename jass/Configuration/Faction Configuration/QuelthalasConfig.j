library QuelthalasConfig initializer OnInit requires Faction

    globals
        constant integer FACTION_QUELTHELAS = 6
    endglobals

    private function OnInit takes nothing returns nothing
        local Faction f
        
        set f = Faction.create(FACTION_QUELTHELAS,"Quel'thelas", PLAYER_COLOR_CYAN, "|C0000FFFF","ReplaceableTextures\\CommandButtons\\BTNSylvanusWindrunner.blp")
            call f.setAbsenceResearch('R04L')
            //Structures
            call f.registerObjectLimit('htow', UNLIMITED)   //Town Hall
            call f.registerObjectLimit('hkee', UNLIMITED)   //Keep
            call f.registerObjectLimit('hcas', UNLIMITED)   //Castle
            call f.registerObjectLimit('halt', UNLIMITED)   //Altar of Kings
            call f.registerObjectLimit('hlum', UNLIMITED)   //Lumber Mill
            call f.registerObjectLimit('hbla', UNLIMITED)   //Blacksmith
            call f.registerObjectLimit('hars', UNLIMITED)   //Arcane Sanctum
            call f.registerObjectLimit('hwtw', UNLIMITED)   //Scout Tower
            call f.registerObjectLimit('hatw', UNLIMITED)   //Arcane Tower
            call f.registerObjectLimit('h008', UNLIMITED)   //Arcane Tower (Improved)
            call f.registerObjectLimit('negt', UNLIMITED)   //High Elven Guard Tower
            call f.registerObjectLimit('n003', UNLIMITED)   //High Elven Guard Tower (Improved)
            call f.registerObjectLimit('h04V', UNLIMITED)   //Arcane Vault (Elven)
            call f.registerObjectLimit('nheb', UNLIMITED)   //High Elven Barracks
            call f.registerObjectLimit('hshy', UNLIMITED)   //Alliance Shipyard
            call f.registerObjectLimit('nefm', UNLIMITED)   //Elven Farm

            //Units
            call f.registerObjectLimit('nbee', UNLIMITED)   //Elven Worker
            call f.registerObjectLimit('hbot', UNLIMITED)   //Alliance Transport Ship
            call f.registerObjectLimit('hdes', UNLIMITED)   //Alliance Frigate
            call f.registerObjectLimit('hbsh', 12)          //Alliance Battle Ship 
            call f.registerObjectLimit('hhes', UNLIMITED)   //Elven Warrior
            call f.registerObjectLimit('hmpr', UNLIMITED)   //Priest
            call f.registerObjectLimit('hsor', UNLIMITED)   //Sorceress
            call f.registerObjectLimit('hdhw', 6)           //Dragonhawk Rider
            call f.registerObjectLimit('nhea', UNLIMITED)   //Archer
            call f.registerObjectLimit('e008', 8)           //Elven Ballista
            call f.registerObjectLimit('n00A', 6)           //Farstrider
            call f.registerObjectLimit('n063', 12)          //Magus           

            //Upgrades
            call f.registerObjectLimit('R01S', UNLIMITED)   //Aimed Shot
            call f.registerObjectLimit('R00G', UNLIMITED)   //Feint
            call f.registerObjectLimit('R01R', UNLIMITED)   //Improved Bows
            call f.registerObjectLimit('R029', UNLIMITED)   //Magus Adept Training
            call f.registerObjectLimit('R00K', UNLIMITED)   //Power Infusion
            call f.registerObjectLimit('Rhcd', UNLIMITED)   //Cloud
            call f.registerObjectLimit('Rhss', UNLIMITED)   //Control Magic
            call f.registerObjectLimit('Rhlh', UNLIMITED)   //Improved Lumber Harvesting
            call f.registerObjectLimit('Rhac', UNLIMITED)   //Improved Masonry
            call f.registerObjectLimit('Rhse', UNLIMITED)   //Magic Sentry
            call f.registerObjectLimit('Rhpt', UNLIMITED)   //Priest Adept Training
            call f.registerObjectLimit('Rhst', UNLIMITED)   //Sorceress Adept Training
            

            //Masteries
            call f.registerObjectLimit('R01A', UNLIMITED)   //Arcane Empowerment
            call f.registerObjectLimit('R00T', UNLIMITED)   //Archery Mastery
            call f.registerObjectLimit('R00H', UNLIMITED)   //Blood Elf Mastery
            
            //Paths
            call f.registerObjectLimit('R041', UNLIMITED)   //Blood Elves Path
            call f.registerObjectLimit('R046', UNLIMITED)   //Quel'thelas Full Mobilization
            call f.registerObjectLimit('R049', UNLIMITED)   //Unlock Naga Early
    endfunction
    
endlibrary

