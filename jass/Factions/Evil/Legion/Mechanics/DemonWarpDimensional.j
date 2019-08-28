library DemonWarpDimensional requires Table, Event, T32, Filters, Math, Instance

  globals
    constant integer INSTANTIATION_TYPE_WARP = 1
    constant string INSTANTIATION_EFFECT_WARP_AREA = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTo.mdl"
    constant string INSTANTIATION_EFFECT_WARP_CASTER = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportCaster.mdl"
    constant string INSTANTIATION_EFFECT_WARP_TARGET = "Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl"    
    constant real INSTANTIATION_RANGE_WARP = 3000.
    constant real INSTANTIATION_DURATION_WARP = 2.
    constant real INSTANTIATION_SCALE_WARP = 0.8    
  endglobals

  //A unit disappears, then a nice animation appears somewhere, then the unit appears at that animation
  struct Warp
    private group grp = null   
    private real x = 0
    private real y = 0
    private real tarX = 0
    private real tarY = 0
    private real tick = 0
    private real dur = 0
    private effect sfxA = null

    method destroy takes nothing returns nothing
      local effect tempSfx = null
      local integer i = 0
      local unit u = null

      set tempSfx = AddSpecialEffect(INSTANTIATION_EFFECT_WARP_TARGET, this.x, this.y)
      call BlzSetSpecialEffectScale(tempSfx, INSTANTIATION_SCALE_WARP)
      call DestroyEffect(tempSfx)    
      set tempSfx = null
   
      set i = 0
      loop
        set u = FirstOfGroup(this.grp)
        exitwhen u == null
        call ShowUnit(u, true)
        call PauseUnit(u, false)
        call DemonType.startDuration(u)
        if GetDistanceBetweenPointsEx(this.x, this.y, this.tarX, this.tarY) > 50 then
          call IssuePointOrder(u, "attack", this.tarX, this.tarY)
        endif
        set i = i + 1
        call GroupRemoveUnit(this.grp, u)
      endloop 

      call DestroyGroup(this.grp)
      call DestroyEffect(this.sfxA)
      set this.grp = null
      set this.sfxA = null

      call this.stopPeriodic()
      call this.deallocate()
    endmethod

    method periodic takes nothing returns nothing     
      local integer i = 0       
      local unit u = null
      set this.tick = this.tick+1   

      if this.tick == this.dur then
        call DestroyEffect(this.sfxA)
        call this.destroy()
      endif     
    endmethod

    implement T32x

    static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, real dur, integer limit returns thistype
      local thistype this = thistype.allocate()
      local real ang = 0
      local real casterX = GetUnitX(caster)
      local real casterY = GetUnitY(caster)     
      local effect tempSfx = null
      local integer i = 0
      local unit u = null

      if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > INSTANTIATION_RANGE_WARP then
        set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
        set this.x = GetPolarOffsetX(casterX, INSTANTIATION_RANGE_WARP, ang)
        set this.y = GetPolarOffsetY(casterY, INSTANTIATION_RANGE_WARP, ang)
      else
        set this.x = x
        set this.y = y
      endif

      set this.tarX = x
      set this.tarY = y    

      set this.grp = CreateGroup()
      loop
      exitwhen i == limit
        call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
        set i = i + 1
      endloop
      set this.dur = dur*T32_FPS

      //Unit setup
      set i = 0
      loop
      exitwhen i == BlzGroupGetSize(this.grp)
        set u = BlzGroupUnitAt(this.grp, i)
        call ShowUnit(u, false)
        call PauseUnit(u, true)
        call SetUnitPosition(u, this.x, this.y)
        set i = i + 1
      endloop
      set u = null

      //Persistent destination effect
      set this.sfxA = AddSpecialEffect(INSTANTIATION_EFFECT_WARP_AREA, this.tarX, this.tarY)
      call BlzSetSpecialEffectScale(this.sfxA, INSTANTIATION_SCALE_WARP)

      call this.startPeriodic()

      set tempSfx = null
      
      return this                
    endmethod             

  endstruct    

endlibrary