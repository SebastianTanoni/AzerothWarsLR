library DemonInstantiation requires Table, Event, T32, Filters, Math, Instance

    globals
        constant integer INSTANTIATION_TYPE_NORMAL = 0
        constant integer INSTANTIATION_TYPE_WARP = 1
        constant integer INSTANTIATION_TYPE_METEOR = 2

        constant string INSTANTIATION_EFFECT_NORMAL = "Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl"
        constant string INSTANTIATION_EFFECT_WARP_AREA = "war3mapImported\\Void Teleport To.mdx"
        constant string INSTANTIATION_EFFECT_WARP_CASTER = "war3mapImported\\Void Teleport Caster.mdx"
        constant string INSTANTIATION_EFFECT_WARP_TARGET = "war3mapImported\\Void Teleport Target.mdx"        
        constant string INSTANTIATION_EFFECT_METEOR = "Units\\Demon\\Infernal\\InfernalBirth.mdl"

        constant real INSTANTIATION_RANGE_NORMAL = 200.
        constant real INSTANTIATION_RANGE_WARP = 3000.
        constant real INSTANTIATION_RANGE_METEOR = 3000.

        constant real INSTANTIATION_DAMAGE_METEOR = 50.

        constant real INSTANTIATION_RADIUS_METEOR = 200.

        constant real INSTANTIATION_DURATION_WARP = 2.

        constant real INSTANTIATION_FADE_WARP = 1.0 //How long the Warp animation spends fading after the unit is finished Warping

        constant real INSTANTIATION_DURATION_NORMAL = 0.5

        constant real INSTANTIATION_SCALE_WARP = 0.8    
    endglobals

    struct Normal //The animation that plays out to bring a normal Demon into the world
        private group grp = null      
        private real x = 0
        private real y = 0
        private real tick = 0
        private real dur = 0

        method destroy takes nothing returns nothing
          call DestroyGroup(this.grp)
          set this.grp = null
          call this.stopPeriodic()
          call this.deallocate()
        endmethod

        method periodic takes nothing returns nothing          
          local unit u = null
          local integer i = 0  
          set this.tick = this.tick+1   

          loop
          exitwhen i == BlzGroupGetSize(this.grp)
            set u = BlzGroupUnitAt(this.grp, i)
            call SetUnitVertexColor(u, 255, 255, 255, R2I( (this.tick / this.dur)*255))
            set i = i + 1
          endloop
          set u = null

          //The unit has finished warping
          if this.tick == this.dur then
              call this.destroy()
          endif     
        endmethod

        implement T32x

        static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, real dur, integer limit returns thistype
            local thistype this = thistype.allocate()
            local real ang = 0
            local real casterX = GetUnitX(caster)
            local real casterY = GetUnitY(caster)
            local unit u = null
            local integer i = 0

            if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > INSTANTIATION_RANGE_NORMAL then
                set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
                set this.x = GetPolarOffsetX(casterX, INSTANTIATION_RANGE_NORMAL, ang)
                set this.y = GetPolarOffsetY(casterY, INSTANTIATION_RANGE_NORMAL, ang)
            else
                set this.x = x
                set this.y = y
            endif

            //Import group
            set this.grp = CreateGroup()
            loop
            exitwhen i == limit
              call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
              set i = i + 1
            endloop
            set this.dur = dur*T32_FPS

            //Handle group
            set i = 0
            loop
            exitwhen i == BlzGroupGetSize(this.grp)
              set u = BlzGroupUnitAt(this.grp, i)
              call SetUnitPosition(u, this.x, this.y)
              call SetUnitVertexColor(u, 255, 255, 255, 0)
              call DemonType.startDuration(u)
              call IssuePointOrder(u, "attack", x, y)   
              call SetUnitFacing(u, ang)    
              set i = i + 1
            endloop
            set u = null
          
            call DestroyEffect(AddSpecialEffect(INSTANTIATION_EFFECT_NORMAL, GetUnitX(FirstOfGroup(this.grp)), GetUnitY(FirstOfGroup(this.grp))))   
            call this.startPeriodic()
            
            return this                
        endmethod             

    endstruct    

    //A unit disappears, then a nice animation appears somewhere, then the unit appears at that animation
    struct Warp
        private group grp = null   
        private real x = 0
        private real y = 0
        private real tarX = 0
        private real tarY = 0
        private real tick = 0
        private real dur = 0
        private effect sfxA = null

        method destroy takes nothing returns nothing
            call BlzSetSpecialEffectPosition(this.sfxA, 100000, 100000, 0)
            call DestroyGroup(this.grp)
            call DestroyEffect(this.sfxA)
            call this.stopPeriodic()

            set this.grp = null
            set this.sfxA = null

            call this.deallocate()
        endmethod

        method finish takes nothing returns nothing
            local effect tempSfx = AddSpecialEffect(INSTANTIATION_EFFECT_WARP_TARGET, this.x, this.y)
            local integer i = 0
            local unit u = null
            //Clean SFX
            call BlzSetSpecialEffectScale(tempSfx, INSTANTIATION_SCALE_WARP)
            call DestroyEffect(tempSfx)       

            //Let group go
            set i = 0
            loop
            exitwhen i == BlzGroupGetSize(this.grp)
              set u = BlzGroupUnitAt(this.grp, i)
              call PauseUnit(u, false)
              call DemonType.startDuration(u)
              if GetDistanceBetweenPointsEx(this.x, this.y, this.tarX, this.tarY) > 50 then
                call IssuePointOrder(u, "attack", this.tarX, this.tarY)
              endif
              set i = i + 1
            endloop
            set u = null

            set tempSfx = null
        endmethod

        method periodic takes nothing returns nothing     
          local integer i = 0       
          local unit u = null
          set this.tick = this.tick+1   

          //The group has finished warping (animation is not over)
          if this.tick == this.dur then
            call DestroyEffect(this.sfxA)
            call this.finish()
          else
            loop
            exitwhen i == BlzGroupGetSize(this.grp)
              set u = BlzGroupUnitAt(this.grp, i)
              call SetUnitVertexColor(u, 255, 255, 255, R2I( (this.tick / this.dur)*255))
              set i = i + 1
            endloop
            set u = null
          endif     

          //Begin fadeout
          if this.tick > this.dur then
              call BlzSetSpecialEffectAlpha( this.sfxA, R2I(255*( 1 - ( ( this.tick - this.dur ) / (INSTANTIATION_FADE_WARP*T32_FPS) ) ) ))
          endif    

          //Actual entire end of the warp
          if (this.tick - INSTANTIATION_FADE_WARP*T32_FPS) > this.dur then
              call this.destroy()
          endif
        endmethod

        implement T32x

        static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, real dur, integer limit returns thistype
            local thistype this = thistype.allocate()
            local real ang = 0
            local real casterX = GetUnitX(caster)
            local real casterY = GetUnitY(caster)     
            local effect tempSfx = null
            local integer i = 0
            local unit u = null

            if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > INSTANTIATION_RANGE_WARP then
                set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
                set this.x = GetPolarOffsetX(casterX, INSTANTIATION_RANGE_WARP, ang)
                set this.y = GetPolarOffsetY(casterY, INSTANTIATION_RANGE_WARP, ang)
            else
                set this.x = x
                set this.y = y
            endif

            set this.tarX = x
            set this.tarY = y    

            set this.grp = CreateGroup()
            loop
            exitwhen i == limit
              call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
              set i = i + 1
            endloop
            set this.dur = dur*T32_FPS

            //Unit setup
            set i = 0
            loop
            exitwhen i == BlzGroupGetSize(this.grp)
              set u = BlzGroupUnitAt(this.grp, i)
              call PauseUnit(u, true)
              call SetUnitPosition(u, this.x, this.y)
              call SetUnitVertexColor(u, 255, 255, 255, 0)
              set i = i + 1
            endloop
            set u = null

            //Persistent destination effect
            set this.sfxA = AddSpecialEffect(INSTANTIATION_EFFECT_WARP_AREA, this.tarX, this.tarY)
            call BlzSetSpecialEffectScale(this.sfxA, INSTANTIATION_SCALE_WARP)

            call this.startPeriodic()

            set tempSfx = null
            
            return this                
        endmethod             

    endstruct    

    struct Meteor //The animation that plays out to bring an Infernal or similar unit to the world
        private group grp = null
        private DemonType whichDemonType = 0
        private real x = 0
        private real y = 0
        private real tarX = 0
        private real tarY = 0
        private real tick = 0
        private real dur = 0

        method destroy takes nothing returns nothing
          call DestroyGroup(this.grp)
          set this.grp = null
          call this.stopPeriodic()
          call this.deallocate()
        endmethod

        method finish takes nothing returns nothing
          local integer i = 0
          local unit u = null

          loop
          exitwhen i == BlzGroupGetSize(this.grp)
            set u = BlzGroupUnitAt(this.grp, i)
            call PauseUnit(u, false)
            call DemonType.startDuration(u)
            if GetDistanceBetweenPointsEx(this.x, this.y, this.tarX, this.tarY) > 50 then
                call IssuePointOrder(u, "attack", this.tarX, this.tarY)
            endif
            set i = i + 1
          endloop
          set u = null

          call this.destroy()
        endmethod

        method impact takes nothing returns nothing
          local unit target = null
          local unit u = null
          local integer i = 0
          
          set i = 0
          loop
          exitwhen i == BlzGroupGetSize(this.grp)
            set u = BlzGroupUnitAt(this.grp, i)
            call ShowUnit(u, true)
            call QueueUnitAnimation(u, "stand")
            set i = i + 1
          endloop

          set u = FirstOfGroup(this.grp)
          set P = GetOwningPlayer(u)  
          call GroupEnumUnitsInRange(TempGroup,this.x,this.y,INSTANTIATION_RADIUS_METEOR,Condition(function EnemyAliveFilter))
          loop
              set target = FirstOfGroup(TempGroup)
              exitwhen target == null
              call UnitDamageTarget(u, target, this.whichDemonType.instantiationDamage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
              call GroupRemoveUnit(TempGroup,target)
          endloop  
          set u = null
        endmethod

        method periodic takes nothing returns nothing            
            set this.dur = this.dur+1
            set this.tick = this.tick+1  

            if this.dur == 1*T32_FPS then
                call this.impact()
            endif     

            if this.dur >= 3.*T32_FPS then
                call this.finish()
            endif    
        endmethod

        implement T32x

        static method create takes unit caster, DemonGroup whichDemonGroup, real x, real y, integer limit returns thistype
            local thistype this = thistype.allocate()
            local real ang = 0
            local real casterX = GetUnitX(caster)
            local real casterY = GetUnitY(caster)     
            local unit u = null
            local integer i = 0       

            //Import group
            set this.grp = CreateGroup()
            loop
            exitwhen i == limit
              call GroupAddUnit(this.grp, BlzGroupUnitAt(whichDemonGroup.demons, i))
              set i = i + 1
            endloop
            set this.whichDemonType = DemonType.demonsByUnitId[GetUnitTypeId(FirstOfGroup(this.grp))]

            if GetDistanceBetweenPointsEx(GetUnitX(caster), GetUnitY(caster), x, y) > this.whichDemonType.instantiationRange then
              set ang = GetAngleBetweenPoints(casterX, casterY, x, y)
              set this.x = GetPolarOffsetX(casterX, this.whichDemonType.instantiationRange, ang)
              set this.y = GetPolarOffsetY(casterY, this.whichDemonType.instantiationRange, ang)
            else
              set this.x = x
              set this.y = y
            endif

            set this.tarX = x
            set this.tarY = y

            //Handle group
            set i = 0
            loop
            exitwhen i == BlzGroupGetSize(this.grp)
              set u = BlzGroupUnitAt(this.grp, i)
              call SetUnitPosition(u, this.x, this.y)
              call DestroyEffect(AddSpecialEffect(INSTANTIATION_EFFECT_METEOR, GetUnitX(u), GetUnitY(u)))    
              call ShowUnit(u, false)
              call PauseUnit(u, true)  
              call SetUnitAnimation(u, "birth")
              set i = i + 1
            endloop
            set u = null

            call this.startPeriodic()
            
            return this                
        endmethod             

    endstruct

    struct Rematerialize
        private unit u = null
        private real dur = 0
        private real maxDuration = 0
        private real x = 0
        private real y = 0

        method destroy takes nothing returns nothing
            local unit tempUnit = CreateUnit(GetOwningPlayer(this.u), GetUnitTypeId(this.u), x, y, 0)
            call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl", GetUnitX(tempUnit), GetUnitY(tempUnit)) )

            call RemoveUnit(this.u)
            set this.u = null
            set tempUnit = null
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        method periodic takes nothing returns nothing            
            set this.dur = this.dur+1

            call SetUnitVertexColor(this.u, 255, 255, 255, R2I((1 - (this.dur / this.maxDuration))*255))

            if this.dur == this.maxDuration then
                call this.destroy()
            endif    
        endmethod

        implement T32x

        static method create takes unit whichUnit, real x, real y, real duration returns thistype
            local thistype this = thistype.allocate()
            
            set this.u = whichUnit
            set this.maxDuration = duration*T32_FPS
            set this.x = x
            set this.y = y

            call DestroyEffect( AddSpecialEffect("Abilities\\Spells\\Items\\AIso\\AIsoTarget.mdl", GetUnitX(this.u), GetUnitY(this.u)) )

            call this.startPeriodic()
            
            return this                
        endmethod 
    endstruct

endlibrary