library BuildCrossroads initializer OnInit requires WarsongConfig, FrostwolfConfig

  globals
    private constant real TIMER = 420.     //How long it takes for this event to elapse automatically

    private trigger TriggerEntersRegion = null
    private trigger TriggerTimer = null
  endglobals

  private function Build takes nothing returns nothing
    local group tempGroup = CreateGroup()
    local unit u
    local Person tempPerson = 0
    local player recipient = Player(PLAYER_NEUTRAL_AGGRESSIVE)

    if PersonsByFaction[FACTION_FROSTWOLF] != 0 then                    
      set tempPerson = PersonsByFaction[FACTION_FROSTWOLF]
      set recipient = tempPerson.getPlayer()
    elseif PersonsByFaction[FACTION_WARSONG] != 0 then                    //Warsong
      set tempPerson = PersonsByFaction[FACTION_WARSONG]
      set recipient = tempPerson.getPlayer()                               
    endif

    //Transfer all Neutral Passive units in Crossroads to one of the above factions
    call GroupEnumUnitsInRect(tempGroup, gg_rct_CrossroadsOuter, null)
    set u = FirstOfGroup(tempGroup)
    loop
    exitwhen u == null
      if GetOwningPlayer(u) == Player(PLAYER_NEUTRAL_PASSIVE) then
        call ShowUnit(u, true)
        call SetUnitInvulnerable(u, false)
        call SetUnitOwner(u, recipient, true)
      endif
      call GroupRemoveUnit(tempGroup, u)
      set u = FirstOfGroup(tempGroup)
    endloop
    //Give resources and display message
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "The Crossroads has been constructed.")  
    call CreateUnit(recipient, 'oeye', -12844, -1975, 0)    
    call CreateUnit(recipient, 'oeye', -10876, -2066, 0)   
    call CreateUnit(recipient, 'oeye', -11922, -824, 0)   

    //Cleanup
    call DestroyGroup (TempGroup)
    call DestroyTrigger(TriggerEntersRegion)      
    call DestroyTrigger(TriggerTimer)  
    set recipient = null
    set tempGroup = null
  endfunction

  private function TimerEnds takes nothing returns nothing
    call Build()
  endfunction

  private function EntersRegion takes nothing returns nothing
    local Person tempPerson = Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
    if tempPerson.getFaction().getId() == 7 or tempPerson.getFaction().getId() == 8 then   //Any Horde faction
      call Build()
    endif
  endfunction    

  private function OnInit takes nothing returns nothing
    set TriggerEntersRegion = CreateTrigger()
    call TriggerRegisterEnterRectSimple(TriggerEntersRegion, gg_rct_Crossroads)
    call TriggerAddCondition(TriggerEntersRegion, Condition(function EntersRegion))

    set TriggerTimer = CreateTrigger()
    call TriggerRegisterTimerEvent(TriggerTimer, TIMER, false)
    call TriggerAddCondition(TriggerTimer, Condition(function TimerEnds))        
  endfunction

endlibrary