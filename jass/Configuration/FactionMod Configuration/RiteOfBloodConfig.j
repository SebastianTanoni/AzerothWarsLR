library RiteOfBloodConfig initializer OnInit requires FactionMod

  private function OnInit takes nothing returns nothing  
    local FactionMod f
    
    set f = FactionMod.create(9)
      //Units
      //Note that the parent factions have -UNLIMITED+x Blademasters, so combined with this you get +x Blademasters
      call f.registerObjectLimit('o01N', UNLIMITED)           //Blademaster (Bloodpact)
      call f.registerObjectLimit('o00G', UNLIMITED)           //Blademaster
  endfunction
    
endlibrary
