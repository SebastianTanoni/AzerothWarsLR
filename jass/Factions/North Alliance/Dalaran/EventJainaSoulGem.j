//Jaina goes to Scholomance while Scholomance building is destroyed and retrieves the Soul Gem

library EventJainaSoulGem initializer OnInit requires Artifact

    private function EntersRegion takes nothing returns nothing
        local Artifact tempArtifact = 0
        if GetUnitTypeId(GetTriggerUnit()) == 'Hjai' and not IsUnitAliveBJ(gg_unit_u012_1149) then
            set tempArtifact = Artifact.artifactsByType['gsou']
            call UnitAddItem(GetTriggerUnit(), tempArtifact.item)
            call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "Jaina has discovered a powerful artifact within the halls of Scholomance.")
            call DestroyTrigger(GetTriggeringTrigger())
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterEnterRectSimple( trig, gg_rct_Jaina_soul_gem )
        call TriggerAddCondition( trig, Condition( function EntersRegion ) )
    endfunction

endlibrary