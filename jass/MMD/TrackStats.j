/* library TrackStats initializer OnInit requires MMD, MMDInit, Persons
    
    private function UnitDies takes nothing returns nothing
        local unit deadUnit = GetTriggerUnit()
    
        local player killingPlayer = GetOwningPlayer(GetKillingUnit())
        local integer killingPlayerId = GetPlayerId(killingPlayer)
        local player dyingPlayer = GetOwningPlayer(GetTriggerUnit())
        local integer dyingPlayerId = GetPlayerId(dyingPlayer)
        
        if not IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) == true then 
        
            if killingPlayer != null and killingPlayerId >= 0 and killingPlayerId < 24 and killingPlayer != dyingPlayer then
                set Persons[killingPlayerId].unitsKilled = Persons[killingPlayerId].unitsKilled + 1
                call MMD_UpdateValueInt("unitsKilled",killingPlayer,MMD_OP_SET,Persons[dyingPlayerId].unitsKilled)
            endif
            
            if dyingPlayerId >= 0 and dyingPlayerId < 24 then
                set Persons[dyingPlayerId].unitsLost = Persons[dyingPlayerId].unitsLost + 1
                call MMD_UpdateValueInt("unitsLost",dyingPlayer,MMD_OP_SET,Persons[dyingPlayerId].unitsLost)
            endif
            
        endif
        
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_STRUCTURE) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) == true then

            if killingPlayer != null and killingPlayerId >= 0 and killingPlayerId < 24 and killingPlayer != dyingPlayer then
                set Persons[killingPlayerId].structuresKilled = Persons[killingPlayerId].structuresKilled + 1
                call MMD_UpdateValueInt("structuresRazed",killingPlayer,MMD_OP_SET,Persons[killingPlayerId].structuresKilled)
            endif
            
            if dyingPlayerId >= 0 and dyingPlayerId < 24 then
                set Persons[dyingPlayerId].structuresLost = Persons[dyingPlayerId].structuresLost + 1
                call MMD_UpdateValueInt("structuresLost",dyingPlayer,MMD_OP_SET,Persons[dyingPlayerId].structuresLost)
            endif        
            
        endif
        
        if IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) and not IsUnitType(GetTriggerUnit(), UNIT_TYPE_SUMMONED) == true then

            if killingPlayer != null and killingPlayerId >= 0 and killingPlayerId < 24 and killingPlayer != dyingPlayer then
                set Persons[killingPlayerId].heroesKilled = Persons[killingPlayerId].heroesKilled + 1
                call MMD_UpdateValueInt("heroesKilled",killingPlayer,MMD_OP_SET,Persons[killingPlayerId].heroesKilled)
            endif
            
            if dyingPlayerId >= 0 and dyingPlayerId < 24 then
                set Persons[dyingPlayerId].heroesLost = Persons[dyingPlayerId].heroesLost + 1
                call MMD_UpdateValueInt("heroesLost",dyingPlayer,MMD_OP_SET,Persons[dyingPlayerId].heroesLost)
            endif        
            
        endif        
    
    endfunction
    
    private function UnitFinishesConstruction takes nothing returns nothing
        local player p = GetOwningPlayer(GetTriggerUnit())
        local integer pi = GetPlayerId(p)
        
        set Persons[pi].structuresBuilt = Persons[pi].structuresBuilt + 1
        call MMD_UpdateValueInt("structuresBuilt",p,MMD_OP_SET,Persons[pi].structuresBuilt)
    endfunction
    
    private function UnitFinishesTraining takes nothing returns nothing
        local player p = GetOwningPlayer(GetTriggerUnit())
        local integer pi = GetPlayerId(p)
    
        set Persons[pi].unitsTrained = Persons[pi].unitsTrained + 1
        call MMD_UpdateValueInt("unitsTrained",p,MMD_OP_SET,Persons[pi].unitsTrained)
    endfunction
    
    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger(  )
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_DEATH )
        call TriggerAddCondition( trig, Condition(function UnitDies) )
        
        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_CONSTRUCT_FINISH )
        call TriggerAddCondition( trig, Condition(function UnitFinishesConstruction) )
        
        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_TRAIN_FINISH )
        call TriggerAddCondition( trig, Condition(function UnitFinishesTraining) )
    endfunction        

endlibrary
 */