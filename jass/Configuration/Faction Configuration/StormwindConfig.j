



library StormwindConfig initializer OnInit requires Faction

  globals
    constant integer FACTION_STORMWIND = 10
  endglobals

    private function OnInit takes nothing returns nothing
        local Faction f
        
        set f = Faction.create(FACTION_STORMWIND,"Stormwind", PLAYER_COLOR_AQUA, "|CFF106246","ReplaceableTextures\\CommandButtons\\BTNKnight.blp")
            //Structures
            call f.registerObjectLimit('htow', UNLIMITED)   //Town Hall
            call f.registerObjectLimit('hkee', UNLIMITED)   //Keep
            call f.registerObjectLimit('hcas', UNLIMITED)   //Castle
            call f.registerObjectLimit('hhou', UNLIMITED)   //Farm
            call f.registerObjectLimit('halt', UNLIMITED)   //Altar of Kings
            call f.registerObjectLimit('hbar', UNLIMITED)   //Barracks
            call f.registerObjectLimit('hlum', UNLIMITED)   //Lumber Mill
            call f.registerObjectLimit('hbla', UNLIMITED)   //Blacksmith
            call f.registerObjectLimit('h056', UNLIMITED)   //Workshop (Stormwind)
            call f.registerObjectLimit('hars', UNLIMITED)   //Arcane Sanctum
            call f.registerObjectLimit('hwtw', UNLIMITED)   //Scout Tower
            call f.registerObjectLimit('hgtw', UNLIMITED)   //Guard Tower
            call f.registerObjectLimit('h006', UNLIMITED)   //Guard Tower (Improved)
            call f.registerObjectLimit('hctw', UNLIMITED)   //Cannon Tower
            call f.registerObjectLimit('h007', UNLIMITED)   //Cannon Tower (Improved)
            call f.registerObjectLimit('n07T', UNLIMITED)   //Marketplace
            call f.registerObjectLimit('hshy', UNLIMITED)   //Alliance Shipyard
            call f.registerObjectLimit('hatw', UNLIMITED)   //Arcane Tower
            call f.registerObjectLimit('h008', UNLIMITED)   //Arcane Tower (Improved)            

            //Units
            call f.registerObjectLimit('hpea', UNLIMITED)   //Peasant
            call f.registerObjectLimit('h02O', UNLIMITED)   //Militia
            call f.registerObjectLimit('h009', UNLIMITED)   //Brigadier
            call f.registerObjectLimit('h03K', 12)          //Marshal
            call f.registerObjectLimit('h00A', UNLIMITED)   //Spearman
            call f.registerObjectLimit('h01B', UNLIMITED)   //Outriders
            call f.registerObjectLimit('h05F', 6)           //Stormwind Champion
            call f.registerObjectLimit('h00J', UNLIMITED)   //Clergyman
            call f.registerObjectLimit('n06N', 6)           //Zeppelin
            call f.registerObjectLimit('n093', UNLIMITED)   //Chaplain
            call f.registerObjectLimit('hbot', UNLIMITED)   //Alliance Transport Ship
            call f.registerObjectLimit('hdes', UNLIMITED)   //Alliance Frigate
            call f.registerObjectLimit('hbsh', 12)          //Alliance Battle Ship             

            //Upgrades
            call f.registerObjectLimit('R02E', UNLIMITED)   //Chaplain Adept Training
            call f.registerObjectLimit('R005', UNLIMITED)   //Clergyman Adept Training
            call f.registerObjectLimit('R00K', UNLIMITED)   //Power Infusion
            call f.registerObjectLimit('R02B', UNLIMITED)   //Steel Plating
            call f.registerObjectLimit('Rhan', UNLIMITED)   //Animal War Training
            call f.registerObjectLimit('Rhlh', UNLIMITED)   //Improved Lumber Harvesting
            call f.registerObjectLimit('Rhac', UNLIMITED)   //Improved Masonry
            call f.registerObjectLimit('Rhse', UNLIMITED)   //Magic Sentry
            
            //Tier researches
            call f.registerObjectLimit('R02S', UNLIMITED)   //Cathedral of Light
            call f.registerObjectLimit('R02U', UNLIMITED)   //SI:7 Headquarters            
            call f.registerObjectLimit('R02K', UNLIMITED)   //Wizard's Sanctum
            call f.registerObjectLimit('R02V', UNLIMITED)   //Champion's Hall
            
            //Masteries
            call f.registerObjectLimit('R01C', UNLIMITED)   //Arcane Mastery
            call f.registerObjectLimit('R01U', UNLIMITED)   //Foot Soldier Prowess Mastery
            call f.registerObjectLimit('R00Z', UNLIMITED)   //Shipwright Guild Mastery
            
            //Paths
    endfunction
    
endlibrary

