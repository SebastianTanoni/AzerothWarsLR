library LegionRitual initializer OnInit requires T32, Math, Table, DemonTypeConfig, Faction, DetermineLevel

  globals
    private constant integer ABIL_ID_BOOK = 'A10O'   
    private constant integer ABIL_ID_NOBOOK = 'A0UW'

    private constant string EFFECT_CASTER = "Doodads\\Cinematic\\ShimmeringPortal\\ShimmeringPortal.mdl"
    private constant string EFFECT_FINISH = "war3mapImported\\Soul Discharge Purple.mdx"
    private constant real EFFECT_BIRTH_CASTER = 9.3   //The length of the birth animation for Shimmering Portal
    private constant real EFFECT_SCALE_CASTER = 1.0
    private constant real EFFECT_SCALE_FINISH = 2.
    private constant real OFFSET = 100                //How far in front of the caster to make the portal
    private constant integer PROGRESS_UPGRADE = 'R04S'  //Only enabled if a Legion Summoning is not in progress
    private constant integer FINISHED_UPGRADE = 'R02J'
  endglobals

  private struct LegionRitual
    readonly static Table legionRitualsByUnitId = 0

    private unit caster = null
    private effect sfx = null
    private timer ritualTimer = null
    private timerdialog ritualTimerDialog = null
    private real tick = 0
    private real duration = 0
    private real elapsed = 0
    private real x = 0
    private real y = 0
    private real facing = 0

    method destroy takes nothing returns nothing
      call BlzSetSpecialEffectTimeScale(this.sfx, 1)
      call DestroyEffect(this.sfx)
      set this.sfx = null
      call DestroyTimerDialog(this.ritualTimerDialog)
      call DestroyTimer(this.ritualTimer)

      set thistype.legionRitualsByUnitId[GetHandleId(this.caster)] = 0

      call this.stopPeriodic()
      call this.deallocate()
    endmethod

    method endEarly takes nothing returns nothing
      local integer i = 0
      loop
      exitwhen i == MAX_PLAYERS
        call SetPlayerTechResearched(Player(i), PROGRESS_UPGRADE, 1)
        set i = i + 1
      endloop

      call this.destroy()
    endmethod

    method doSummon takes nothing returns nothing
      local effect tempSfx = null
      local DemonType tempDemonType = 0
      local Person tempPerson = 0
      local Faction tempFaction = 0
      local string name = null
      local unit tempUnit = null
      local integer i = 0
      local Person legion = PersonsByFaction[FACTION_LEGION]
      set tempSfx = AddSpecialEffect(EFFECT_FINISH, this.x, this.y)
      call BlzSetSpecialEffectScale(tempSfx, EFFECT_SCALE_FINISH)
      call BlzSetSpecialEffectPosition(tempSfx, 100000, 100000,0)
      call DestroyEffect(tempSfx)

      loop
      exitwhen i == MAX_PLAYERS
        call SetPlayerTechResearched(Player(i), FINISHED_UPGRADE, 0)
        set i = i + 1
      endloop

      //Infernal 
      set tempDemonType = DemonType.demonsByUnitId['ninf']    
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Nether Dragon
      set tempDemonType = DemonType.demonsByUnitId['n04U']
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Fel Reaver
      set tempDemonType = DemonType.demonsByUnitId['u00K']
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Doom Guard
      set tempDemonType = DemonType.demonsByUnitId['n04O']
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Infernal Juggernaut
      set tempDemonType = DemonType.demonsByUnitId['n04L']
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Felguard
      set tempDemonType = DemonType.demonsByUnitId['n04H']
      call tempDemonType.setWarpCost(WARP_COST_NORMAL)
      //Portal
      call CreateUnit(legion.p, 'h015', this.x, this.y, this.facing)
      //Archimonde
      set tempUnit = CreateUnit(legion.p, 'Uwar', this.x, this.y, this.facing)
      call UnitDetermineLevel(tempUnit, 1.3)
      call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", GetUnitX(tempUnit), GetUnitY(tempUnit)))
      //Azgalor
      set tempUnit = CreateUnit(legion.p, 'Npld', this.x, this.y, this.facing)
      call UnitDetermineLevel(tempUnit, 1.1)
      call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", GetUnitX(tempUnit), GetUnitY(tempUnit)))

      set tempPerson = Persons[GetPlayerId(GetOwningPlayer(this.caster))]
      set tempFaction = tempPerson.getFaction()
      if IsUnitType(this.caster, UNIT_TYPE_HERO) then
        set name = GetHeroProperName(this.caster)
      else
        set name = GetUnitName(this.caster)
      endif
      call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Long ago, the Highborne's reckless use of magic signalled Sargeras to the limitless power of Azeroth's core, leading to the sundering of the world. Through the efforts of " + tempFaction.getPrefixCol() + name + "|r, the Burning Legion has returned once more. Tremble, mortals, and despair!")  

      call this.destroy()
    endmethod

    method periodic takes nothing returns nothing
      if this.caster == null then
        call this.destroy()
        return
      endif
      set this.tick = this.tick + 1

      if this.tick == 5*T32_FPS then
        call PingMinimap(this.x, this.y, 5) 
        set this.tick = 0
      endif

      set this.elapsed = this.elapsed + 1
      if this.elapsed == this.duration then
        call this.doSummon()
      endif
    endmethod

    implement T32x

    static method create takes unit caster, real x, real y, real facing, real duration returns thistype
      local thistype this = thistype.allocate()
      local integer i = 0
      local Person tempPerson = 0
      local Faction tempFaction = 0
      local string name = null
      
      set this.x = x
      set this.y = y
      set this.facing = facing

      set this.sfx = AddSpecialEffect(EFFECT_CASTER, x, y)
      call BlzSetSpecialEffectColorByPlayer(this.sfx, GetOwningPlayer(this.caster))
      call BlzSetSpecialEffectTimeScale(this.sfx, 1/(duration/EFFECT_BIRTH_CASTER))
      call BlzSetSpecialEffectYaw(this.sfx, facing*bj_DEGTORAD)
      call BlzSetSpecialEffectScale(this.sfx, EFFECT_SCALE_CASTER)
      set this.duration = duration*T32_FPS
      set this.caster = caster

      //Timer and periodic
      set this.ritualTimer = CreateTimer()
      set this.ritualTimerDialog = CreateTimerDialog(this.ritualTimer)
      call TimerDialogDisplay(this.ritualTimerDialog, true)
      call TimerDialogSetTitle(this.ritualTimerDialog, "Legion summoned in:")    
      call TimerStart(this.ritualTimer, duration, false, null)
      call this.startPeriodic()

      //Alert
      set tempPerson = Persons[GetPlayerId(GetOwningPlayer(this.caster))]
      set tempFaction = tempPerson.getFaction()
      if IsUnitType(this.caster, UNIT_TYPE_HERO) then
        set name = GetHeroProperName(this.caster)
      else
        set name = GetUnitName(this.caster)
      endif      
      call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, tempFaction.getPrefixCol() + name + "|r is summoning the Burning Legion to Azeroth!")  
      call PingMinimap(this.x, this.y, 5) 

      //Table
      set this.legionRitualsByUnitId[GetHandleId(caster)] = this

      loop
      exitwhen i == MAX_PLAYERS
        call SetPlayerTechResearched(Player(i), PROGRESS_UPGRADE, 0)
        set i = i + 1
      endloop

      return this
    endmethod

      static method onInit takes nothing returns nothing
        set thistype.legionRitualsByUnitId = Table.create()
      endmethod
  endstruct

  private function StopCast takes nothing returns nothing
    local LegionRitual tempLegionRitual = 0
    if GetSpellAbilityId() == ABIL_ID_BOOK or GetSpellAbilityId() == ABIL_ID_NOBOOK then
      set tempLegionRitual = LegionRitual.legionRitualsByUnitId[GetHandleId(GetTriggerUnit())]
      call tempLegionRitual.endEarly()
    endif
  endfunction

  private function Cast takes nothing returns nothing
    local ability triggerAbility = null
    local unit triggerUnit = null
    local real angle = 0
    local real triggerX = 0
    local real triggerY = 0
    local real finalX = 0 
    local real finalY = 0
    if GetSpellAbilityId() == ABIL_ID_BOOK or GetSpellAbilityId() == ABIL_ID_NOBOOK then
      set triggerUnit = GetTriggerUnit()
      set triggerAbility = BlzGetUnitAbility(triggerUnit, GetSpellAbilityId())
      set triggerX = GetUnitX(triggerUnit)
      set triggerY = GetUnitY(triggerUnit)
      set angle = GetAngleBetweenPoints(triggerX, triggerY, GetSpellTargetX(), GetSpellTargetY()) //In degrees
      set finalX = GetPolarOffsetX(triggerX, OFFSET, angle)
      set finalY = GetPolarOffsetY(triggerY, OFFSET, angle)
      call LegionRitual.create(triggerUnit, finalX, finalY, angle, BlzGetAbilityRealLevelField(triggerAbility, ABILITY_RLF_FOLLOW_THROUGH_TIME, 0))
    endif
  endfunction

  private function OnInit takes nothing returns nothing
    local trigger trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( trig, Condition(function Cast))

    set trig = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddCondition( trig, Condition(function StopCast))
  endfunction

endlibrary