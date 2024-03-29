library FrostwolfConfig initializer OnInit requires Faction

  globals
    constant integer FACTION_FROSTWOLF = 7
  endglobals

  private function OnInit takes nothing returns nothing
    local Faction f
    
    set f = Faction.create(FACTION_FROSTWOLF,"Frostwolf", PLAYER_COLOR_RED, "|c00ff0303","ReplaceableTextures\\CommandButtons\\BTNThrall.blp")
      call f.setAbsenceResearch('R04U')
      call f.registerObjectLimit('ogre', UNLIMITED)   //Great Hall
      call f.registerObjectLimit('ostr', UNLIMITED)   //Stronghold
      call f.registerObjectLimit('ofrt', UNLIMITED)   //Fortress
      call f.registerObjectLimit('oalt', UNLIMITED)   //Altar of Storms
      call f.registerObjectLimit('obar', UNLIMITED)   //Barracks
      call f.registerObjectLimit('ofor', UNLIMITED)   //War Mill
      call f.registerObjectLimit('otto', UNLIMITED)   //Tauren Totem
      call f.registerObjectLimit('osld', UNLIMITED)   //Spirit Lodge
      call f.registerObjectLimit('obea', UNLIMITED)   //Bestiary
      call f.registerObjectLimit('otrb', UNLIMITED)   //Orc Burrow
      call f.registerObjectLimit('owtw', UNLIMITED)   //Watch Tower
      call f.registerObjectLimit('o002', UNLIMITED)   //Improved Watch Tower
      call f.registerObjectLimit('ovln', UNLIMITED)   //Voodoo Lounge
      call f.registerObjectLimit('oshy', UNLIMITED)   //Shipyard

      call f.registerObjectLimit('opeo', UNLIMITED)   //Peon
      call f.registerObjectLimit('ogru', UNLIMITED)   //Grunt
      call f.registerObjectLimit('otau', UNLIMITED)   //Tauren
      call f.registerObjectLimit('ohun', UNLIMITED)   //Troll Headhunter
      call f.registerObjectLimit('ocat', 6)           //Catapult
      call f.registerObjectLimit('okod', 2)           //Kodo Beast
      call f.registerObjectLimit('owyv', 6)           //Wind Rider
      call f.registerObjectLimit('otbr', 6)           //Troll Batrider
      call f.registerObjectLimit('odoc', UNLIMITED)   //Troll Witch Doctor
      call f.registerObjectLimit('oshm', UNLIMITED)   //Shaman
      call f.registerObjectLimit('ospw', UNLIMITED)   //Spirit Walker
      call f.registerObjectLimit('o00A', 6)           //Far Seer
      call f.registerObjectLimit('obot', UNLIMITED)   //Transport Ship
      call f.registerObjectLimit('odes', UNLIMITED)   //Orc Frigate
      call f.registerObjectLimit('ojgn', 12)          //Juggernaught

      call f.registerObjectLimit('Rolf', UNLIMITED)   //Liquid Fire
      call f.registerObjectLimit('Rovs', UNLIMITED)   //Envenomed Spears
      call f.registerObjectLimit('Rwdm', UNLIMITED)   //War Drums
      call f.registerObjectLimit('Robs', UNLIMITED)   //Berseker Strength
      call f.registerObjectLimit('Rotr', UNLIMITED)   //Troll Regeneration
      call f.registerObjectLimit('Rows', UNLIMITED)   //Pulverize
      call f.registerObjectLimit('Rost', UNLIMITED)   //Shaman Adept Training
      call f.registerObjectLimit('Rowd', UNLIMITED)   //Witch Doctor Adept Training
      call f.registerObjectLimit('Rowt', UNLIMITED)   //Spirit Walker Adept Training
      call f.registerObjectLimit('R023', UNLIMITED)   //Spiritual Infusion

      call f.registerObjectLimit('R00R', UNLIMITED)   //Spiritual Mastery
      call f.registerObjectLimit('R00W', UNLIMITED)   //Tauren Mastery
      call f.registerObjectLimit('R017', UNLIMITED)   //Warrior Spirit Mastery

      call f.registerObjectLimit('R01O', UNLIMITED)   //Age of Prosperity
      call f.registerObjectLimit('R02T', UNLIMITED)   //Season of Thunder
      call f.registerObjectLimit('R02R', UNLIMITED)   //Voodic Command
      
      call f.registerObjectLimit('R021', UNLIMITED)   //Horde War Machine
  endfunction
    
endlibrary