library DemonTypeConfig initializer OnInit requires DemonType

  globals
    constant real REMATERIALIZATION_CHANCE_NORMAL = 0.1
    constant real REMATERIALIZATION_CHANCE_HIGH = 0.3

    constant real WARP_COST_NORMAL = 10
    constant real WARP_COST_HIGH = 80

    constant real DURATION_NORMAL = 120
  endglobals

  private function OnInit takes nothing returns nothing
    local DemonType tempDemonType = 0

    //Fel Stalker
    set tempDemonType = DemonType.create('n04J')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)

    //Infernal Contraption
    set tempDemonType = DemonType.create('ninc')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)

    //Voidwalker
    set tempDemonType = DemonType.create('nvdw')
      call tempDemonType.setWarpType(WARP_TYPE_DIMENSIONAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)

    //Infernal
    set tempDemonType = DemonType.create('ninf')
      call tempDemonType.setWarpType(WARP_TYPE_METEOR)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_HIGH)
      call tempDemonType.setWarpDamage(50)
      call tempDemonType.setDuration(DURATION_NORMAL)

    //Dreadlord
    set tempDemonType = DemonType.create('u007')
      call tempDemonType.setWarpType(WARP_TYPE_DIMENSIONAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)            

    //Nether Drake
    set tempDemonType = DemonType.create('n070')
      call tempDemonType.setWarpType(WARP_TYPE_DIMENSIONAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)        

    //Nether Dragon
    set tempDemonType = DemonType.create('n04U')
      call tempDemonType.setWarpType(WARP_TYPE_DIMENSIONAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_HIGH)   

    //Felguard
    set tempDemonType = DemonType.create('n04H')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_HIGH) 

    //Infernal Juggernaut
    set tempDemonType = DemonType.create('n04L')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_HIGH)   

    //Warlock
    set tempDemonType = DemonType.create('n04P')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)  

    //Succubus
    set tempDemonType = DemonType.create('n04K')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_NORMAL) 

    //Fel Reaver
    set tempDemonType = DemonType.create('u00K')
      call tempDemonType.setWarpType(WARP_TYPE_METEOR)
      call tempDemonType.setWarpCost(WARP_COST_HIGH) 
      call tempDemonType.setWarpDamage(80)

    //Doom Guard
    set tempDemonType = DemonType.create('n04O')
      call tempDemonType.setWarpType(WARP_TYPE_NORMAL)
      call tempDemonType.setRematerializeChance(REMATERIALIZATION_CHANCE_NORMAL)
      call tempDemonType.setWarpCost(WARP_COST_HIGH)                                                                                                                           
  endfunction

endlibrary