//This system registers all Demons in the Twisting Nether region into unit groups, firing events when this happens.
//The BurningLegionMenu system then sorts these Demons into a visual queue which determines the order in which they can leave Nether Portals.
//It also handles Rematerialization behaviour since it requires the region used by DemonGroup. 

library DemonGroup initializer OnInit requires Table, Event, DemonType, DemonInstantiationBarrier, Instance

  globals
    Event OnDemonRegister
    Event OnDemonUnregister
    Event OnDemonGroupSizeChange

    rect TWISTING_NETHER_RECT = null
  endglobals

  struct DemonGroup
    readonly static thistype triggerDemonGroup = 0
    readonly static thistype first = 0   //Controlled by UI; this is what will get pulled out of Nether Portals on right-click
    static Table demonGroupsByUnitType = 0
    static Table demonGroupsByDemonType = 0

    readonly group demons = null
    readonly string iconPath = null
    readonly DemonType whichDemonType = 0

    method getSize takes nothing returns integer
      return BlzGroupGetSize(this.demons)
    endmethod

      method remove takes unit u returns nothing
      call GroupRemoveUnit(this.demons, u)
      set thistype.triggerDemonGroup = this
      call OnDemonGroupSizeChange.fire()
    endmethod

    method add takes unit u returns nothing
      call GroupAddUnit(this.demons, u)
      set thistype.triggerDemonGroup = this
      call OnDemonGroupSizeChange.fire()
    endmethod

    method setFirst takes nothing returns nothing
      set thistype.first = this
    endmethod

    method instantiate takes unit caster, real x, real y, integer limit returns boolean
      local integer instantiationType = this.whichDemonType.instantiationType
      local integer i = 0

      if not IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > -1 and not IsPointInDemonInstantiationBarrier(x, y) then   //Will be -1 if there are no entrances to the instance
        set instantiationType = this.whichDemonType.instantiationType
        if instantiationType == INSTANTIATION_TYPE_NORMAL then
          call Normal.create(caster, this, x, y, INSTANTIATION_DURATION_NORMAL, limit)
        elseif instantiationType == INSTANTIATION_TYPE_WARP then
          call Warp.create(caster, this, x, y, INSTANTIATION_DURATION_WARP, limit)
        elseif instantiationType == INSTANTIATION_TYPE_METEOR then
          call Meteor.create(caster, this, x, y, limit)
        endif
        loop
          exitwhen i == limit
          call GroupRemoveUnit(demons, FirstOfGroup(demons))
          set i = i + 1
        endloop
        return true
      endif
      return false
    endmethod        

    static method create takes integer unitTypeId returns thistype
      local thistype this = thistype.allocate()

      set thistype.demonGroupsByUnitType[unitTypeId] = this

      set this.iconPath = GetUnitTypeIconPath(unitTypeId)
      set this.demons = CreateGroup()
      set this.whichDemonType = DemonType.demonsByUnitId[unitTypeId]
      set thistype.demonGroupsByDemonType[this.whichDemonType] = this

      return this
    endmethod

    static method onInit takes nothing returns nothing
      set thistype.demonGroupsByUnitType = Table.create()
      set thistype.demonGroupsByDemonType = Table.create()
    endmethod
endstruct

  private function RegisterDemon takes unit u returns nothing
    local integer unitId = GetUnitTypeId(u)
    local DemonGroup tempDemonGroup = 0

    if DemonGroup.demonGroupsByUnitType[unitId] == 0 then
        return
    endif    

    set tempDemonGroup = DemonGroup.demonGroupsByUnitType[unitId]
    call tempDemonGroup.add(u)
  endfunction

  private function UnregisterDemon takes unit u returns nothing
    local integer unitId = GetUnitTypeId(u)
    local DemonGroup tempDemonGroup = 0

    set tempDemonGroup = DemonGroup.demonGroupsByUnitType[unitId]

    if tempDemonGroup != 0 then
        call tempDemonGroup.remove(u)    
    endif    
  endfunction

  function GetTriggerDemonGroup takes nothing returns DemonGroup
      return DemonGroup.triggerDemonGroup
  endfunction

  private function MassRegister takes nothing returns nothing
    //Register all Demons in the Nether at the start of the game
    local unit tempUnit = null
    local group tempGroup = CreateGroup()
    call GroupEnumUnitsInRect(tempGroup, TWISTING_NETHER_RECT, null)
    loop
    exitwhen BlzGroupGetSize(tempGroup) == 0
      set tempUnit = FirstOfGroup(tempGroup)
      call RegisterDemon(tempUnit)
      call GroupRemoveUnit(tempGroup, tempUnit)
    endloop
    call DestroyGroup(tempGroup)
    set tempGroup = null
    set tempUnit = null
endfunction

  private function LeavesRegion takes nothing returns nothing
    call UnregisterDemon(GetTriggerUnit())
  endfunction

  private function EntersRegion takes nothing returns nothing
    call RegisterDemon(GetTriggerUnit())
  endfunction

  private function DemonTypeCreated takes nothing returns nothing
    call DemonGroup.create(GetTriggerDemonType().unitId)
  endfunction

  private function Dies takes nothing returns nothing
    local unit triggerUnit = GetTriggerUnit()
    local unit tempUnit = null
    local DemonType tempDemonType = DemonType.demonsByUnitId[GetUnitTypeId(triggerUnit)]
    local DemonGroup tempDemonGroup
    local Person legion = PersonsByFaction[FACTION_LEGION]
    if tempDemonType != 0 then 
      set tempDemonGroup = DemonGroup.demonGroupsByUnitType[GetUnitTypeId(triggerUnit)]
      if IsUnitInGroup(triggerUnit, tempDemonGroup.demons) then
        call tempDemonGroup.remove(triggerUnit)
        call RemoveUnit(triggerUnit)
      //THIS SHOULD PROBABLY BE IN DEMONTYPE NOT DEMONGROUP
      elseif tempDemonType.rematerializeChance > 0 and GetOwningPlayer(triggerUnit) == legion.getPlayer() then
          if GetRandomReal(0, 1) <= tempDemonType.rematerializeChance then
            call Rematerialize.create(triggerUnit, GetRectCenterX(TWISTING_NETHER_RECT), GetRectCenterY(TWISTING_NETHER_RECT), 1)
          endif
      endif
    endif
    set triggerUnit = null
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = null
    set TWISTING_NETHER_RECT = gg_rct_TwistingNether
    set OnDemonGroupSizeChange = Event.create()

    //Initialize
    set trig = CreateTrigger()
    call TriggerRegisterTimerEvent(trig, 0, false)
    call TriggerAddCondition(trig, Condition(function MassRegister))   

    //Event to catch Demons being configured
    set trig = CreateTrigger()
    call OnDemonTypeCreate.register(trig)
    call TriggerAddCondition(trig, Condition(function DemonTypeCreated))   

    //Event to catch Demons leaving the Nether
    set trig = CreateTrigger()
    call TriggerRegisterLeaveRectSimple(trig, TWISTING_NETHER_RECT)
    call TriggerAddCondition(trig, Condition(function LeavesRegion))

    //Event to catch Demons entering the Nether
    set trig = CreateTrigger()
    call TriggerRegisterEnterRectSimple(trig, TWISTING_NETHER_RECT)
    call TriggerAddCondition(trig, Condition(function EntersRegion))

    //Event to catch a Demon dying
    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(trig, EVENT_PLAYER_UNIT_DEATH)
    call TriggerAddCondition(trig, Condition(function Dies))
  endfunction

endlibrary