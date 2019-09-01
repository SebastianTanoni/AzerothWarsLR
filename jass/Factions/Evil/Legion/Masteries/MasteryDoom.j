library MasteryDoom initializer OnInit requires Persons, LegionMasteryConfig, DemonType, DemonTypeConfig

  //Allows you to train 2 additional Doom Guards. Changes Doom Guard's Warp type to Dimensional. 
  //Increases the hit points and damage of Fel Hounds, and changes their Armor Type to Heavy.

  globals
      private constant integer RESEARCH_ID = 'R01N'
  endglobals

  private function Research takes nothing returns nothing
    local DemonType tempDemonType = 0
    local Person tempPerson = 0
    if GetResearched() == RESEARCH_ID then
      set tempDemonType = DemonType.demonsByUnitId['n04O']      //Doom Guard
        call tempDemonType.setWarpType(WARP_TYPE_DIMENSIONAL)    
      set tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
        if tempPerson != 0 then
          call tempPerson.applyFactionMod(FACTIONMOD_MASTERY_DOOM)
        endif
      call DestroyTrigger(GetTriggeringTrigger())
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_RESEARCH_FINISH  )
    call TriggerAddCondition(trig, Condition(function Research))    
  endfunction

endlibrary