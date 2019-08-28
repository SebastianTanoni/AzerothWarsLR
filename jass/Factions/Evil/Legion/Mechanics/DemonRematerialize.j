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
      call this.stopPeriodic()
      call this.deallocate()
    endmethod

    method periodic takes nothing returns nothing            
      set this.dur = this.dur+1

      call SetUnitVertexColor(this.u, 255, 255, 255, R2I((1 - (this.dur / this.maxDuration))*255))

      if this.dur == this.maxDuration then
          call this.destroy()
      endif    
    endmethod

    implement T32x

    static method create takes unit whichUnit, real x, real y, real duration returns thistype
      local thistype this = thistype.allocate()
      
      set this.u = whichUnit
      set this.maxDuration = duration*T32_FPS
      set this.x = x
      set this.y = y

      call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl", GetUnitX(this.u), GetUnitY(this.u)) )

      call this.startPeriodic()
      
      return this                
    endmethod 
  endstruct

endlibrary