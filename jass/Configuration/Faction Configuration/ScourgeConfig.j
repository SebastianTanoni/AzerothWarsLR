library ScourgeConfig initializer OnInit requires Faction

  globals
    constant integer FACTION_SCOURGE = 0
  endglobals

  private function OnInit takes nothing returns nothing
    local Faction f
    
    set f = Faction.create(FACTION_SCOURGE, "Scourge", PLAYER_COLOR_PURPLE, "|c00540081","ReplaceableTextures\\CommandButtons\\BTNRevenant.blp")
      call f.setEnterTrigger(ScourgeEnterTrigger)
      call f.setExitTrigger(ScourgeExitTrigger)

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
      call f.registerObjectLimit('utod', UNLIMITED)   //Temple of the Damned 
      call f.registerObjectLimit('ubon', UNLIMITED)   //Boneyard      
      call f.registerObjectLimit('utom', UNLIMITED)   //Tomb of Relics   
      call f.registerObjectLimit('ushp', UNLIMITED)   //Undead Shipyard
      call f.registerObjectLimit('u002', UNLIMITED)   //Improved Spirit Tower
      call f.registerObjectLimit('u003', UNLIMITED)   //Improved Nerubian Tower
      
      call f.registerObjectLimit('uaco', UNLIMITED)   //Acolyte
      call f.registerObjectLimit('ushd', UNLIMITED)   //Shade
      call f.registerObjectLimit('ugho', UNLIMITED)   //Ghoul
      call f.registerObjectLimit('uabo', UNLIMITED)   //Abomination
      call f.registerObjectLimit('umtw', 6)           //Meat Wagon
      call f.registerObjectLimit('ucry', UNLIMITED)   //Crypt Fiend
      call f.registerObjectLimit('ugar', 8)           //Gargoyle
      call f.registerObjectLimit('uban', UNLIMITED)   //Banshee
      call f.registerObjectLimit('unec', UNLIMITED)   //Necromancer
      call f.registerObjectLimit('uobs', 2)           //Obsidian Statue
      call f.registerObjectLimit('ufro', 4)           //Frost Wyrm
      call f.registerObjectLimit('nska', UNLIMITED)   //Skeleton Archer
      call f.registerObjectLimit('h00H', 6)           //Death Knight
      call f.registerObjectLimit('ubot', UNLIMITED)   //Undead Transport Ship
      call f.registerObjectLimit('udes', UNLIMITED)   //Undead Frigate
      call f.registerObjectLimit('uubs', 12)          //Undead Battleship
      call f.registerObjectLimit('ubsp', 8)           //Destroyer
      
      call f.registerObjectLimit('Ruba', UNLIMITED)   //Banshee Adept Training
      call f.registerObjectLimit('Rubu', UNLIMITED)   //Burrow
      call f.registerObjectLimit('Ruex', UNLIMITED)   //Exhume Corpses
      call f.registerObjectLimit('Rufb', UNLIMITED)   //Freezing Breath
      call f.registerObjectLimit('Rugf', UNLIMITED)   //Ghoul Frenzy
      call f.registerObjectLimit('Rune', UNLIMITED)   //Necromancer Adept Training
      call f.registerObjectLimit('Rusl', UNLIMITED)   //Skeletal Longevity
      call f.registerObjectLimit('Rusm', UNLIMITED)   //Skeletal Mastership
      call f.registerObjectLimit('Ruwb', UNLIMITED)   //Web
      call f.registerObjectLimit('R008', UNLIMITED)   //Death Infusion
      
      call f.registerObjectLimit('R00Q', UNLIMITED)   //Frozen Death Mastery
      call f.registerObjectLimit('R00P', UNLIMITED)   //Necromantic Mastery
      call f.registerObjectLimit('R01X', UNLIMITED)   //Plague Engineering Mastery
  endfunction
  
endlibrary