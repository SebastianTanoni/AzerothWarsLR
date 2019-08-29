library BuildWarsongCamp initializer OnInit requires WarsongConfig, FrostwolfConfig

  globals
    private constant real TIMER = 270.     //How long it takes for Warsong Lumber Camp to be built instantly

    private trigger TriggerEntersRegion = null
    private trigger TriggerTimer = null
  endglobals

  private function Build takes nothing returns nothing
    local group tempGroup = CreateGroup()
    local unit u
    local Person tempPerson = 0
    local player recipient = Player(PLAYER_NEUTRAL_AGGRESSIVE)

    if PersonsByFaction[FACTION_WARSONG] != 0 then                    //Warsong
      set tempPerson = PersonsByFaction[8]
      set recipient = tempPerson.getPlayer()     
    elseif PersonsByFaction[FACTION_FROSTWOLF] != 0 then                        //Frostwolf
      set tempPerson = PersonsByFaction[FACTION_FROSTWOLF]
      set recipient = tempPerson.getPlayer()                       
    endif

    //Transfer all Neutral Passive units in Orgrimmar to one of the above factions
    call GroupEnumUnitsInRect(tempGroup, gg_rct_WarsongCamp, null)
    set u = FirstOfGroup(tempGroup)
    loop
    exitwhen u == null
      if GetOwningPlayer(u) == Player(PLAYER_NEUTRAL_PASSIVE) then
        call SetUnitInvulnerable(u, false)
        call SetUnitOwner(u, recipient, true)
      endif
      call GroupRemoveUnit(tempGroup, u)
      set u = FirstOfGroup(tempGroup)
    endloop
    //Give resources and display message
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Under orders from Thrall, Grommash has entered Ashenvale forest to establish the Warsong Lumber Camp.")      

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
    if GetUnitTypeId(GetTriggerUnit()) == 'Opgh' or GetUnitTypeId(GetTriggerUnit()) == 'Ogrh' then   //Grom or Grom Bloodpact
      call Build()
    endif
  endfunction    

  private function OnInit takes nothing returns nothing
    set TriggerEntersRegion = CreateTrigger()
    call TriggerRegisterEnterRectSimple(TriggerEntersRegion, gg_rct_WarsongCamp)
    call TriggerAddCondition(TriggerEntersRegion, Condition(function EntersRegion))

    set TriggerTimer = CreateTrigger()
    call TriggerRegisterTimerEvent(TriggerTimer, TIMER, false)
    call TriggerAddCondition(TriggerTimer, Condition(function TimerEnds))        
  endfunction

endlibrary