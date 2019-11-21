 
//When a Team is completely emptied, a particular research should be given to all players. 
//This research is a requirement for certain Second Chances to be researched.
 
 library EnableSecondChances initializer OnInit requires Team, Persons 

    globals
        private integer RESEARCH_DELAY = 5
    endglobals

    private function EnableResearchForAll takes integer researchId returns nothing
        local integer i = 0
        
        loop
        exitwhen i > MAX_PLAYERS
            call SetPlayerTechResearched(Player(i), researchId, 1)   
            set i = i + 1
        endloop
    endfunction

    private function DisableResearchForAll takes integer researchId returns nothing
        local integer i = 0
        
        loop
        exitwhen i > MAX_PLAYERS
            call SetPlayerTechResearched(Player(i), researchId, 0)   
            set i = i + 1
        endloop
    endfunction
    
    private function Actions takes nothing returns nothing
        local Team triggerTeam = GetTriggerTeam()
        if triggerTeam.size == 0 then
           call PlaySoundBJ( gg_snd_NewTournament )
           if triggerTeam.id == TEAM_SCOURGE then
              call StartTimerBJ( udg_Yoggtimer, false, RESEARCH_DELAY)
              set udg_Yoggtimerwindow = CreateTimerDialogBJ( udg_Yoggtimer, "Yogg unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Yoggtimerwindow ) 
              call EnableResearchForAll('R05K') 
              call DisplayTextToForce( GetPlayersAll(), "Yogg Saron second chance is now available" )
           elseif triggerTeam.id == TEAM_NORTH_ALLIANCE then
              call StartTimerBJ( udg_Ebontimer, false, RESEARCH_DELAY)
              set udg_Ebontimerwindow = CreateTimerDialogBJ( udg_Ebontimer, "Ebon unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Ebontimerwindow ) 
              call EnableResearchForAll('R05I')
              call DisplayTextToForce( GetPlayersAll(), "Ebon Blade second chance is now available" )
           elseif triggerTeam.id == TEAM_HORDE then
              call StartTimerBJ( udg_Cthuntimer, false, RESEARCH_DELAY)
              set udg_Cthuntimerwindow = CreateTimerDialogBJ( udg_Cthuntimer, "C'thun unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Cthuntimerwindow )             
              call EnableResearchForAll('R05C')
              call DisplayTextToForce( GetPlayersAll(), "C'thun second chance is now available" )
           elseif triggerTeam.id == TEAM_NIGHT_ELVES then
              call StartTimerBJ( udg_Cthuntimer, false, RESEARCH_DELAY)
              set udg_Cthuntimerwindow = CreateTimerDialogBJ( udg_Cthuntimer, "C'thun unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Cthuntimerwindow ) 
              call EnableResearchForAll('R05C')
              call DisplayTextToForce( GetPlayersAll(), "C'thun second chance is now available" )
           elseif triggerTeam.id == TEAM_SOUTH_ALLIANCE then  
              call StartTimerBJ( udg_Nzothtimer, false, RESEARCH_DELAY)
              set udg_Nzothtimerwindow = CreateTimerDialogBJ( udg_Nzothtimer, "N'zoth unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Nzothtimerwindow )    
              call EnableResearchForAll('R05J')
              call DisplayTextToForce( GetPlayersAll(), "N'zoth second chance is now available" )
           elseif triggerTeam.id == TEAM_FEL_HORDE then
              call StartTimerBJ( udg_Illidaritimer, false, RESEARCH_DELAY)
              set udg_Illidaritimerwindow = CreateTimerDialogBJ( udg_Illidaritimer, "Illidari unlocks in:" )
              call TriggerSleepAction(RESEARCH_DELAY)
              call DestroyTimerDialogBJ( udg_Illidaritimerwindow ) 
              call EnableResearchForAll('R05L')
              call DisplayTextToForce( GetPlayersAll(), "Illidari second chance is now available" )
           endif  
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call OnTeamSizeChange.register(trig)
        call TriggerAddAction(trig, function Actions)
    endfunction
    
endlibrary
