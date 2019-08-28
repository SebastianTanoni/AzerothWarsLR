library DemonWarpNormal requires Table, Event, T32, Filters, Math, Instance

  globals
    constant integer WARP_TYPE_NORMAL = 0
    constant string WARP_EFFECT_NORMAL = "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl"
    constant real WARP_RANGE_NORMAL = 200.
    constant real WARP_DURATION_NORMAL = 0.5
  endglobals

  struct Normal //The animation that plays out to bring a normal Demon into the world
    private group grp = null      
    private real x = 0
    private real y = 0
    private real tick = 0
    private real dur = 0

    method destroy takes nothing returns nothing
      call DestroyGroup(this.grp)
      set this.grp = null
      call this.deallocate()
    endmethod

    static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, real dur, integer limit returns thistype
      local thistype this = thistype.allocate()
      local real ang = 0
      local real casterX = GetUnitX(caster)
      local real casterY = GetUnitY(caster)
      local unit u = null
      local integer i = 0

      if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > WARP_RANGE_NORMAL then
        set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
        set this.x = GetPolarOffsetX(casterX, WARP_RANGE_NORMAL, ang)
        set this.y = GetPolarOffsetY(casterY, WARP_RANGE_NORMAL, ang)
      else
        set this.x = x
        set this.y = y
      endif

      //Import group
      set this.grp = CreateGroup()
      loop
      exitwhen i == limit
        call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
        set i = i + 1
      endloop
      set this.dur = dur*T32_FPS

      //Handle group
      set i = 0
      loop
      exitwhen i == BlzGroupGetSize(this.grp)
        set u = BlzGroupUnitAt(this.grp, i)
        call SetUnitPosition(u, this.x, this.y)
        call DemonType.startDuration(u)
        call IssuePointOrder(u, "attack", x, y)   
        call SetUnitFacing(u, ang)    
        set i = i + 1
      endloop
      set u = null
    
      call DestroyEffect(AddSpecialEffect(WARP_EFFECT_NORMAL, GetUnitX(FirstOfGroup(this.grp)), GetUnitY(FirstOfGroup(this.grp))))   

      call this.destroy()
      
      return this                
    endmethod             

  endstruct    

endlibrary