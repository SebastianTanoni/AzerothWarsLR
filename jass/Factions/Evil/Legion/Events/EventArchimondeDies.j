library EventArchimondeDies initializer OnInit requires Persons

  private function Dies takes nothing returns nothing
    local Person triggerPerson = 0
    local effect tempEffect = null
    if GetUnitTypeId(GetTriggerUnit()) == 'Uwar' then
      set tempEffect = AddSpecialEffect("Objects\\Spawnmodels\\Undead\\UCancelDeath\\UCancelDeath.mdl", GetUnitX(GetTriggerUnit()), GetUnitY(GetTriggerUnit()))
      call BlzSetSpecialEffectScale(tempEffect, 2.)
      call DestroyEffect(tempEffect)
      set tempEffect = null
      set triggerPerson = Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
      call DisplayTextToForce(GetPlayersAll(), triggerPerson.faction.prefixCol + "Archimonde|r, Eredar Lord of the " + triggerPerson.faction.prefixCol + "Burning Legion|r, has fallen.")
      call RemoveUnit(GetTriggerUnit())
      call DestroyTrigger(GetTriggeringTrigger())
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
    call TriggerAddCondition(trig, Condition(function Dies))      
  endfunction

endlibrary