library EventLegionPortalDies initializer OnInit requires Persons, LegionRitual, DemonPortal

  private function Dies takes nothing returns nothing
    local Person triggerPerson = 0
    local DemonType tempDemonType = 0
    if GetUnitTypeId(GetTriggerUnit()) == 'h015' then
      set triggerPerson = Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
      call DisplayTextToForce(GetPlayersAll(), "The " + triggerPerson.faction.prefixCol + "Burning Legion|r's ultimate gateway has been destroyed. Their ability to funnel an infinite supply of troops to Azeroth has been neutered, and it seems their invasion has been stopped in its tracks.")
      //Infernal 
      set tempDemonType = DemonType.demonsByUnitId['ninf']    
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
      //Nether Dragon
      set tempDemonType = DemonType.demonsByUnitId['n04U']
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
      //Fel Reaver
      set tempDemonType = DemonType.demonsByUnitId['u00K']
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
      //Doom Guard
      set tempDemonType = DemonType.demonsByUnitId['n04O']
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
      //Infernal Juggernaut
      set tempDemonType = DemonType.demonsByUnitId['n04L']
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
      //Felguard
      set tempDemonType = DemonType.demonsByUnitId['n04H']
      call tempDemonType.setInstantiationCost(INSTANTIATION_COST_HIGH)
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition(trig, Condition(function Dies))      
  endfunction

endlibrary