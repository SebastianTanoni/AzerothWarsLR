//If the Legion changes his Faction from Legion, obliterate the entire Twisting Nether.
library LegionExits initializer OnInit requires LegionConfig, DemonGroup

  private function FactionChanges takes nothing returns nothing
    local group tempGroup = null
    local unit u = null
    if GetChangingPersonPrevFaction().getId() == FACTION_LEGION then
      set tempGroup = CreateGroup()
      call GroupEnumUnitsInRect(tempGroup, TWISTING_NETHER_RECT, null)
      loop
      exitwhen BlzGroupGetSize(tempGroup) == 0
        set u = FirstOfGroup(tempGroup)
        call KillUnit(u)
        call RemoveUnit(u)
        call GroupRemoveUnit(tempGroup, u)
      endloop
      call DestroyGroup(tempGroup)
      set u = null
      set tempGroup = null
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call OnPersonFactionChange.register(trig)
    call TriggerAddCondition(trig, Condition(function FactionChanges))
  endfunction

endlibrary