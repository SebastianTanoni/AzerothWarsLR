library ReapingHour initializer OnInit requires T32

  globals
    private constant integer ABIL_ID = 'A10N'

    private constant real RANGE = 1500.
    private constant real VELOCITY = 250.
    private constant real RADIUS = 50. //Radius of each Horsemen's damage
    private constant integer HORSEMEN_COUNT = 7 //Must be an odd number
    private constant real HORSEMEN_WIDTH = 700. //The total width of the spell
    private constant real DIST_FADE_START = 400.  //When the spell has this many units left to travel, the special effect begins to fade out

    private constant real DAMAGE_BASE = 200.
    private constant real DAMAGE_LEVEL = 100.
    private constant real EXECUTE_PERC = 1 //% of extra damage per % of lost life

    private constant string EFFECT_PROJ = "units\\undead\\HeroDeathKnight\\HeroDeathKnight.mdl"
    private constant real EFFECT_SCALE_PROJ = 0.7
    private constant string EFFECT_HIT = "Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
    private constant real EFFECT_SCALE_HIT = 0.7
    private constant string EFFECT_SPAWN = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"
    private constant real EFFECT_SCALE_SPAWN = 0.5
  endglobals

  private struct Reap
    private unit caster = null
    private effect sfx = null
    private real x = 0
    private real y = 0
    private real tick = 0
    private real face = 0
    private real curDist = 0
    private real maxDist = 0
    private real damage = 0
    private group hitGroup = null   //Units already hit by this Reap

    method destroy takes nothing returns nothing
      call DestroyEffect(this.sfx)
      set this.sfx = null

      call this.stopPeriodic()
      call this.deallocate()
    endmethod

    method doHit takes nothing returns nothing
      local group tempGroup = CreateGroup()
      local integer i = 0
      local unit u = null
      local effect tempEffect = null
      local real damageMult = 0
      call GroupEnumUnitsInRange(tempGroup, this.x, this.y, RADIUS, null)
      loop
      exitwhen BlzGroupGetSize(tempGroup) == 0
        set u = FirstOfGroup(tempGroup)
        if not IsUnitInGroup(u, this.hitGroup) and not IsUnitAlly(u, GetOwningPlayer(this.caster)) and IsUnitAlive(u) and not BlzIsUnitInvulnerable(u) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and not IsUnitType(u, UNIT_TYPE_ANCIENT) then
          set damageMult = 1 + ((GetUnitState(u, UNIT_STATE_MAX_LIFE) - GetUnitState(u, UNIT_STATE_LIFE))/GetUnitState(u, UNIT_STATE_MAX_LIFE))*EXECUTE_PERC
          call UnitDamageTarget(this.caster, u, this.damage*damageMult, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
          set tempEffect = AddSpecialEffect(EFFECT_HIT, GetUnitX(u), GetUnitY(u))
          call BlzSetSpecialEffectScale(tempEffect, EFFECT_SCALE_HIT)
          call DestroyEffect(tempEffect)
          set tempEffect = null
          call GroupAddUnit(this.hitGroup, u)
        endif
        call GroupRemoveUnit(tempGroup, u)
      endloop
      call DestroyGroup(tempGroup)
      set tempGroup = null
      set u = null
    endmethod

    method periodic takes nothing returns nothing
      set this.tick = this.tick + 1
      set this.x = GetPolarOffsetX(this.x, VELOCITY/T32_FPS, this.face)
      set this.y = GetPolarOffsetY(this.y, VELOCITY/T32_FPS, this.face)
      call BlzSetSpecialEffectX(this.sfx, this.x)
      call BlzSetSpecialEffectY(this.sfx, this.y)
      call BlzSetSpecialEffectZ(this.sfx, GetPositionZ(this.x, this.y))
      set this.curDist = this.curDist + VELOCITY/T32_FPS

      call this.doHit()

      //Begin fadeout near the end of the path
      if this.curDist > (this.maxDist - DIST_FADE_START) then
        call BlzSetSpecialEffectAlpha( this.sfx, R2I(255*( 1 - ( ( this.curDist / this.maxDist ) ) ) ))
      endif   

      //Ended path
      if this.curDist >= this.maxDist then
        call this.destroy()
      endif
    endmethod

    implement T32x

    static method create takes unit caster, real x, real y, real face, real damage, real maxDist returns thistype
      local thistype this = thistype.allocate()
      local effect tempSfx = AddSpecialEffect(EFFECT_SPAWN, x, y)
      call DestroyEffect(tempSfx)
      call BlzSetSpecialEffectScale(tempSfx, EFFECT_SCALE_SPAWN)

      set this.caster = caster
      set this.x = x
      set this.y = y
      set this.face = face
      set this.maxDist = maxDist
      set this.damage = damage
      set this.sfx = AddSpecialEffect(EFFECT_PROJ, x, y)
      call BlzSetSpecialEffectAlpha(this.sfx, 100)
      call BlzSetSpecialEffectYaw(this.sfx, face*bj_DEGTORAD)
      call BlzPlaySpecialEffect(this.sfx, ANIM_TYPE_WALK)
      call BlzSetSpecialEffectScale(this.sfx, EFFECT_SCALE_PROJ)
      set this.hitGroup = CreateGroup()

      call this.startPeriodic()

      return this
    endmethod
  endstruct

  private function Cast takes nothing returns nothing
    local ability triggerAbility = null
    local unit triggerUnit = null
    local real triggerX = 0
    local real triggerY = 0
    local real triggerFace = 0
    local integer i = 0
    local real offsetAngle = 0
    local real offsetDist = 0
    local integer middle = 0
    local integer level = 0
    if GetSpellAbilityId() == ABIL_ID then
      set triggerUnit = GetTriggerUnit()
      set triggerX = GetUnitX(triggerUnit)
      set triggerY = GetUnitY(triggerUnit)
      set triggerFace = GetUnitFacing(triggerUnit)
      set level = GetUnitAbilityLevel(triggerUnit, ABIL_ID)    

      set i = 0
      loop
      exitwhen i == HORSEMEN_COUNT
        set middle = (HORSEMEN_COUNT-1)/2
        if i < middle then
          set offsetAngle = triggerFace-90 - 15*(middle-i)
          set offsetDist = (middle - i)*(HORSEMEN_WIDTH / HORSEMEN_COUNT)
        elseif i > middle then
          set offsetAngle = triggerFace+90 + 15*(i - middle)
          set offsetDist = (i - middle)*(HORSEMEN_WIDTH / HORSEMEN_COUNT)
        else
          set offsetAngle = 0
          set offsetDist = 0
        endif
        call Reap.create(triggerUnit, GetPolarOffsetX(triggerX, offsetDist, offsetAngle), GetPolarOffsetY(triggerY, offsetDist, offsetAngle), triggerFace, DAMAGE_BASE + DAMAGE_LEVEL*level, RANGE)
        set i = i + 1
      endloop

      set triggerUnit = null
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trig, Condition(function Cast))
  endfunction

endlibrary