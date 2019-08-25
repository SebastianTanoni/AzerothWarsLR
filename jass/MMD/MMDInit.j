library MMDInit initializer OnInit requires MMD

    private function Actions takes nothing returns nothing
        //Player statistics
        call MMD_DefineValue("unitsKilled",MMD_TYPE_INT,MMD_GOAL_HIGH,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("unitsLost",MMD_TYPE_INT,MMD_GOAL_LOW,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("unitsTrained",MMD_TYPE_INT,MMD_GOAL_HIGH,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("structuresRazed",MMD_TYPE_INT,MMD_GOAL_HIGH,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("structuresLost",MMD_TYPE_INT,MMD_GOAL_LOW,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("structuresBuilt",MMD_TYPE_INT,MMD_GOAL_HIGH,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("heroesKilled",MMD_TYPE_INT,MMD_GOAL_HIGH,MMD_SUGGEST_LEADERBOARD)
        call MMD_DefineValue("heroesLost",MMD_TYPE_INT,MMD_GOAL_LOW,MMD_SUGGEST_LEADERBOARD)    
        
        //Player flags
        call MMD_DefineValue("earlyDuel",MMD_TYPE_INT,MMD_GOAL_NONE,MMD_SUGGEST_LEADERBOARD)   //Will read either 0 or 1 to indicate false or true
        
        //Player metadata
        call MMD_DefineValue("team",MMD_TYPE_INT,MMD_GOAL_NONE,MMD_SUGGEST_NONE)
        
        //Events
        call MMD_DefineEvent1("earlyDuel", "{0}", "state")     //Duel describes who the duel was between, and state describes who won
    endfunction
    
    private function OnInit takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterTimerEvent(t, 0.1, false)
        call TriggerAddCondition(t, Condition(function Actions))
    endfunction   
     
endlibrary
