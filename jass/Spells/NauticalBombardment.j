

library NauticalBombardment initializer OnInit requires Projectile

    globals
        private constant integer    ABIL_ID             = 'A07K'
        private constant real       DURATION            = 14.

        private constant string     BOMBARD_EFFECT      = "war3mapImported\\Point Target.mdx"
        private constant real       BOMBARD_PERIOD      = 1.    //How often to launch a bombardment
        private constant real       BOMBARD_COUNT       = 20.   //How many cannonballs to launch in a bombardment
        private constant real       BOMBARD_RADIUS      = 400.
        private constant real       BOMBARD_FADE        = 1.    //How long it takes the bombard SFX to fade in
        private constant integer    BOMBARD_ALPHA       = 200   //How much alpha the fully faded in target reticule has
        
        private constant string     SHIP_EFFECT         = "units\\creeps\\HumanBattleship\\HumanBattleship.mdl"
        private constant real       SHIP_SCALE          = 1.
        private constant real       SHIP_CIRCLE_TIME    = 5.    //How long it takes for the ship to complete a full rotation
        private constant real       SHIP_Z_OFFSET       = 400.
        private constant string     SHIP_SPLASH         = "Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl"
        private constant real       SHIP_RADIUS_ADJUST  = 0.7   //The ship's radius is x% of the spell's actual radius. Just looks better
        private constant real       SHIP_FADE_OUT       = 0.4   //How long it takes the ship to fade out upon expiry of the spell
        private constant integer    SHIP_ALPHA          = 120   //How much alpha the ship has when fully faded in

        private constant string     PROJ_EFFECT         = "Abilities\\Weapons\\BoatMissile\\BoatMissile.mdl"
        private constant real       PROJ_DAMAGE_BASE    = 10.
        private constant real       PROJ_DAMAGE_LEVEL   = 10.
        private constant real       PROJ_SCALE          = .5
        private constant real       PROJ_SPEED          = 800.
        private constant real       PROJ_ARC            = 0.1
        private constant real       PROJ_RADIUS         = 100.
        private constant real       PROJ_Z_OFFSET       = 50.
        
        private group TempGroup = CreateGroup()
    endglobals

    private function OnExpire takes projectile p returns nothing
        local unit u
        local real x = p.posX
        local real y = p.posY
        local unit caster = p.sourceUnit
        local effect sfx
        
        set P = GetOwningPlayer(caster)  
        call GroupEnumUnitsInRange(TempGroup,x,y,PROJ_RADIUS,Condition(function EnemyAliveFilter))
        loop
            set u = FirstOfGroup(TempGroup)
            exitwhen u == null
            call UnitDamageTarget(caster, u, p.damageDealt, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(TempGroup,u)
        endloop
        call p.terminate()
    endfunction

    private struct NauticalBombardment
        unit       cas = null
        effect     sfx = null
        effect     shipSfx = null
        integer    alpha = 0
        integer    shipAlpha = 0
        real       tick = 0.
        real       duration = 0.
        
        real       x  = 0.
        real       y  = 0.
        real       z  = 0.
        real       ang = 0.     //Progress of the ship
        real       radius = 0.
        real       damage = 0.
        real       period = 0.
        
        real       shipX = 0.
        real       shipY = 0.
        real       shipZ = 0.
        real       shipFace = 0.
        
        method destroy takes nothing returns nothing
            call BlzSetSpecialEffectTimeScale(this.sfx,1)              
        
            call DestroyEffect(this.sfx)
            call DestroyEffect(this.shipSfx)
            
            set this.cas = null
            set this.sfx = null
            set this.shipSfx = null
            
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        private method createProjectile takes real targetX, real targetY, real damage returns nothing
            local real       targetZ = GetPositionZ(targetX,targetY)
            local real       ang  = Atan2((targetY - this.shipY),(targetX - this.shipX))
            local projectile proj = 0
            
            //---------------------------------------------------------
            set proj = projectile.create(this.shipX,this.shipY,PROJ_Z_OFFSET+SHIP_Z_OFFSET,ang)
            
            set proj.sourceUnit          = this.cas
            set proj.owningPlayer        = GetOwningPlayer(proj.sourceUnit)
            set proj.effectPath          = PROJ_EFFECT
            set proj.damageDealt         = damage
            set proj.scaleSize           = PROJ_SCALE

            set proj.allowExpiration     = true
            set proj.allowDeathSfx       = true
            set proj.allowArcAnimReset   = true
            
            set proj.onExpire            = OnExpire

            set proj.zOffset = PROJ_Z_OFFSET    //This is actually for the target
            
            call proj.projectArcing(targetX,targetY,GetPositionZ(targetX,targetY) + PROJ_Z_OFFSET,PROJ_SPEED,PROJ_ARC) 
        endmethod

        private method bombard takes nothing returns nothing
            local integer i = 0
            local real randomAngle = 0
            local real randomRadius = 0
            loop 
            exitwhen i > BOMBARD_COUNT
                set randomAngle = GetRandomReal(0, 2*bj_PI)
                set randomRadius = GetRandomReal(0, this.radius)
                call this.createProjectile(this.x + randomRadius * Cos(randomAngle), this.y + randomRadius * Sin(randomAngle), this.damage)
                set i = i + 1
            endloop
        endmethod

        private method updateShip takes nothing returns nothing
            set this.ang = this.ang + (2*bj_PI)/(SHIP_CIRCLE_TIME*T32_FPS)
            
            if this.ang > (2*bj_PI) then
                set this.ang = this.ang - (2*bj_PI)
            endif
            
            set this.shipX = this.x + this.radius*SHIP_RADIUS_ADJUST * Cos(this.ang) 
            set this.shipY = this.y + this.radius*SHIP_RADIUS_ADJUST * Sin(this.ang) 
            set this.shipZ = GetPositionZ(this.x, this.y) + SHIP_Z_OFFSET
            set this.shipFace = Atan2(this.shipY - this.y, this.shipX - this.x) + 90.
            
            call BlzSetSpecialEffectPosition(this.shipSfx, this.shipX, this.shipY, this.shipZ)
            call BlzSetSpecialEffectYaw(this.shipSfx, this.shipFace)
        endmethod

        private method periodic takes nothing returns nothing    
            if this.duration >= 0 then        
                if this.tick >= T32_FPS * this.period and this.duration > 0 then
                    set this.tick = 0     
                    call this.bombard()
                endif
                
                if this.alpha <= BOMBARD_ALPHA then
                    set this.alpha = this.alpha+R2I(BOMBARD_ALPHA/(BOMBARD_FADE*T32_FPS))
                    call BlzSetSpecialEffectAlpha(this.sfx, this.alpha)
                endif
                
                if this.shipAlpha <= SHIP_ALPHA then
                    set this.shipAlpha = this.shipAlpha+R2I(SHIP_ALPHA/(SHIP_FADE_OUT*T32_FPS))
                    call BlzSetSpecialEffectAlpha(this.shipSfx, this.shipAlpha)
                endif                
                
                call this.updateShip()  
            else
                if this.shipAlpha > 0 then      //Fade the ship out before destroying the whole struct
                    set this.shipAlpha = this.shipAlpha-R2I(SHIP_ALPHA/(SHIP_FADE_OUT*T32_FPS))
                    call BlzSetSpecialEffectAlpha(this.shipSfx, this.shipAlpha)
                else
                    call this.destroy()
                endif
            endif
            
            set this.tick = this.tick+1
            set this.duration = this.duration - 1./T32_FPS
        endmethod
        
        implement T32x
        
        static method create takes unit cast, real x, real y, real damage, real period, real radius, real duration returns thistype
            local thistype this = thistype.allocate()
            
            set this.cas = cast
            set this.tick = 0.
            
            set this.radius = radius
            set this.damage = damage
            set this.period = period
            set this.duration = duration

            set this.sfx = AddSpecialEffect(BOMBARD_EFFECT,x,y)
            call BlzSetSpecialEffectScale(this.sfx,BOMBARD_RADIUS/66.7)
            call BlzSetSpecialEffectColor(this.sfx, 128, 128, 128)
            call BlzSetSpecialEffectTimeScale(this.sfx,0)
            call BlzSetSpecialEffectAlpha(this.sfx, 0)
            set this.x  = x
            set this.y  = y
            set this.z  = 20.00 + GetPositionZ(x,y)            

            set this.shipSfx = AddSpecialEffect(SHIP_EFFECT,x,y)
            call BlzSetSpecialEffectScale(this.shipSfx,SHIP_SCALE)
            call BlzSetSpecialEffectColor(this.shipSfx, 128, 128, 128)
            call BlzSetSpecialEffectAlpha(this.shipSfx, 0)

            call this.startPeriodic()
            
            return this
        endmethod
    endstruct

    private function Cast takes nothing returns nothing
        local unit caster 
        local integer level   
        
        if GetSpellAbilityId() == ABIL_ID then
            set caster = GetTriggerUnit()
            set level = GetUnitAbilityLevel(caster, ABIL_ID) 
            call NauticalBombardment.create(caster, GetSpellTargetX(), GetSpellTargetY(), PROJ_DAMAGE_BASE + PROJ_DAMAGE_LEVEL*level, BOMBARD_PERIOD, BOMBARD_RADIUS, DURATION)
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trig, Condition(function Cast))
    endfunction
    
endlibrary