library LegionDefeat initializer OnInit requires LegionConfig, DemonPortal

  private function DemonPortalDestroyed takes nothing returns nothing
    local Person legion = PersonsByFaction[FACTION_LEGION]
    if legion != 0 and BlzGroupGetSize(DemonPortal.demonPortals) == 0 then
      call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The final " + legion.getFaction().getPrefixCol() + "Legion|r Portal has been destroyed, removing their last planetside foothold. Cut off from their homeworlds, the remaining demonic forces splinter.")
      call legion.obliterate()
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call OnDemonPortalDestroy.register(trig)
    call TriggerAddCondition(trig, Condition(function DemonPortalDestroyed))
  endfunction

endlibrary