library DemonType initializer OnInit requires Table, Event, T32, Filters, Math

  globals
    Event OnDemonTypeCreate
    Event OnDemonTypeInstantiationRangeChange
    Event OnDemonTypeInstantiationCostChange
    Event OnDemonTypeInstantiationDamageChange
    Event OnDemonTypeInstantiationTypeChange
  endglobals

  struct DemonType
    static Table demonsByUnitId
    static thistype triggerDemonType = 0

    readonly integer unitId = 0
    readonly real rematerializeChance = 0
    readonly real instantiationCost = 0
    readonly real duration = 0
    readonly integer instantiationType = 0
    readonly real instantiationDamage = 0
    readonly real instantiationRange = 0

    method setInstantiationDamage takes real damage returns nothing
      set this.instantiationDamage = damage
      set thistype.triggerDemonType = this
      call OnDemonTypeInstantiationDamageChange.fire()
    endmethod

    method setInstantiationRange takes real range returns nothing
      set this.instantiationRange = range
      set thistype.triggerDemonType = this
      call OnDemonTypeInstantiationRangeChange.fire()
    endmethod

    method setDuration takes real duration returns nothing
      set this.duration = duration
    endmethod

    method setInstantiationCost takes real cost returns nothing
      set this.instantiationCost = cost
      set thistype.triggerDemonType = this
      call OnDemonTypeInstantiationCostChange.fire()
    endmethod

    method setRematerializeChance takes real chance returns nothing
      set this.rematerializeChance = chance
    endmethod

    method setInstantiationType takes integer whichType returns nothing
      //Ensure default instantiation settings are applied
      if this.instantiationType == 0 then
        if whichType == INSTANTIATION_TYPE_NORMAL then
          set this.instantiationRange = INSTANTIATION_RANGE_NORMAL
        elseif whichType == INSTANTIATION_TYPE_WARP then
          set this.instantiationRange = INSTANTIATION_RANGE_WARP
        elseif whichType == INSTANTIATION_TYPE_METEOR then
          set this.instantiationRange = INSTANTIATION_RANGE_METEOR
          set this.instantiationDamage = INSTANTIATION_DAMAGE_METEOR
        endif
      endif

      set this.instantiationType = whichType
      set thistype.triggerDemonType = this
      call OnDemonTypeInstantiationTypeChange.fire()
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
    set OnDemonTypeInstantiationRangeChange = Event.create()
    set OnDemonTypeInstantiationCostChange = Event.create()
    set OnDemonTypeInstantiationDamageChange = Event.create()
    set OnDemonTypeInstantiationTypeChange = Event.create()
  endfunction

endlibrary