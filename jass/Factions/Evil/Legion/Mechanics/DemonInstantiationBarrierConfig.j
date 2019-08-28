library DemonInstantiationBarrierConfig initializer OnInit requires DemonInstantiationBarrier

  globals
    constant integer DEMON_INSTANTIATION_BARRIER_DALARAN = 0
  endglobals

  private function OnInit takes nothing returns nothing
    local DemonInstantiationBarrier tempBarrier = 0
    
    set tempBarrier = DemonInstantiationBarrier.create(DEMON_INSTANTIATION_BARRIER_DALARAN)
      call RegionAddRect(tempBarrier.area, gg_rct_Dalaran_Dungeon)
      call RegionAddRect(tempBarrier.area, gg_rct_Dalaran)
  endfunction

endlibrary