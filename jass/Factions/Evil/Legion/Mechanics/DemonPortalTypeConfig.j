library DemonPortalTypeConfig initializer OnInit requires DemonPortalType
  private function OnInit takes nothing returns nothing
    local DemonPortalType tempDemonPortalType = 0

    set tempDemonPortalType = DemonPortalType.create('ndmg')
      call tempDemonPortalType.setManaMax(1000)
      call tempDemonPortalType.setManaRegen(1)
      call tempDemonPortalType.setManaStart(200)

    set tempDemonPortalType = DemonPortalType.create('u017')
    call tempDemonPortalType.setManaMax(100)
    call tempDemonPortalType.setManaRegen(0.5)
    call tempDemonPortalType.setManaStart(10)

    set tempDemonPortalType = DemonPortalType.create('h015')
      call tempDemonPortalType.setManaMax(10000)
      call tempDemonPortalType.setManaRegen(2)
      call tempDemonPortalType.setManaStart(8000)
    endfunction
endlibrary