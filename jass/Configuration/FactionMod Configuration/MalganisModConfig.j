library MalganisModConfig initializer OnInit requires FactionMod

  globals
    constant integer FACTION_MOD_MALGANIS = 82
  endglobals

    private function OnInit takes nothing returns nothing  
        local FactionMod f
        
        set f = FactionMod.create(FACTION_MOD_MALGANIS)
            call f.registerObjectLimit('u01A', -UNLIMITED)      //Mal'ganis
    endfunction
    
endlibrary
