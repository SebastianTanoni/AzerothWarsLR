
library ObserverCam initializer OnInit requires Persons

    globals
        private constant real PERIOD = 60.
        private constant real CAMERA_DISTANCE = 2600.
        private constant real CAMERA_TIME = 3.  
    endglobals

    private function ResetCam takes nothing returns nothing
        call SetCameraFieldForPlayer( GetEnumPlayer(), CAMERA_FIELD_TARGET_DISTANCE, CAMERA_DISTANCE, CAMERA_TIME)
    endfunction

    private function Actions takes nothing returns nothing
        call ForForce(Observers, function ResetCam)
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterTimerEvent(trig, PERIOD, true)
        call TriggerAddCondition(trig, Condition(function Actions))
    endfunction    

endlibrary