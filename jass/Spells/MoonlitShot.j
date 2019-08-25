library MoonlitShot initializer OnInit requires Projectile

    globals
        private constant integer    ABIL_ID             = 'A06H'
        private constant real       DAMAGE_BASE         = 0.       //Damage dealt by arrow at level 0 
        private constant real       DAMAGE_LEVEL        = 50.      //Additional damage dealt by arrow per level
        private constant real       MAXDIST             = 1000.00  //Actual distance arrow travels
        
        private constant string     PROJ_EFFECT         = "Abilities\\Weapons\\ColdArrow\\ColdArrowMissile.mdl"
        private constant real       PROJ_SCALE          = 2.
        private constant real       PROJ_SPEED          = 800.
        private constant real       PROJ_RADIUS         = 100.
        private constant real       PROJ_Z_OFFSET       = 50.

        private constant string     PATH_EFFECT         = "war3mapImported\\Point Target.mdx"
        private constant real       PATH_SCALE          = 0.8
        private constant real       PATH_RADIUS         = 50.       //How far to space out each star along the path, AND the radius of star damage
        private constant real       PATH_DURATION       = 6.
        private constant real       PATH_FADE           = .5        //The amount of time it takes a path circle to fade in (visual only)

        private constant real       STAR_DAMAGE_BASE    = 0.        //How much damage a star does at level 0
        private constant real       STAR_DAMAGE_LEVEL   = 12.5
        private constant real       STAR_PERIOD         = .5        //How often each star is created along the path
        private constant string     STAR_EFFECT         = "Abilities\\Spells\\Undead\\AbsorbMana\\AbsorbManaBirthMissile.mdl"
        private constant real       STAR_SPEED          = 800.
        private constant real       STAR_Z_OFFSET       = 50.
        private constant real       STAR_Z_OFFSET_START = 400.
        
        private group TempGroup = CreateGroup()
    endglobals

    private function OnStarImpact takes projectile p returns nothing
        local real x = p.posX
        local real y = p.posY
        local unit caster = p.sourceUnit
        local unit u

        set P = GetOwningPlayer(caster)  
        call GroupEnumUnitsInRange(TempGroup,x,y,PATH_RADIUS,Condition(function EnemyAliveFilter))
        loop
            set u = FirstOfGroup(TempGroup)
            exitwhen u == null
            call UnitDamageTarget(caster, u, p.damageDealt, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            call GroupRemoveUnit(TempGroup,u)
        endloop
        call p.terminate()
    endfunction
        
    private struct Moonlight
        unit       cas = null
        real       tick = 0.00
        effect     sfx = null
        
        real       x  = 0.00
        real       y  = 0.00
        real       z  = 0.00
        real       damage = 0.
        real       duration = 0.
        integer    alpha = 0
        
        method destroy takes nothing returns nothing            
            set this.cas = null
            
            call BlzSetSpecialEffectTimeScale(this.sfx,1)
            call this.stopPeriodic()
            call DestroyEffect(this.sfx)
            call this.deallocate()
        endmethod

        private method createProjectile takes nothing returns nothing
            local projectile proj = 0
            
            //---------------------------------------------------------
            set proj = projectile.create(this.x,this.y,STAR_Z_OFFSET+STAR_Z_OFFSET_START,0)
            
            set proj.sourceUnit          = this.cas
            set proj.owningPlayer        = GetOwningPlayer(this.cas)
            set proj.effectPath          = STAR_EFFECT
            set proj.damageDealt         = this.damage
            set proj.scaleSize           = 1

            set proj.allowExpiration     = true
            set proj.allowDeathSfx       = true
            set proj.allowArcAnimReset   = true
            set proj.allowUnitCollisions = true
            
            set proj.unitHitRadius       = PATH_RADIUS
            
            set proj.onLand              = OnStarImpact

            set proj.zOffset = STAR_Z_OFFSET    //This is actually for the target
            
            call proj.projectNormal(this.x,this.y,GetPositionZ(this.x,this.y),STAR_SPEED)
        endmethod

        private method periodic takes nothing returns nothing 
            if this.tick > T32_FPS * STAR_PERIOD then                   //Means STAR_PERIOD has elapsed
                call this.createProjectile()
                set this.tick = 0  
                set this.duration = this.duration - STAR_PERIOD
            endif
            
            set this.tick = this.tick+1
            set this.alpha = this.alpha+R2I(255/(PATH_FADE*32))
            
            if this.alpha <= 255 then
                call BlzSetSpecialEffectAlpha(sfx, this.alpha)
            endif
            
            if this.duration <= 0 then
                call this.destroy()
            endif            
            
        endmethod
        
        implement T32x
        
        static method create takes unit cast, real x, real y, real damage, real duration returns thistype
            local thistype this = thistype.allocate()
            
            set this.cas = cast
            set this.tick = T32_FPS * STAR_PERIOD
            set this.sfx = AddSpecialEffect(PATH_EFFECT,x,y)
            call BlzSetSpecialEffectScale(this.sfx, PATH_SCALE)
            call BlzSetSpecialEffectColor(this.sfx, 50, 50, 255)
            call BlzSetSpecialEffectAlpha(this.sfx, 0)
            call BlzSetSpecialEffectTimeScale(this.sfx, 0)
            
            set this.x  = x
            set this.y  = y
            set this.z  = 20.00 + GetPositionZ(x,y)
            set this.damage = damage
            set this.duration = duration
            
            call this.startPeriodic()
            
            return this
        endmethod
    endstruct

    private struct ArrowTimer
        projectile p = 0
        
        real       tick = 0.
        
        method destroy takes nothing returns nothing 
            call this.stopPeriodic()
            call this.deallocate()
        endmethod

        private method periodic takes nothing returns nothing 
            if p == 0 or p.isTerminated then
                call this.destroy()
            else
            endif
        
            if this.tick > T32_FPS * (PATH_RADIUS*2)/PROJ_SPEED then        //Should ensure the entire path takes damage
                call Moonlight.create(p.sourceUnit, p.posX, p.posY, STAR_DAMAGE_BASE + STAR_DAMAGE_LEVEL * GetUnitAbilityLevel(p.sourceUnit, ABIL_ID), PATH_DURATION)
                set this.tick = 0  
            endif
            
            set this.tick = this.tick+1   
        endmethod
        
        implement T32x
        
        static method create takes projectile p returns thistype
            local thistype this = thistype.allocate()
            
            set this.p = p
            
            call this.startPeriodic()
            
            return this
        endmethod        
    endstruct

    private function OnUnitImpact takes projectile p, unit u returns nothing
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)

        if UnitAlive(u) and u != p.sourceUnit and IsUnitEnemy(u,GetOwningPlayer(p.sourceUnit)) == true then
            call UnitDamageTarget(p.sourceUnit, u, p.damageDealt, false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif
    endfunction

    private function Cast takes nothing returns nothing
        local unit caster 
        local integer level   
        local real targetX
        local real targetY
        local real casterX
        local real casterY
        local real targetXMax   //To ensure that the projectile target is as far away as possible
        local real targetYMax
        local real ang
        local real dist
        local projectile proj = 0

        if GetSpellAbilityId() == ABIL_ID then
            set caster = GetTriggerUnit()
            set level = GetUnitAbilityLevel(caster, ABIL_ID)  
            set targetX = GetSpellTargetX()
            set targetY = GetSpellTargetY()
            set casterX = GetUnitX(caster)
            set casterY = GetUnitY(caster)
            set ang = Atan2((targetY - casterY),(targetX - casterX))
            set dist = GetDistanceBetweenPoints(casterX, casterY, targetX, targetY)
            
            //---------------------------------------------------------
            set proj = projectile.create(casterX,casterY,GetUnitFlyHeight(caster) + PROJ_Z_OFFSET,ang)
            
            set proj.sourceUnit          = caster
            set proj.owningPlayer        = GetOwningPlayer(caster)
            set proj.effectPath          = PROJ_EFFECT
            set proj.damageDealt         = DAMAGE_BASE+DAMAGE_LEVEL*level
            set proj.scaleSize           = PROJ_SCALE
            set proj.timedLife           = MAXDIST / PROJ_SPEED

            set proj.allowExpiration     = true
            set proj.allowDeathSfx       = true
            set proj.allowArcAnimReset   = true
            set proj.allowUnitCollisions = true
            set proj.allowDestCollisions = true
            
            set proj.unitHitRadius       = PROJ_RADIUS
            
            set proj.onUnit              = OnUnitImpact
            
            set targetXMax = targetX + MAXDIST*Cos(ang)
            set targetYMax = targetY + MAXDIST*Sin(ang)
            
            call proj.attachData(ArrowTimer.create(proj))
            call proj.projectNormal(targetXMax,targetYMax,GetPositionZ(targetXMax,targetYMax),PROJ_SPEED)    
        endif
    endfunction

    private function OnInit takes nothing returns nothing
        local trigger trig = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trig, EVENT_PLAYER_UNIT_SPELL_EFFECT )
        call TriggerAddCondition( trig, Condition(function Cast))
    endfunction
    
endlibrary
