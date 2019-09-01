library PathTrueHorde initializer OnInit requires Persons, TrueHordeConfig

  globals
    private constant integer RESEARCH_ID = 'R02M'
  endglobals

  private function Research takes nothing returns nothing
    if GetResearched() == RESEARCH_ID then
      call GetTriggerPerson().setFaction(FACTION_TRUE_HORDE)
      call GetTriggerPerson().setTeam(TEAM_HORDE)
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call OnPersonFactionChange.register(trig)
    call TriggerAddAction(trig, function Research)
  endfunction

endlibrary