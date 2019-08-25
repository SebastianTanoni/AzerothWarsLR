library DemonPortalTypeConfig initializer OnInit requires DemonPortalType

    private function OnInit takes nothing returns nothing
        local DemonPortalType tempDemonPortalType = 0

        set tempDemonPortalType = DemonPortalType.create('hbar')
            call tempDemonPortalType.setManaMax(1000)
            call tempDemonPortalType.setManaRegen(5)
            call tempDemonPortalType.setManaStart(500)
    endfunction

endlibrary