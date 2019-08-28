library RiteofStrengthConfig initializer OnInit requires FactionMod

  private function OnInit takes nothing returns nothing  
    local FactionMod f
    
    set f = FactionMod.create(8)
      //Units
      call f.registerObjectLimit('n03F', 6)           //Ogre Lord     
  endfunction
    
endlibrary
