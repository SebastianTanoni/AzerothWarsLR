library Income initializer OnInit requires Persons

  //**CONFIG**
  globals
    private constant real PERIOD = 1.           //Note that changing this will not change the amount of gold players receive over time
  endglobals
  //**ENDCONFIG
  
  globals 
    boolean INCOME_ENABLED = true
  endglobals

  private function Income takes nothing returns nothing
    local integer i = 0

    if INCOME_ENABLED == true then
      loop
      exitwhen i > MAX_PLAYERS
        if not (Persons[i] == 0) then
          if Persons[i].getIncome() > 0 then
            call Persons[i].addGold(Persons[i].getIncome() / 60 * PERIOD)
          endif
        endif
        set i = i + 1
      endloop
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterTimerEvent(trig, PERIOD, true)
    call TriggerAddCondition(trig, Condition(function Income))
  endfunction    

endlibrary