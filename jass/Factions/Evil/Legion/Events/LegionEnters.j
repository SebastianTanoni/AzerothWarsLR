library LegionEnters initializer OnInit requires LegionConfig, DemonGroup

  globals
    private constant integer LEGION_BUILDER_ID = 'u00S'
  endglobals

  private function FactionChanges takes nothing returns nothing
    local group tempGroup = null
    local unit u = null
    if GetTriggerPerson().getFaction().getId() == FACTION_LEGION then
      call CreateUnit(GetTriggerPerson().getPlayer(), LEGION_BUILDER_ID, GetRectCenterX(TWISTING_NETHER_RECT), GetRectCenterY(TWISTING_NETHER_RECT), 0)
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call OnPersonFactionChange.register(trig)
    call TriggerAddCondition(trig, Condition(function FactionChanges))
  endfunction

endlibrary