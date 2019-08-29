library DemonRematerialize requires Table, Event, T32, Filters, Math, Instance

  struct Rematerialize
    private unit u = null
    private real dur = 0
    private real maxDuration = 0
    private real x = 0
    private real y = 0

    method destroy takes nothing returns nothing
      local unit tempUnit = CreateUnit(GetOwningPlayer(this.u), GetUnitTypeId(this.u), x, y, 0)
      call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", GetUnitX(tempUnit), GetUnitY(tempUnit)) )

      call RemoveUnit(this.u)
      set this.u = null
      set tempUnit = null
      call this.deallocate()
    endmethod

    static method create takes unit whichUnit, real x, real y, real duration returns thistype
      local thistype this = thistype.allocate()
      
      set this.u = whichUnit
      set this.maxDuration = duration*T32_FPS
      set this.x = x
      set this.y = y

      call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl", GetUnitX(this.u), GetUnitY(this.u)) )
      call this.destroy()

      return this                
    endmethod 
  endstruct

endlibrary