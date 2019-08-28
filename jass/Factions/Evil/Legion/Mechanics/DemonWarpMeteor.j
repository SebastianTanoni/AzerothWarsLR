library DemonWarpMeteor requires Table, Event, T32, Filters, Math, Instance

  globals
    constant integer WARP_TYPE_METEOR = 2
    constant string WARP_EFFECT_METEOR = "Units\\Demon\\Infernal\\InfernalBirth.mdl"
    constant real WARP_RANGE_METEOR = 3000.
    constant real WARP_DAMAGE_METEOR = 50.
    constant real WARP_RADIUS_METEOR = 200.
  endglobals

  struct Meteor //The animation that plays out to bring an Infernal or similar unit to the world
    private group grp = null
    private DemonType whichDemonType = 0
    private real x = 0
    private real y = 0
    private real tarX = 0
    private real tarY = 0
    private real tick = 0
    private real dur = 0

    method destroy takes nothing returns nothing
      call DestroyGroup(this.grp)
      set this.grp = null
      call this.stopPeriodic()
      call this.deallocate()
    endmethod

    method finish takes nothing returns nothing
      local integer i = 0
      local unit u = null

      loop
      exitwhen i == BlzGroupGetSize(this.grp)
        set u = BlzGroupUnitAt(this.grp, i)
        call PauseUnit(u, false)
        call DemonType.startDuration(u)
        if GetDistanceBetweenPointsEx(this.x, this.y, this.tarX, this.tarY) > 50 then
            call IssuePointOrder(u, "attack", this.tarX, this.tarY)
        endif
        set i = i + 1
      endloop
      set u = null

      call this.destroy()
    endmethod

    method impact takes nothing returns nothing
      local unit target = null
      local unit u = null
      local integer i = 0
      
      set i = 0
      loop
      exitwhen i == BlzGroupGetSize(this.grp)
        set u = BlzGroupUnitAt(this.grp, i)
        call ShowUnit(u, true)
        call QueueUnitAnimation(u, "stand")
        set i = i + 1
      endloop

      set u = FirstOfGroup(this.grp)
      set P = GetOwningPlayer(u)  
      call GroupEnumUnitsInRange(TempGroup,this.x,this.y,WARP_RADIUS_METEOR,Condition(function EnemyAliveFilter))
      loop
        set target = FirstOfGroup(TempGroup)
        exitwhen target == null
        call UnitDamageTarget(u, target, this.whichDemonType.warpDamage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        call GroupRemoveUnit(TempGroup,target)
      endloop  
      set u = null
    endmethod

    method periodic takes nothing returns nothing            
      set this.dur = this.dur+1
      set this.tick = this.tick+1  

      if this.dur == 1*T32_FPS then
        call this.impact()
      endif     

      if this.dur >= 3.*T32_FPS then
        call this.finish()
      endif    
    endmethod

    implement T32x

    static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, integer limit returns thistype
      local thistype this = thistype.allocate()
      local real ang = 0
      local real casterX = GetUnitX(caster)
      local real casterY = GetUnitY(caster)     
      local unit u = null
      local integer i = 0       

      //Import group
      set this.grp = CreateGroup()
      loop
      exitwhen i == limit
        call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
        set i = i + 1
      endloop
      set this.whichDemonType = DemonType.demonsByUnitId[GetUnitTypeId(FirstOfGroup(this.grp))]

      if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > this.whichDemonType.warpRange then
        set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
        set this.x = GetPolarOffsetX(casterX, this.whichDemonType.warpRange, ang)
        set this.y = GetPolarOffsetY(casterY, this.whichDemonType.warpRange, ang)
      else
        set this.x = x
        set this.y = y
      endif

      set this.tarX = x
      set this.tarY = y

      //Handle group
      set i = 0
      loop
      exitwhen i == BlzGroupGetSize(this.grp)
        set u = BlzGroupUnitAt(this.grp, i)
        call SetUnitPosition(u, this.x, this.y)
        call DestroyEffect(AddSpecialEffect(WARP_EFFECT_METEOR, GetUnitX(u), GetUnitY(u)))    
        call ShowUnit(u, false)
        call PauseUnit(u, true)  
        call SetUnitAnimation(u, "birth")
        set i = i + 1
      endloop
      set u = null

      call this.startPeriodic()
      
      return this                
    endmethod             

  endstruct

endlibrary