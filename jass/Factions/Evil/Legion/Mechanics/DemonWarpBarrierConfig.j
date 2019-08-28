library DemonWarpBarrierConfig initializer OnInit requires DemonWarpBarrier

  globals
    constant integer DEMON_WARP_BARRIER_DALARAN = 0
  endglobals

  private function OnInit takes nothing returns nothing
    local DemonWarpBarrier tempBarrier = 0
    
    set tempBarrier = DemonWarpBarrier.create(DEMON_WARP_BARRIER_DALARAN)
      call RegionAddRect(tempBarrier.area, gg_rct_Dalaran_Dungeon)
      call RegionAddRect(tempBarrier.area, gg_rct_Dalaran)
  endfunction

endlibrary