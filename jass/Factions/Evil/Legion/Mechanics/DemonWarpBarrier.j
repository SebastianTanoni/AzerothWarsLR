//A DemonInstantiationBarrier is a region that cannot be Instantiated in.

library DemonWarpBarrier

  struct DemonWarpBarrier
    readonly static integer barrierCount = 0
    readonly static thistype array barriersByIndex
    readonly static thistype array barriersById
    readonly integer id
    region area = null
    boolean enabled = true

    static method create takes integer id returns thistype
      local thistype this = 0   
      if thistype.barriersByIndex[id] == 0 then
        set this = thistype.allocate()
        
        set this.area = CreateRegion()
        set this.id = id

        set thistype.barriersByIndex[thistype.barrierCount] = this
        set thistype.barriersById[id] = this
        set thistype.barrierCount = thistype.barrierCount + 1
        return this 
      else
        call BJDebugMsg("Attempted to create DemonWarpBarrier with already occupied ID " + I2S(id))      
      endif
      return 0               
    endmethod     
  
  endstruct

  function IsPointInDemonWarpBarrier takes real x, real y returns boolean
    local integer i = 0
    loop
    exitwhen i == DemonWarpBarrier.barrierCount
      if DemonWarpBarrier.barriersByIndex[i].enabled and IsPointInRegion(DemonWarpBarrier.barriersByIndex[i].area, x, y) then
        return true
      endif
      set i = i + 1
    endloop
    return false
  endfunction

endlibrary