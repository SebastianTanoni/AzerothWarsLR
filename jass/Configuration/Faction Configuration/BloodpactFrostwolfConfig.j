
library BloodpactFrostwolfConfig initializer OnInit requires Faction

    private function OnInit takes nothing returns nothing
        local Faction f
        
        set f = Faction.create(17,"Frostwolf (Bloodpact)", PLAYER_COLOR_RED, "|c00ff0303","ReplaceableTextures\\CommandButtons\\BTNMannoroth.blp")
            call f.registerObjectLimit('ogre', UNLIMITED)   //Great Hall
            call f.registerObjectLimit('ostr', UNLIMITED)   //Stronghold
            call f.registerObjectLimit('ofrt', UNLIMITED)   //Fortress
            call f.registerObjectLimit('oalt', UNLIMITED)   //Altar of Storms
            call f.registerObjectLimit('obar', UNLIMITED)   //Barracks
            call f.registerObjectLimit('ofor', UNLIMITED)   //War Mill
            call f.registerObjectLimit('osld', UNLIMITED)   //Spirit Lodge
            call f.registerObjectLimit('obea', UNLIMITED)   //Bestiary
            call f.registerObjectLimit('otrb', UNLIMITED)   //Orc Burrow
            call f.registerObjectLimit('owtw', UNLIMITED)   //Watch Tower
            call f.registerObjectLimit('o002', UNLIMITED)   //Improved Watch Tower
            call f.registerObjectLimit('ovln', UNLIMITED)   //Voodoo Lounge
            call f.registerObjectLimit('oshy', UNLIMITED)   //Shipyard

            call f.registerObjectLimit('o01S', UNLIMITED)   //Peon (Bloodpact)
            call f.registerObjectLimit('o023', UNLIMITED)   //Grunt (Bloodpact)
            call f.registerObjectLimit('ohun', UNLIMITED)   //Troll Headhunter
            call f.registerObjectLimit('ocat', 6)           //Catapult
            call f.registerObjectLimit('nckb', 2)           //Kodo Beast (Bloodpact)
            call f.registerObjectLimit('owyv', 6)           //Wind Rider
            call f.registerObjectLimit('otbr', 6)           //Troll Batrider
            call f.registerObjectLimit('odoc', UNLIMITED)   //Troll Witch Doctor
            call f.registerObjectLimit('o01P', UNLIMITED)   //Dark Shaman
            call f.registerObjectLimit('obot', UNLIMITED)   //Transport Ship
            call f.registerObjectLimit('odes', UNLIMITED)   //Orc Frigate
            call f.registerObjectLimit('ojgn', 12)          //Juggernaught
            call f.registerObjectLimit('o024', 6)           //Stormreaver Warlock

            call f.registerObjectLimit('Rolf', UNLIMITED)   //Liquid Fire
            call f.registerObjectLimit('Rovs', UNLIMITED)   //Envenomed Spears
            call f.registerObjectLimit('Rwdm', UNLIMITED)   //War Drums
            call f.registerObjectLimit('Robs', UNLIMITED)   //Berseker Strength
            call f.registerObjectLimit('Rotr', UNLIMITED)   //Troll Regeneration
            call f.registerObjectLimit('Rows', UNLIMITED)   //Pulverize
            call f.registerObjectLimit('R025', UNLIMITED)   //Dark Shaman Adept Training
            call f.registerObjectLimit('Rowd', UNLIMITED)   //Witch Doctor Adept Training
            call f.registerObjectLimit('Rhan', UNLIMITED)   //Spiritual Infusion

            call f.registerObjectLimit('R00R', UNLIMITED)   //Spiritual Mastery
            call f.registerObjectLimit('R017', UNLIMITED)   //Warrior Spirit Mastery

            call f.registerObjectLimit('R02T', UNLIMITED)   //Season of Thunder
            call f.registerObjectLimit('R02R', UNLIMITED)   //Voodic Command
            
            //Dummy
            call f.registerObjectLimit('R004', UNLIMITED)   //Bloodpact            
    endfunction
    
endlibrary
