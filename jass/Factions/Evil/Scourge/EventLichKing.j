library EventLichKing initializer OnInit requires Artifact

    private function CreateLichKing takes nothing returns nothing
        local unit DeathKnight = GetTriggerUnit()
        local unit LichKing = null
        local item tempItem = null
        local integer i = 0
        local Artifact tempArtifact = Artifact.artifactsByType['I01Y']

        call PlayThematicMusicBJ( "Sound\\Music\\mp3Music\\LichKingTheme.mp3" )
        set LichKing = CreateUnit(GetOwningPlayer(DeathKnight), 'N023', -2802, 22035, 270) 
        call SetHeroLevel(LichKing, 12, false)
        loop
        exitwhen i > 6
            call UnitAddItem(LichKing, UnitItemInSlot(DeathKnight, i))
            set i = i + 1
        endloop
        if tempArtifact != 0 then
            call UnitAddItem(LichKing, tempArtifact.item)
        endif
        call RemoveUnit(gg_unit_u000_0649)      //The Frozen Throne
        call RemoveUnit(GetTriggerUnit())
        //call DisableTrigger( gg_trg_ThrallnNZ )
        //call DisableTrigger( gg_trg_Throne_Protection_2 )
        call DisplayTextToForce( GetPlayersAll(), "Arthas has ascended to the Frozen Throne itself, and freed the Lich King from his imprisonment. Ner'zhul now has the host body he so desired, and it seems that stopping the Lich King will be harder than ever." )
        //Cleanup
        set DeathKnight = null
        set LichKing = null     
        set tempItem = null 
        call DestroyTrigger(GetTriggeringTrigger())
    endfunction

    private function EntersRegion takes nothing returns nothing
        if GetUnitTypeId(GetTriggerUnit()) == 'Uear' and GetHeroLevel(GetTriggerUnit()) >= 12 then
            call CreateLichKing()
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterEnterRectSimple(trig, gg_rct_LichKing)
        call TriggerAddCondition(trig, Condition(function EntersRegion))                
    endfunction

endlibrary