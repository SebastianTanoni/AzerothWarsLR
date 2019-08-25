//This ensures that Demigod limitations are universal for all players.
//If someone starts training one, it's disabled for everyone permanently. This is NOT a FactionMod. 

library EventDruidDemigodDies initializer OnInit requires Persons

    private function TrainStart takes nothing returns nothing
        local integer unitTypeId = GetTrainedUnitType()
        local Person tempPerson = 0
        local integer i = 0
        if unitTypeId == 'n08C' or unitTypeId == 'e009' or unitTypeId == 'n05F' or unitTypeId == 'e007' then
            loop
            exitwhen i > MAX_PLAYERS
                set tempPerson = Persons[i]
                if tempPerson != 0 and tempPerson != Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then   //Do not apply anything for training player until unti finishes training
                    call tempPerson.modObjectLimit(unitTypeId, -UNLIMITED)
                endif
                set i = i + 1
            endloop
        endif
    endfunction

    private function TrainCancel takes nothing returns nothing
        local integer unitTypeId = GetTrainedUnitType()
        local Person tempPerson = 0
        local integer i = 0
        if unitTypeId == 'n08C' or unitTypeId == 'e009' or unitTypeId == 'n05F' or unitTypeId == 'e007' then
            loop
            exitwhen i > MAX_PLAYERS
                set tempPerson = Persons[i]
                if tempPerson != 0 and tempPerson != Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then   //Do not apply anything for training player until unti finishes training
                    call tempPerson.modObjectLimit(unitTypeId, UNLIMITED)
                endif
                set i = i + 1
            endloop
        endif
    endfunction 

    private function TrainFinish takes nothing returns nothing
        local integer unitTypeId = GetTrainedUnitType()
        local Person tempPerson = 0
        if unitTypeId == 'n08C' or unitTypeId == 'e009' or unitTypeId == 'n05F' or unitTypeId == 'e007' then
            set tempPerson = Persons[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))]
            if tempPerson != 0 then
                call tempPerson.modObjectLimit(unitTypeId, -UNLIMITED)
            endif
        endif
    endfunction        

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_TRAIN_START )
        call TriggerAddCondition(trig, Condition(function TrainStart))      

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_TRAIN_CANCEL )
        call TriggerAddCondition(trig, Condition(function TrainCancel))         

        set trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_TRAIN_FINISH )
        call TriggerAddCondition(trig, Condition(function TrainFinish))                 
    endfunction        

endlibrary