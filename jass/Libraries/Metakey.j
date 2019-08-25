library Metakey initializer OnInit

  globals 
    private boolean array PlayerShiftDown
  endglobals

  private function ShiftDown takes nothing returns nothing
    set PlayerShiftDown[GetPlayerId(GetTriggerPlayer())] = true
  endfunction

  private function ShiftUp takes nothing returns nothing
    set PlayerShiftDown[GetPlayerId(GetTriggerPlayer())] = false
  endfunction

  function IsPlayerShiftDown takes player p returns boolean
    return PlayerShiftDown[GetPlayerId(p)]
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    local integer i = 0
    loop
    exitwhen i == MAX_PLAYERS
      call BlzTriggerRegisterPlayerKeyEvent(trig, Player(i), OSKEY_LSHIFT, 1, true)
      set i = i + 1
      call TriggerAddAction(trig, function ShiftDown)
    endloop

    set trig = CreateTrigger()
    set i = 0
    loop
    exitwhen i == MAX_PLAYERS
      call BlzTriggerRegisterPlayerKeyEvent(trig, Player(i), OSKEY_LSHIFT, 0, false)
      set i = i + 1
      call TriggerAddAction(trig, function ShiftUp)
    endloop
  endfunction

endlibrary