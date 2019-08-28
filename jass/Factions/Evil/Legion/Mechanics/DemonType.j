library DemonType initializer OnInit requires Table, Event, T32, Filters, Math

  globals
    Event OnDemonTypeCreate
    Event OnDemonTypeWarpRangeChange
    Event OnDemonTypeWarpCostChange
    Event OnDemonTypeWarpDamageChange
    Event OnDemonTypeWarpTypeChange
  endglobals

  struct DemonType
    static Table demonsByUnitId
    static thistype triggerDemonType = 0

    readonly integer unitId = 0
    readonly real rematerializeChance = 0
    readonly real warpCost = 0
    readonly real duration = 0
    readonly integer warpType = 0
    readonly real warpDamage = 0
    readonly real warpRange = 0

    method setWarpDamage takes real damage returns nothing
      set this.warpDamage = damage
      set thistype.triggerDemonType = this
      call OnDemonTypeWarpDamageChange.fire()
    endmethod

    method setWarpRange takes real range returns nothing
      set this.warpRange = range
      set thistype.triggerDemonType = this
      call OnDemonTypeWarpRangeChange.fire()
    endmethod

    method setDuration takes real duration returns nothing
      set this.duration = duration
    endmethod

    method setWarpCost takes real cost returns nothing
      set this.warpCost = cost
      set thistype.triggerDemonType = this
      call OnDemonTypeWarpCostChange.fire()
    endmethod

    method setRematerializeChance takes real chance returns nothing
      set this.rematerializeChance = chance
    endmethod

    method setWarpType takes integer whichType returns nothing
      //Ensure default instantiation settings are applied
      if this.warpType == 0 then
        if whichType == WARP_TYPE_NORMAL then
          set this.warpRange = WARP_RANGE_NORMAL
        elseif whichType == WARP_TYPE_DIMENSIONAL then
          set this.warpRange = WARP_RANGE_DIMENSIONAL
        elseif whichType == WARP_TYPE_METEOR then
          set this.warpRange = WARP_RANGE_METEOR
          set this.warpDamage = WARP_DAMAGE_METEOR
        endif
      endif

      set this.warpType = whichType
      set thistype.triggerDemonType = this
      call OnDemonTypeWarpTypeChange.fire()
    endmethod

    static method startDuration takes unit u returns nothing
      local DemonType tempDemonType = 0
      set tempDemonType = thistype.demonsByUnitId[GetUnitTypeId(u)]
      if tempDemonType.duration > 0 then
        call UnitApplyTimedLife(u, 0, tempDemonType.duration)
        call UnitAddType(u, UNIT_TYPE_SUMMONED)
        call SetUnitUseFood(u, false)
      endif
    endmethod

    static method create takes integer unitId returns thistype
      local thistype this = thistype.allocate()
      
      set this.unitId = unitId
      
      set thistype.demonsByUnitId[unitId] = this

      set thistype.triggerDemonType = this
      call OnDemonTypeCreate.fire()
      
      return this                
    endmethod     

    private static method onInit takes nothing returns nothing
      set thistype.demonsByUnitId = Table.create()
    endmethod
  endstruct

  function GetTriggerDemonType takes nothing returns DemonType
    return DemonType.triggerDemonType
  endfunction

  private function OnInit takes nothing returns nothing
    set OnDemonTypeCreate = Event.create()
    set OnDemonTypeWarpRangeChange = Event.create()
    set OnDemonTypeWarpCostChange = Event.create()
    set OnDemonTypeWarpDamageChange = Event.create()
    set OnDemonTypeWarpTypeChange = Event.create()
  endfunction

endlibrary