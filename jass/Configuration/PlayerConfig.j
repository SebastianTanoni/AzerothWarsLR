library PlayerConfig initializer OnInit requires Persons, Team, TeamConfig, ScourgeConfig, LegionConfig, FelHordeConfig, LordaeronConfig, IronforgeConfig, DalaranConfig, QuelthalasConfig, FrostwolfConfig, WarsongConfig, SentinelsConfig, StormwindConfig, DruidsConfig

  function OnInit takes nothing returns nothing
    local Person p
    set  p = Person.create(Player(0))
      call p.setFaction(FACTION_SCOURGE)           
      call p.setTeam(0)               //Scourge
      //call p.addCapital(gg_unit_u000_0649)  //Frozen Throne
      //call p.addCapital(gg_unit_u012_1149)  //Scholomance
    set  p = Person.create(Player(1))
      call p.setFaction(FACTION_LEGION)    
      call p.setTeam(0)               //Scourge
    set  p = Person.create(Player(2))
      call p.setFaction(FACTION_FEL_HORDE)          
      call p.setTeam(5)               //Fel Horde
      //call p.addCapital(gg_unit_o013_2507)  //Blackrock Spire
      //call p.addCapital(gg_unit_o008_0168)  //Hellfire Citadel
      //call p.addCapital(gg_unit_o00F_0659)  //Black Temple
    set  p = Person.create(Player(3))
      call p.setFaction(FACTION_LORDAERON)            
      call p.setTeam(1)               //North Alliance
      //call p.addCapital(gg_unit_h000_0406)  //Capital Palace
      //call p.addCapital(gg_unit_h01G_0885)  //Stratholme Castle
      //call p.addCapital(gg_unit_h030_0839)  //Tyr's Hand Citadel
    set  p = Person.create(Player(4)) 
      call p.setFaction(FACTION_IRONFORGE)         
      call p.setTeam(4)               //South Alliance
      //call p.addCapital(gg_unit_h001_0180)  //The Great Forge
    set  p = Person.create(Player(5))
      call p.setFaction(FACTION_DALARAN)          
      call p.setTeam(1)               //North Alliance
      //call p.addCapital(gg_unit_h002_0230)  //Violet Citadel
    set  p = Person.create(Player(6))
      call p.setFaction(FACTION_QUELTHELAS)          
      call p.setTeam(1)               //North Alliance
      //call p.addCapital(gg_unit_n001_0165)  //The Sunwell
    set  p = Person.create(Player(7))
      call p.setFaction(FACTION_FROSTWOLF)         
      call p.setTeam(2)               //Horde
      //call p.addCapital(gg_unit_o00C_1292)  //Orgrimmar
      //call p.addCapital(gg_unit_o00J_1495)  //Thunderbluff
      //call p.addCapital(gg_unit_o02D_0254)  //Darkspear Hold
    set  p = Person.create(Player(8))
      call p.setFaction(FACTION_WARSONG)          
      call p.setTeam(2)               //Horde
      //call p.addCapital(gg_unit_o004_0169)  //Stonemaul Keep
      //call p.addCapital(gg_unit_o02K_0450)  //Warsong Encampment
    set  p = Person.create(Player(9))
      call p.setFaction(FACTION_SENTINELS)          
      call p.setTeam(3)               //Night Elves  
      //call p.addCapital(gg_unit_e00M_2545)  //Feathermoon Stronghold
      //call p.addCapital(gg_unit_e00J_0320)  //Auberdine
      //call p.addCapital(gg_unit_o029_1485)  //Temple of the Moon
    set  p = Person.create(Player(10))
      call p.setFaction(FACTION_STORMWIND)        
      call p.setTeam(4)               //South Alliance
      //call p.addCapital(gg_unit_h00X_0007)  //Stonemaul Keep
    set  p = Person.create(Player(11))
      call p.setFaction(FACTION_DRUIDS)         
      call p.setTeam(3)               //Night Elves  
      //call p.addCapital(gg_unit_n002_0130)  //Stonemaul Keep  
  endfunction

endlibrary