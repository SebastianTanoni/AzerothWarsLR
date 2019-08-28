library DemonPortal initializer OnInit requires DemonGroup, Table, DemonPortalTypeConfig, LegionConfig, Event, GeneralHelpers, DemonWarpBarrier

  globals
    Event OnDemonPortalDestroy

    private constant integer WARPER_ID = 'A09O'
  endglobals

  struct DemonPortal
    readonly static real mana = 0
    readonly static real manaMax = 0
    readonly static real manaRegen = 0
    readonly static timer manaTimer = null
    static Event onManaChange = 0

    readonly static group demonPortals = null
    readonly static Table demonPortalsByHandleId = 0
    private integer handleId = 0
    private unit u = null

    method destroy takes nothing returns nothing
      local DemonPortalType tempDemonPortalType = DemonPortalType.demonPortalTypesById[GetUnitTypeId(u)]
      set thistype.demonPortalsByHandleId[this.handleId] = 0
      call GroupRemoveUnit(thistype.demonPortals, u)
      call OnDemonPortalDestroy.fire()
      call modManaMax(-tempDemonPortalType.manaMax)
      call modManaRegen(-tempDemonPortalType.manaRegen)
      set this.u = null
      call this.deallocate()
    endmethod

    method warp takes DemonGroup whichDemonGroup, real x, real y, integer limit returns boolean
      local DemonType tempDemonType = whichDemonGroup.whichDemonType
      local integer newLimit = 0      //How many units from this group can be summoned
      local real cost = 0

      if not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and GetDistanceBetweenPointsEx(GetUnitX(.u), GetUnitY(.u), x, y) > -1 and not IsPointInDemonWarpBarrier(x, y) then
        if tempDemonType.warpCost == 0 then
          set newLimit = limit
        else
          set newLimit = IMinBJ ( R2I(mana / tempDemonType.warpCost), limit)
        endif
        if newLimit > 0 and tempDemonType.warpType == WARP_TYPE_METEOR then
          set newLimit = 1
        endif
        set cost = newLimit*tempDemonType.warpCost
        if newLimit > 0 then
          call whichDemonGroup.warp(this.u, x, y, newLimit)
          call modMana(-cost)
        endif
      endif
      return false
    endmethod

    private static method modMana takes real val returns nothing
      set mana = RMinBJ(mana + val, manaMax)
      call onManaChange.fire()
    endmethod

    private static method modManaMax takes real val returns nothing
      set manaMax = manaMax + val
      call onManaChange.fire()
    endmethod

    private static method modManaRegen takes real val returns nothing
      set manaRegen = manaRegen + val
      call onManaChange.fire()
    endmethod

    static method periodic takes nothing returns nothing
      call modMana(manaRegen)
    endmethod

    static method create takes unit u, real manaMax, real manaRegen, real manaStart returns thistype
      local thistype this = thistype.allocate()
      
      set this.u = u
      call modMana(manaStart)
      call modManaRegen(manaRegen)
      call modManaMax(manaMax)
      set this.handleId = GetHandleId(u)
      set thistype.demonPortalsByHandleId[this.handleId] = this

      call UnitAddAbility(this.u, WARPER_ID)
      call GroupAddUnit(thistype.demonPortals, u)
      call UnitAddAbility(u, 'ARal')
      
      return this                
    endmethod     

    static method onInit takes nothing returns nothing
      set demonPortals = CreateGroup()
      set demonPortalsByHandleId = Table.create()
      set onManaChange = Event.create()
      set manaTimer = CreateTimer()
      call TimerStart(manaTimer, 1, true, function thistype.periodic)
    endmethod      

  endstruct

  private function IssuedPointOrder takes nothing returns nothing
    local DemonPortal tempDemonPortal = 0
    local real x = 0
    local real y = 0
    local Person tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
    local Faction tempFaction = tempPerson.getFaction()
    if tempFaction.getId() == FACTION_LEGION and IsUnitInGroup(GetTriggerUnit(), DemonPortal.demonPortals) then
      set tempDemonPortal = DemonPortal.demonPortalsByHandleId[GetHandleId(GetTriggerUnit())]
      if DemonGroup.first.getSize() != 0 then
        set x = GetOrderPointX()
        set y = GetOrderPointY()
        call tempDemonPortal.warp(DemonGroup.first, x, y, 1)
      endif
    endif
  endfunction

  private function IssuedUnitOrder takes nothing returns nothing
    local DemonPortal tempDemonPortal = 0
    local real x = 0
    local real y = 0
    local Person tempPerson = Persons[GetPlayerId(GetTriggerPlayer())]
    local Faction tempFaction = tempPerson.getFaction()
    local unit triggerUnit = null
    local unit targetUnit = null
    local DemonType tempDemonType = 0

    //Demon Portal issued an order to a unit
    if tempFaction.getId() == FACTION_LEGION and IsUnitInGroup(GetTriggerUnit(), DemonPortal.demonPortals) then
      set tempDemonPortal = DemonPortal.demonPortalsByHandleId[GetHandleId(GetTriggerUnit())]
      if DemonGroup.first.getSize() != 0 then
        set x = GetUnitX(GetOrderTargetUnit())
        set y = GetUnitY(GetOrderTargetUnit())
        call tempDemonPortal.warp(DemonGroup.first, x, y, 1) 
      endif
    endif
  endfunction    

  private function MassRegister takes nothing returns nothing
    local unit tempUnit = null
    local group tempGroup = null
    local integer i = 0
    local DemonPortalType tempDemonPortalType = 0

    loop
    exitwhen i == DemonPortalType.count
      set tempDemonPortalType = DemonPortalType.demonPortalTypesByIndex[i]
      set tempGroup = GetUnitsOfTypeIdAll(tempDemonPortalType.unitTypeId)      //THIS IS NOT VERY PERFORMANT. UPDATE WHEN NEW NATIVE IS ADDED
      loop
      exitwhen BlzGroupGetSize(tempGroup) == 0
        set tempUnit = FirstOfGroup(tempGroup)
        call DemonPortal.create(tempUnit, tempDemonPortalType.manaMax, tempDemonPortalType.manaRegen, tempDemonPortalType.manaStart)
        call GroupRemoveUnit(tempGroup, tempUnit)
      endloop
      set tempUnit = null     
      call DestroyGroup(tempGroup)   
      set i = i + 1
    endloop
  endfunction

  private function EntersRegion takes nothing returns nothing
    local unit tempUnit = GetTriggerUnit()
    local integer i = 0
    local DemonPortalType tempDemonPortalType = 0

    if GetUnitState(tempUnit, UNIT_STATE_LIFE) == GetUnitState(tempUnit, UNIT_STATE_MAX_LIFE) then
      loop
      exitwhen i == DemonPortalType.count
        set tempDemonPortalType = DemonPortalType.demonPortalTypesByIndex[i]
        if GetUnitTypeId(tempUnit) == tempDemonPortalType.unitTypeId then
          call DemonPortal.create(tempUnit, tempDemonPortalType.manaMax, tempDemonPortalType.manaRegen, tempDemonPortalType.manaStart)
        endif
        set i = i + 1
      endloop       
    endif
    set tempUnit = null 
  endfunction

  private function FinishesConstruction takes nothing returns nothing
    local unit tempUnit = GetTriggerUnit()
    local integer i = 0
    local DemonPortalType tempDemonPortalType = 0

    loop
    exitwhen i == DemonPortalType.count
      if DemonPortal.demonPortalsByHandleId[i] == 0 then
        set tempDemonPortalType = DemonPortalType.demonPortalTypesByIndex[i]
        if GetUnitTypeId(tempUnit) == tempDemonPortalType.unitTypeId then
          call DemonPortal.create(tempUnit, tempDemonPortalType.manaMax, tempDemonPortalType.manaRegen, tempDemonPortalType.manaStart)
        endif
        set i = i + 1
      endif
    endloop       
    set tempUnit = null 
  endfunction

  private function Dies takes nothing returns nothing
    local DemonPortal tempDemonPortal = 0
    if IsUnitInGroup(GetTriggerUnit(), DemonPortal.demonPortals) then
      set tempDemonPortal = DemonPortal.demonPortalsByHandleId[GetHandleId(GetTriggerUnit())]
      if tempDemonPortal != 0 then
        call tempDemonPortal.destroy()
      endif
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    //Portal right-clicks a point
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
    call TriggerAddCondition(trig, Condition(function IssuedPointOrder) )

    //Portal right-clicks a unit
    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_ISSUED_UNIT_ORDER)
    call TriggerAddCondition(trig, Condition(function IssuedUnitOrder) )

    //Initialize all starting Demon Portals
    set trig = CreateTrigger()
    call TriggerRegisterTimerEvent(trig, 0, false)
    call TriggerAddCondition(trig, Condition(function MassRegister) )

    //Portal enters map at full HP
    set trig = CreateTrigger()
    call TriggerRegisterEnterRectSimple(trig, bj_mapInitialPlayableArea)
    call TriggerAddCondition(trig, Condition(function EntersRegion))

    //Portal finishes construction
    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH)
    call TriggerAddCondition(trig, Condition(function FinishesConstruction))

    //Portal decays
    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(trig, Condition(function Dies) )

    set OnDemonPortalDestroy = Event.create()
  endfunction

endlibrary