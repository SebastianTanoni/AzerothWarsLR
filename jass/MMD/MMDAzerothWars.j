/* library MMDAzerothWars initializer OnInit requires MMD, Persons

  globals
    private constant real SCORE_EARLY_VICTORY = 1000.
    private constant real SCORE_LATE_VICTORY = 1000.

    private boolean LateGameDetermined = false
  endglobals

  private function DetermineLateGame takes nothing returns nothing
    local Team winningTeam = 0
    local Team tempTeam = 0
    local Person tempPerson = 0
    local integer count = 0   //The number of eligible WinningTeams we have found; if this is not exactly 1, then nobody has won
    local integer i = 0
    local integer j = 0
    
    set LateGameDetermined = true

    loop
    exitwhen i == Team.teamCount or count > 1
      set tempTeam = Team.teamsByIndex[i]
      set j = 0
      loop
      exitwhen j == tempTeam.size or count > 1
        if BlzGroupGetSize(tempTeam.getPersonById(j).capitals) > 0 then
          set winningTeam = tempTeam
          set count = count + 1
        endif
        set j = j + 1
      endloop
      set i = i + 1
    endloop

    //If we found exactly 1 team eligible to win, then they win the late game
    set i = 0
    loop
    exitwhen i == winningTeam.size
      set tempPerson = winningTeam.getPersonById(i)
      if not tempPerson.lateGameFinished then
        call tempPerson.finishLateGame()
        call tempPerson.addScore(SCORE_LATE_VICTORY, true)
      endif
      set i = i + 1
    endloop
    //And everybody else loses
    set i = 0
    loop
    exitwhen i == MAX_PLAYERS
      set tempPerson = Persons[i]
      if not tempPerson.lateGameFinished then
        call tempPerson.finishLateGame()
        call tempPerson.addScore(0, true)
      endif
      set i = i + 1
    endloop
  endfunction

  private function LoseCapital takes unit whichCapital, player victim, player killer returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local Person triggerPerson = 0
    local Person killerPerson = 0

    if IsUnitInGroup(triggerUnit, Person.allCapitals) then
      set triggerPerson = Persons[GetPlayerId(GetOwningPlayer(triggerUnit))]
      call triggerPerson.removeCapital(whichCapital)
      //This player loses the early game if it was their last starting capital that got destroyed
      if BlzGroupGetSize(triggerPerson.startingCapitals) == 0 then
        if not triggerPerson.earlyGameFinished then
          call triggerPerson.finishEarlyGame()
          call triggerPerson.addScore(0, true)
          //If the player that destroyed had this capital in their target group, AND the killer still has one of their starting capitals, they win the early duel
          set killerPerson = Persons[GetPlayerId(killer)]
          if BlzGroupGetSize(killerPerson.startingCapitals) > 0 and IsUnitInGroup(whichCapital, killerPerson.startingEnemyCapitals) and not killerPerson.earlyGameFinished then
            call killerPerson.finishEarlyGame()
            call killerPerson.addScore(SCORE_LATE_VICTORY, true)
          endif
        endif
      endif
      if not LateGameDetermined then
        call DetermineLateGame()
      endif
    endif

    set triggerUnit = null
  endfunction

  private function Dies takes nothing returns nothing
    if IsUnitInGroup(GetTriggerUnit(), Person.allCapitals) then
      call LoseCapital(GetTriggerUnit(), GetOwningPlayer(GetTriggerUnit()), GetOwningPlayer(GetKillingUnit()))
    endif
  endfunction

  private function ChangeOwner takes nothing returns nothing
    if IsUnitInGroup(GetChangingUnit(), Person.allCapitals) then
      call LoseCapital(GetChangingUnit(), GetChangingUnitPrevOwner(), null)
    endif
  endfunction

  private function Setup takes nothing returns nothing
    call MMD_DefineValue("score", MMD_TYPE_INT, MMD_GOAL_HIGH, MMD_SUGGEST_LEADERBOARD)
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = null

    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(trig, Condition(function Dies))

    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_CHANGE_OWNER)
    call TriggerAddCondition(trig, Condition(function ChangeOwner))

    //Define values
    set trig = CreateTrigger()
    call TriggerRegisterTimerEvent(trig, 0.2, false)
    call TriggerAddAction(trig, function Setup)
  endfunction

endlibrary */