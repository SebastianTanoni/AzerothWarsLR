library TeamButton initializer OnInit requires Persons, Team, Faction

    globals
        private constant integer COOLDOWN = 10
    endglobals

    struct TeamButton
        private static Table teamButtons                //These are indexed by creation time
        private static integer teamButtonCount = 0
        private static integer allianceCenter = 'h06M'  //Only casts from this unit will be checked
        private static group   allianceCenterGroup
        private static unit array allianceCenters[12]
        private static boolean initialized = false
    
        private integer id = 0                          //Must be unique
        private integer abilId = 0                      //The ID of the ability that has to be pressed
        private Team team = 0                           //The ID of the team that this button lets you create or join
        private integer teamId = 0
        private integer factionCount = 0                //Just a count of the above
        private string baseTooltip = ""                 //Non-dynamic tooltip before being modified by conditional factors
        
        method cast takes player p returns nothing
            local Person caster = Persons[GetPlayerId(p)]
            local Faction faction = caster.getFaction()
            local Person test
            local Person person = 0
            local Team team = 0
            local boolean canJoin = true
            local integer i = 0
            local boolean inTeam = false
            
            local string array errors
            local integer errorCount = 0
 
            if  this.team == caster.getTeam() then
                set canJoin = false
                set errors[errorCount] = "You are already in this team."
                set errorCount = errorCount + 1
            endif
            
            if canJoin then
                set i = 0
                loop
                exitwhen i >= this.team.getFactionCount()
                    if faction == this.team.getFactionBySlot(i) then
                        set inTeam = true
                    endif
                set i = i + 1    
                endloop
                if not inTeam then
                    set canJoin = false
                    set errors[errorCount] = faction.getPrefixCol() + faction.getName() + "|r is not an eligible member."
                    set errorCount = errorCount+1                    
                endif
            endif
                
            if canJoin then
                set i = 0
                loop
                exitwhen i >= this.team.getFactionCount()
                    set faction = this.team.getFactionBySlot(i)
                    set person = PersonsByFaction[this.team.getFactionBySlot(i).getId()]
                    set team = person.getTeam()
                    if team.getSize() >= team.getMaxSize() then
                        set canJoin = false
                        set errors[errorCount] = faction.getPrefixCol() + faction.getName() + "|r is already in a full team."
                        set errorCount = errorCount+1
                    endif
                    set i = i + 1
                endloop                        
            endif
            
            if canJoin then
                call caster.setTeam(this.teamId)
                set faction = caster.getFaction()
                call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, faction.getPrefixCol() + faction.getName() + "|r has joined the " + this.team.getName() + ".")
            else
                set i = 0
                call DisplayTextToPlayer(p, 0, 0, "You cannot join the " + this.team.getName() + " because:")
                loop
                exitwhen i == errorCount
                    call DisplayTextToPlayer(p, 0, 0, " - " + errors[i])
                    set i = i + 1
                endloop
            endif
        endmethod

        method getAbilId takes nothing returns integer
            return this.abilId
        endmethod

        method refresh takes nothing returns nothing
            //Determines tooltip of the button based on Team and Faction data
            //Checks availability of team conditions
            local integer i = 0
            local Faction faction = 0
            local Person person
            
            set this.baseTooltip = "All eligible members must have no teammates in order for this team to be joined.|n|nEligible members:|n"
            call BlzSetAbilityTooltip(this.abilId, "|cffffa500" + "Join Team|r: The " + this.team.getName(), 0)
            call BlzSetAbilityIcon(this.abilId, this.team.getIcon())

            //Add all eligible factions to the tooltip
            loop
            exitwhen i >= this.team.getFactionCount()
                set faction = this.team.getFactionBySlot(i)
                set this.baseTooltip = this.baseTooltip + " - " + faction.getPrefixCol() + faction.getName() + "|r|n"           
                set i = i + 1
            endloop
            
            call BlzSetAbilityExtendedTooltip(this.abilId, this.baseTooltip, 0)
        endmethod

        static method initialize takes nothing returns nothing
            //This is only used in buildAllianceCenter so that abilities aren't removed when the Center can't possibly have any
            set thistype.initialized = true
        endmethod
        
        static method buildAllianceCenter takes player p returns nothing
            //Adds TeamButtons to this player's Alliance Center if they have a Faction that can join the Team that TeamButton is tied to 
            //Initialize should be true only when this is first called
            local integer pId = GetPlayerId(p)
            local unit u = thistype.allianceCenters[pId]
            local integer i = 0 
            local TeamButton butt = 0
            
            loop
            exitwhen i == thistype.teamButtonCount
                set butt = thistype.teamButtons[i]
                if butt.team.containsFaction(Persons[pId].getFaction()) == true then
                    call UnitAddAbility(u, butt.abilId)
                else
                    if thistype.initialized then
                        call UnitRemoveAbility(u, butt.abilId)
                    endif
                endif
            set i = i + 1
            endloop
        endmethod

        static method getAllianceCenterUnit takes integer playerIndex returns unit
            return thistype.allianceCenters[playerIndex]
        endmethod

        static method getAllianceCenterType takes nothing returns integer
            return thistype.allianceCenter
        endmethod
        
        static method getButton takes integer index returns TeamButton
            return thistype.teamButtons[index]
        endmethod
        
        static method getButtonCount takes nothing returns integer
            return thistype.teamButtonCount
        endmethod
        
        static method create takes integer teamId, integer abilId returns TeamButton
            local TeamButton this = TeamButton.allocate()
            
            set this.abilId = abilId
            set this.teamId = teamId
            set this.team = Team.getTeam(teamId)
            
            if this.team == 0 then
                call BJDebugMsg("ERROR: Registered TeamButton to nonexistant team " + I2S(teamId))
            endif
            
            set thistype.teamButtons[teamButtonCount] = this
            set thistype.teamButtonCount = thistype.teamButtonCount + 1
            
            call this.refresh()
            
            return this                
        endmethod     
        
        private static method setAllianceCenters takes nothing returns nothing
            //Places individual preplaced Alliance Centers into a player-indexed array for later use
            //This method makes the assumption that each player only ever has one Alliance Center
            local player p = GetOwningPlayer(GetEnumUnit())
            set thistype.allianceCenters[GetPlayerId(p)] = GetEnumUnit()
        endmethod
        
        private static method onInit takes nothing returns nothing
            set thistype.teamButtons = Table.create()
            set thistype.allianceCenterGroup = GetUnitsOfTypeIdAll(thistype.allianceCenter)
            
            call ForGroup(thistype.allianceCenterGroup, function thistype.setAllianceCenters)
        endmethod

    endstruct

    private function InitializeAllianceCenters takes nothing returns nothing
        //This has to be run after the game starts so that everything is definitely configured
        local integer i = 0
        loop
        exitwhen i == MAX_PLAYERS
            call TeamButton.buildAllianceCenter(Player(i))
            call TeamButton.initialize()
            set i = i + 1
        endloop
    endfunction

    private function Cast takes nothing returns nothing
        local integer spellId = 0
        local TeamButton butt = 0
        local integer buttonSpellId = 0
        local integer i = 0

        if GetUnitTypeId(GetTriggerUnit()) == TeamButton.getAllianceCenterType() then
            set spellId = GetSpellAbilityId()
            loop
            exitwhen i > TeamButton.getButtonCount()
                set butt = TeamButton.getButton(i)
                set buttonSpellId = butt.getAbilId()
                if buttonSpellId == spellId then
                    call butt.cast(GetTriggerPlayer())
                    return
                endif
                set i = i + 1
            endloop
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_CAST )
        call TriggerAddCondition( trig, Condition(function Cast) )
        
        set trig = CreateTrigger()
        call TriggerRegisterTimerEvent(trig, 0.5, false)
        call TriggerAddCondition(trig, Condition(function InitializeAllianceCenters))     
    endfunction     

endlibrary
