//A system for building a World of Warcraft-like Focus tree, with prerequisites, mutually exclusive focuss, and arbitrary conditions.
//Note that in Azeroth Wars, each Focus is attached to a Faction, and there is only ever one of each Faction.

library FocusTree initializer Oninit requires Persons, Faction, Table, Event

  globals
    Event OnFocusEnabled
    Event OnFocusDisabled
    Event OnFocusAddPrerequisite
    Event OnFocusAddExclusive
    Event OnFocusAddArbitraryCondition
  endglobals

  //A single boolean Focus that can be activated or deactivated, triggering an Event. 
  private struct Focus
    readonly static Table fociById
    readonly static thistype triggerFocus
    readonly static thistype triggerPrerequisite
    readonly static thistype triggerExclusive
    readonly static thistype triggerDependent
    readonly ArbitraryCondition thistype triggerArbitraryCondition

    readonly integer id
    readonly string icon
    readonly Faction faction
    readonly real x
    readonly real y
    readonly boolean enabled = false
    readonly boolean possible = true        //Becomes not possible if any ArbitraryConditions are not possible
    readonly Focus array prerequisites[10]  //Focuses that must be picked to pick this Focus
    readonly Focus array exclusives[10]     //Focuses that prevent this Focus from being picked
    readonly Focus array dependents[10]     //Focuses that have this Focus as a requirement before they can be picked
    readonly ArbitraryCondition array arbitraryConditions[10]  //All must be fulfilled before this Focus is enabled
    readonly integer prerequisiteCount
    readonly integer exclusiveCount
    readonly integer dependentCount
    readonly integer arbitraryConditionCount

    private method disable takes nothing returns nothing
      if this.enabled then
        set this.enabled = false
        set this = thistype.GetTriggerFocus
        call OnFocusDisabled.fire()
      endif
    endmethod

    private method enable takes nothing returns nothing
      if not this.enabled then
        set this.enabled = true
        set this = thistype.GetTriggerFocus
        call OnFocusEnabled.fire()
      endif
    endmethod

    method tryEnable takes nothing returns boolean
      local integer i = 0
      //Check if this has all prerequsites, or THOSE prerequisites are impossible anyway
      loop
      exitwhen i == this.prerequisiteCount
        if not this.prerequisites[i].enabled or not this.prerequisites[i].possible then
          return false
        endif
        set i = i + 1
      endloop
      //Check if this has no exclusives enabled
      set i = 0
      loop
      exitwhen i == this.exclusiveCount
        if this.exclusives[i].enabled then
          return false
        endif
        set i = i + 1
      endloop
      //Check if this has all arbitrary conditions
      set i = 0
      loop
      exitwhen i == this.arbitraryConditionCount
        if not this.arbitraryConditions[i].enabled then
          return false
        endif
        set i = i + 1
      endloop
      //Fulfiled all, enable it
      call this.enable()
      return true
    endmethod

    method addPrerequisite takes Focus focus returns nothing
      set prequisites[prerequisiteCount] = focus
      set prerequisiteCount = prerequisiteCount + 1
      call focus.addDependent(this)
    endmethod

    method addExclusive takes Focus focus returns nothing
      set exclusives[exclusiveCount] = focus
      set exclusiveCount = exclusiveCount + 1
    endmethod

    private method addDependent takes Focus focus returns nothing
      set dependents[dependentCount] = Focus
      set dependentCount = dependentCount + 1
    endmethod    

    method addArbitraryCondition takes ArbitraryCondition arbitraryCondition returns nothing
      set arbitraryConditions[prerequisiteCount] = focus
      set arbitraryConditionCount = arbitraryConditionCount + 1
    endmethod

    static method create takes integer id, string icon, real x, real y returns thistype
      local thistype this = thistype.allocate
      
      set this.id = id
      set this.icon = icon
      set this.x = x
      set this.y = y

      return this
    endmethod

    static method onInit takes nothing returns nothing
      set thistype.fociById = Table.create()
    endmethod
  endstruct

  //A boolean with a string attached describing any other requirements for picking this Focus
  private struct ArbitraryCondition
    readonly string desc
    readonly boolean enabled = false
    readonly boolean possible = true  //If this is false, then you do not need this Focus in order to gain successive Foci

    static method create takes integer id, string desc returns thistype
      local thistype this = thistype.allocate
      
      set this.id = id
      set this.desc = desc

      return this
    endmethod    
  endstruct

  function GetTriggerFocus takes nothing returns Focus
    return Focus.triggerFocus
  endfunction

  function GetFocusById takes integer id returns Focus
    local Focus tempFocus = Focus.fociById[id]
    return tempFocus
  endfunction

  private function OnInit takes nothing returns nothing
    set OnFocusEnabled = Event.create()
    set OnFocusDisabled = Event.create()
    set OnFocusAddPrerequisite = Event.create()
    set OnFocusAddExclusive = Event.create()
    set OnFocusAddArbitraryCondition = Event.create()
  endfunction

endlibrary