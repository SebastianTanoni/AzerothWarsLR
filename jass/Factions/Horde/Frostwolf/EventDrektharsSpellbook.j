library EventDrektharsSpellbook initializer OnInit requires Artifact

  private function EntersRegion takes nothing returns nothing
    local Artifact tempArtifact = 0
    if GetUnitTypeId(GetTriggerUnit()) == 'Othr' then
      set tempArtifact = Artifact.artifactsByType['dtsb']
      call UnitAddItem(GetTriggerUnit(), tempArtifact.item)
      call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The World Tree, Nordrassil, has been captured by the forces of the Horde. Drek'thar has gifted Warchief Thrall his magical spellbook for this achievement.")
      call DestroyTrigger(GetTriggeringTrigger())
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterEnterRectSimple( trig, gg_rct_Drekthars_Spellbook )
    call TriggerAddCondition( trig, function EntersRegion)
  endfunction

endlibrary