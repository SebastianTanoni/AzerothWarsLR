library Projectile initializer OnInit requires AIDS, T32, ListModule, optional Recycle, optional GroupUtils
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //           _____           _           _   _ _      
    //          |  __ \         (_)         | | (_) |     
    //          | |__) | __ ___  _  ___  ___| |_ _| | ___ 
    //          |  ___/ '__/ _ \| |/ _ \/ __| __| | |/ _ \
    //          | |   | | | (_) | |  __/ (__| |_| | |  __/
    //          |_|   |_|  \___/| |\___|\___|\__|_|_|\___|
    //                         _/ |                       
    //                        |__/
    //                             By Kenny v0.2.6 (Beta)
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  What is Projectile?
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • Projectile is an advanced projectile system that enables users to create and manipulate projectiles in game for
    //      use in spells and various map-wide systems.
    //    • Projectile as a system provides users with numerous basic and advanced methods in which they are able to completely
    //      change almost any aspect of a projectile.
    //    • Projectile is a tool that enables even those with little knowledge of vJass to create and develop extremely
    //      powerful gameplay mechanics that are usually unseen in the WC3 modding community.
    //    • The system itself has an easy and intuitive interface that is quick to learn and very flexible to a users needs, as
    //      many aspects of the projectile can be left alone or manipulated without consequences. Amongst many other things,
    //      this system provides:
    //        - Methods for creating, manipulating and destroying projectiles.
    //        - An extensive API that encompasses almost all aspects one would want for projectiles.
    //        - Projectile recycling and preloading.
    //        - Interface events for unit, destructable and ground collision events.
    //        - Interface events for projectile launching, destruction, iteration and life expiration.
    //        - Projectile grouping functions which closely follow the native WC3 group API.
    //        - Optional modules that allow for additional functionality, such as terrain bouncing and projectile shadows.
    //        - Built in BoundSentinel that destroys projectiles made by this system when they reach the boundaries.
    //    • As stated above, Projectile also has an internal boundary detection system, therefore users can delete
    //      BoundSentinel or any other similar systems if they use this.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Thanks and credits:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • To Jesus4Lyf for AIDS and T32.
    //    • To Anitarf for Vector and xemissile.
    //    • To Vexorian for BoundSentinel and JassHelper.
    //    • To Weep for discussing collision detection.
    //    • To BlackRose for ideas, testing and dicussions.
    //    • To Quraji for HandleGroups which gave me the idea for projgroups.
    //    • To Nestharus for Recycle and Rising_Dusk for GroupUtils.
    //    • To Berb (TheKid) for his help with projectile groups and the time scale idea.
    //    • To anyone else who may have helped me with this system (sorry if I forgot you).
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  How to implement:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • Simply create a new trigger object called Projectile, go to: 'Edit -> Convert to Custom Text', and replace 
    //      everything that is there with this script. Or just copy this trigger object over.
    //    • Make sure you implement all the required systems for this system. That includes: AIDS, T32 and Linked List 
    //      Module.
    //    • This system also optionally uses Recycle or GroupUtils, so if you want to implement one of them, you can. They just
    //      help recycle groups in the system.
    //    • There are two optional modules available to users if they wish for extra functionality. These modules are
    //      the ProjShadows and ProjBounces modules.
    //    • Next you have to make sure that you have the dummy.mdx model in your map before you continue importing this 
    //      system. The dummy model can be found in the import section of this test map.
    //    • Now you must copy the dummy unit that is needed for the projectiles from the Object Editor. The dummy can be
    //      found in the units tab of the Object Editor, under 'Custom Units -> Neutral Passive'. It is labelled 'Proj Dummy'.
    //    • After you have done all that, make sure the raw code for the dummy unit in your map is the same as the raw code
    //      in the configurables section of this system. Once that is done, save the map and you are ready to go.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Projectile API:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • This is a quick over-view of all the methods, functions and members available to use with this system.
    //
    //    Projectile methods:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These methods are the main methods used by the system to create, manipulate and destroy projectiles. They
    //        include:
    //
    //        - projectile.create()    - this.addUnit()
    //
    //        - this.projectNormal()   - this.isUnitAdded()
    //
    //        - this.projectArcing()   - this.removeUnit()
    //
    //        - this.setTargPoint()    - this.removeAll()
    //
    //        - this.setProjPoint()    - this.attachData()
    //
    //        - this.disjoint()        - this.getData()
    //
    //        - this.refresh()         - this.hasData()
    //
    //        - this.terminate()       - this.detachData()
    //
    //    Public Projectile members:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These members are publically available to users at any time throughout the lifetime of a projectile. They can be
    //        changed and manipulated at any point. They include:
    //
    //        - this.sourceUnit        - this.currentSpeed      - this.onExpire          - this.allowDestCollisions
    //
    //        - this.targetUnit        - this.timedLife         - this.onLand            - this.allowTargetHoming
    //
    //        - this.owningPlayer      - this.damageDealt       - this.onUnit            - this.removalDelay
    //
    //        - this.unitHitRadius     - this.pauseProj         - this.onDest
    //
    //        - this.destHitRadius     - this.effectPath        - this.allowDeathSfx 
    //
    //        - this.scaleSize         - this.onStart           - this.allowExpiration
    //
    //        - this.timeScale         - this.onLoop            - this.allowArcAnimReset
    //
    //        - this.zOffset           - this.onFinish          - this.allowUnitCollisions
    //
    //    Readonly Projectile members:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These members are only available for users to read. They cannot be changed or manipulated (unless through the 
    //        above methods, i.e. .setTargPoint), they are there for reference only. They include:
    //
    //        - projetile[unit]        - this.velX              - this.strZ
    //
    //        - this.dummy             - this.velY              - this.distanceMax
    //
    //        - this.arcSize           - this.velZ              - this.distanceLeft
    //
    //        - this.angle             - this.tarX              - this.distanceDone
    //
    //        - this.isTerminated      - this.tarY              - this.previousSpeed
    //
    //        - this.posX              - this.tarZ              - this.originalSpeed
    //
    //        - this.posY              - this.strX
    //
    //        - this.posZ              - this.strY
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Detailed Projectile API descriptions:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    Methods:
    //   ¯¯¯¯¯¯¯¯¯
    //      • projectile.create(real x, real y, real z, real angle) -> returns projectile
    //
    //        - Above is the only method for creating projectiles. It takes four simple parameters: The starting x, y and z
    //          coordinates of the projectile you want to create, and the angle you want it to face. The angle for the
    //          facing direction of the projectile is taken in RADIANS. This method will return the created projectile for you
    //          to save into a variable.
    //
    //      • this.projectNormal(real x, real y, real z, real speed) -> returns boolean   
    //
    //        - Above is one of the two different methods that can be chosen for launching a projectile. This method is the
    //          simpler of the two, which doesn't allow for an arcing movement. It takes the target x, y and z coordinates
    //          of the projectile and the speed at which you want the projectile to move. This method will return true if the
    //          projectile successfully launched and false if it didn't (possibly because it had already been launched).
    //
    //      • this.projectArcing(real x, real y, real z, real speed, real arcSize) -> returns boolean
    //
    //        - Similar to the above method, this method is also used for launching a projectile, however this method allows
    //          for the projectile to arc along the z axis. It takes the target x, y and z coordinates of the projectile, the
    //          speed at which the projectile will move and the size of the arc you want. Values for the arcSize should range
    //          from 0.00 to 1.00 (0.10-0.40 recommended). This method returns the same boolean as this.projectNormal().
    //
    //      • this.setTargPoint(real x, real y, real z, boolean wantUpdate) -> returns nothing
    // 
    //        - The above method can be used to change the target coordinates of a projectile, effectively changing where the
    //          projectile will move to. The method takes the x, y and z coordinates of the new target destination, which will
    //          update the direction of the projectile in the next iteration of the timer. The boolean parameter at the end
    //          determines whether or not the system will update the projectile's new velocities according to the new target
    //          coordinates (there are some situations in which update and not updating are applicable).
    //
    //      • this.setProjPoint(real x, real y, real z, boolean wantUpdate) -> returns nothing
    //
    //        - The above method can be used to change the current position of a projectile, without changing its target
    //          coordinates or any other aspect of the projectile. The method takes the x, y and z coordinates of the new
    //          position of the projectile. This method does not return anthing (same with the above method). The boolean
    //          parameter at the end determines whether or not the system will update the projectile's new velocities 
    //          according to the new position coordinates (there are some situations in which update and not updating are
    //          applicable).
    //
    //      • this.disjoint() -> returns nothing
    //
    //        - This method is basically an easy way for the user to remove the target unit of a projectile and effectively
    //          make it target the ground and discontinue its homing capabilities. The method has no parameters and can simply
    //          be used whenever the user wants. This works excellently if you want a projectile to disjoint when a unit blinks.
    //
    //      • this.refresh(boolean fireOnStart) -> returns nothing
    //
    //        - This method will stop a projectile from moving and enable it to be launched again via the .projectNormal and
    //          .projectArcing methods. It allows users to quickly stop and start a projectile with a different arc height as
    //          as well as target coordinates and speed. The boolean parameter is used to determine whether or not the 
    //          .onStart function interface member should be executed again, or removed from the projectile. Using true as the
    //          parameter will allow the .onStart function to be executed again, while false will remove it completely.
    //
    //      • this.terminate() -> returns nothing
    //
    //        - The above method is used to terminate (AKA destroy) a projectile. This will in turn remove the projectile from
    //          the game as well as any data associated with it. Projectiles will be removed from any projgoups they are in.
    //          This method takes no parameters and can be used whenever the user wants.
    //
    //      • this.addUnit(unit u) -> returns nothing
    //
    //        - The above method was added for completeness. It will add a unit to the 'already passed through' group of a 
    //          projectile without firing the unit impact event. This can be used to quickly add units to the group that you
    //          know won't be a target of a projectile. It takes a unit parameter, which is the unit that will be added.
    //
    //      • this.isUnitAdded(unit u) -> returns boolean
    //
    //        - The above method was also added for completeness. It will check to see if a given unit is already in the
    //          'already passed through' group of a projectile. This can be used in conjunction with this.addUnit() and
    //          this.removeUnit() to do some interesting things. It takes a unit parameter.
    //
    //      • this.removeUnit(unit u) -> returns nothing
    //
    //        - The above method is the last of the functions added for completeness. This method will remove a given unit
    //          from a projectile's 'already passed through' group so that it may fire the unit impact event again (or maybe
    //          for the first time if this.addUnit() was used on it). It takes a unit parameter.
    //
    //      • this.removeAll() -> returns nothing
    //
    //        - This method can be used to completely clear all units that have been hit by a projectile. Doing so will make
    //          all previously hit units available to be hit once more. Can be used with projectiles that travel to a target
    //          point and return, so that damage can be dealt twice.
    //
    //      • this.attachData(integer whichData) -> returns nothing
    //
    //        - Users can attach extra data to a projectile via the above method. This enables extra data to be transfered via
    //          structs so that projectiles can be more inclusive in regards to user needs. The method takes one parameter,
    //          which can be any struct that the user wants to attach the the projectile.
    //
    //      • this.getData() -> returns integer
    //
    //        - The above method is used to retrieve data attached to a projectile. It has no parameters and can be used in a
    //          similar fashion to how TimerUtils and KeyTimers 2 works. The data can then be manipulated in the function
    //          interface members of a projectile.
    //
    //      • this.hasData() -> returns boolean
    //
    //        - This method will return true if a given projectile currently has some form of data attached to it and false
    //          if there is no data attached.
    //
    //      • this.detachData() -> returns nothing
    //
    //        - The above method will remove any currently attached data from a projectile. Users do not have to manually
    //          remove data as it will be automatically removed upon projectile destruction. Users can also just override the
    //          currently attached data by using this.attachData() again. This is just here for API completion.
    //
    //    Public members:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • this.sourceUnit          -> The unit that can be saved as the source of the projectile (for damage events).
    //      • this.targetUnit          -> A unit can be saved as the target unit to enable homing capabilities.
    //      • this.owningPlayer        -> Can be set to the owning player of the source unit.
    //      • this.damageDealt         -> Damage amounts can be saved directly to a projectile for when it hits a unit.
    //      • this.unitHitRadius       -> The radius in which a unit must be for it to be hit by a projectile.
    //      • this.destHitRadius       -> The radius in which a destructable must be for it to be hit by a projectile.
    //      • this.zOffset             -> Can save an approximate height for projectile impacts on a target unit.
    //      • this.timeScale           -> Time scale of a projectile. Can be used to slow down or speed up a projectile.
    //      • this.timedLife           -> The life span of a projectile. Can be changed to anything. Defaults to dist / speed.
    //      • this.scaleSize           -> Determines the size of the projectile (similar to scale size for units).
    //      • this.effectPath          -> The model that will be attached to the dummy unit to create the projectile effect.
    //      • this.currentSpeed        -> Determines the movement speed of a projectile.
    //      • this.removalDelay        -> Determines how long until the projectile will be removed if .allowDeathSfx is true.
    //      • this.pauseProj           -> Whether or not a projectile should be paused or not (collision works while paused).
    //      • this.allowDeathSfx       -> Whether or not to show the death effect of a projectile. Defaults to false.
    //      • this.allowExpiration     -> If a projectile will terminate once its timed life is up. Defaults to false.
    //      • this.allowArcAnimReset   -> Whether or not to reset a projectile's arc animation on death. Helps display effects.
    //      • this.allowTargetHoming   -> Whether or not to allow homing on a target unit for a projectile. Defaults to false.
    //      • this.allowUnitCollisions -> Whether or not to allow projectile and unit collision. Defaults to false.
    //      • this.allowDestCollisions -> Whether or not to allow projectile and destructable collisions. Defaults to false.
    //
    //      Function interfaces as members:
    //     ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //        - this.onStart           -> Can be set to a function that will be executed when a projectile is launched.
    //        - this.onLoop            -> Can be set to a function that will be executed periodically for a projectile.
    //        - this.onFinish          -> Can be set to a function that will be executed when a projectile is terminated.
    //        - this.onExpire          -> Can be set to a function that will be executed when a projectile's timed life expires.
    //        - this.onLand            -> Can be set to a function that will be executed whenever a projectile hits terrain.
    //
    //          • All of the above will execute a function that a user can specify to create specific event responses for
    //            different projectiles. These are higher end members that take a little more knowledge to master. For 
    //            example:
    //
    //              private function OnLandImpact takes projectile whichProj returns nothing
    //                  call whichProj.terminate() <--- The function OnLandImpact must take a projectile parameter.
    //              endfunction
    //            
    //              private function Actions takes nothing returns nothing
    //                  local projectile p  = 0
    //                  local unit       u  = GetTriggerUnit()
    //                  local real       ux = GetUnitX(u)
    //                  local real       uy = GetUnitY(u)
    //                  local real       tx = GetSpellTargetX()
    //                  local real       ty = GetSpellTargetY()
    //         
    //                  set p = projectile.create(ux,uy,50.00,Atan2((ty - uy),(tx - ux)))
    //
    //                  set p.sourceUnit          = u
    //                  set p.owningPlayer        = GetOwningPlayer(u)
    //                  set p.effectPath          = "Abilities\\Weapons\\AncientProtectorMissile\\AncientProtectorMissile.mdl"
    //                  set p.scaleSize           = 0.75
    //                  set p.zOffset             = 0.00
    //    
    //                  set p.allowUnitCollisions = false
    //                  set p.allowProjCollisions = false
    //                  set p.allowDestCollisions = false
    //    
    //                  set p.onLand              = OnLandImpact <--- Notice how p.onLand is set to the function OnLandImpact.
    //    
    //                  call p.projectNormal(tx,ty,0.00,1024.00)
    //
    //                  set u = null
    //              endfunction
    //
    //          • These five function interface members can be set to a function that takes a single projectile parameter and
    //            returns nothing. This is very important! The functions can be named whatever a user likes, but they must
    //            follow this rule. The single projectile parameter for the function refers to a projectile that has just 
    //            completed an event (be it .onLand or .onStart), and can therefore be manipulated by the user to do something
    //            unique for that event.
    //
    //        - this.onUnit            -> Can be set to a function that will be executed when a projectile hits a unit.
    //        - this.onDest            -> Can be set to a function that will be executed when a projectile hits a destructable.
    //
    //          • The above are function interfaces that are executed when a projectile hits another object, such as a unit,
    //            projectile or destructable. These function in a very similar way to the other function interface members,
    //            however they take two parameters, one projectile and one of a specific type that relates to the event. For 
    //            example:
    //
    //              private function OnUnitImpact takes projectile p, unit u returns nothing
    //                  call UnitDamageTarget(p.sourceUnit,u,p.damageDealt,false,fasle,null,null,null)
    //                  call p.terminate()
    //              endfunction
    //
    //                - As you can see, the above function is for the this.onUnit member. This function must take one
    //                  projectile parameter (referring to the projectile hitting the unit) and one unit parameter (referring to
    //                  the unit being hit). It must return nothing.
    //
    //              private function OnDestImpact takes projectile p, destructable d returns nothing
    //                  call KillDestructable(d)
    //                  call p.terminate()
    //              endfunction
    //
    //                - The above function is for the this.onDest member, used for projectile on destructable collision events.
    //                  The function takes one projectile parameter and one destructable parameter, each referring to a specific
    //                  object in the collision. This function must return nothing.
    //
    //          • It is important to note that the functions and their parameters can be named whatever the user wants, but they
    //            must remain in the order stated above (projectile parameter always comes first) and the functions must return
    //            nothing.
    //          • For more examples of how this works, check out the example spells (specifically: Hurl Boulder) in the test
    //            map.
    //
    //    Readonly members:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • this.dummy               -> Refers to the dummy unit of a projectile (the actual projectile object).
    //      • this.angle               -> Refers to the current facing angle of a projectile.
    //      • this.previousSpeed       -> Retrieves the previous speed of a projectile.
    //      • this.originalSpeed       -> Retrieves the original speed of a projectile.
    //      • this.isTerminated        -> Refers to whether or not a projectile is currently terminated (true if it is).
    //      • this.posX/posY/posZ      -> Refers to the current x, y and z coordinates of a projectile.
    //      • this.tarX/tarY/tarZ      -> Refers to the current target x, y and z coordinates of a projectile.
    //      • this.velX/velY/velZ      -> Refers to the current x, y and z velocities of a projectile.
    //      • this.strX/strY/strZ      -> Refers to the starting x, y and z coordinates of a projectile.
    //      • this.distanceMax         -> Maximum distance to be travelled by a projectile (start to finish) in a straight line.
    //      • this.distanceLeft        -> Distance left to travel for a projectile (current to finish) in a straight line.
    //      • this.distanceDone        -> Distance from a projectile's starting point to its current point (straight line).
    //      • this.arcSize             -> Retrieves the arc size used for a projectile.
    //
    //      Static method operator:
    //     ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //        - projectile[unit u]     -> Retrieves the projectile data attached to a unit. Unit -> projectile typecasting.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //           _____           _  _____                       
    //          |  __ \         (_)/ ____|                      
    //          | |__) | __ ___  _| |  __ _ __ ___  _   _ _ __  
    //          |  ___/ '__/ _ \| | | |_ | '__/ _ \| | | | '_ \ 
    //          | |   | | | (_) | | |__| | | | (_) | |_| | |_) |
    //          |_|   |_|  \___/| |\_____|_|  \___/ \__,_| .__/ 
    //                         _/ |                      | |    
    //                        |__/                       |_|
    //                             By Kenny v0.1.3 (Beta)
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  What is ProjGroup?
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • ProjGroup is a fully functional projectile group API for the Projectile system, designed to closely match the
    //      native WC3 unit groups.
    //    • ProjGroup provides common grouping functions for projectiles such as adding and removing projectiles from a group,
    //      creating, clearing and destroying groups and enumerating through groups.
    //    • ProjGroup was designed to make projectile manipulation easier for users, therefore it has a simplistic interface
    //      that is easy to understand. It also comes with a WC3 alternative interface that resembles native WC3 functions.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  ProjGroup API:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • This is a quick over-view of all the methods and globals available to users with the projgroup struct.
    //
    //    ProjGroup methods:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These methods are the main methods used by the system to create, manipulate and destroy projgroups. They
    //        include:
    //
    //        - projgroup.create()                              - this.forNearby()
    //
    //        - this.add()                                      - this.forNearbyEx()
    //
    //        - this.remove()                                   - this.forGroup()
    //
    //        - this.isInGroup()                                - this.forGroupEx()
    //
    //        - this.getCount()                                 - this.destroy()
    //
    //        - this.getFirst()
    //
    //        - this.clear()
    //
    //        - this.enumNearby()
    //
    //    ProjGroup globals:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These globals are to be used in conjunction with the this.enumNearby and this.forGroup() methods of projgroups
    //        to access projectiles. They include:
    //
    //        - EnumProjectile
    //
    //        - ParentProjGroup
    //
    //        - ForProjGroupData
    //
    //        - GlobalProjGroup
    //
    //  Alternate ProjGroup API:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • This is an alternate interface for projgroups that closely resembles native WC3 group API, for nostalgia's sake.
    //
    //    ProjGroup functions:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These functions are the alternate interface for projgroups that encompass both projgroup methods and globals.
    //        They include:
    //
    //        - CreateProjGroup()                 - ForNearbyProjectilesInRange()     - GetGlobalProjGroup()
    //
    //        - ProjGroupAddProjectile()          - ForNearbyProjectilesInRangeEx()
    // 
    //        - ProjGroupRemoveProjectile()       - ForProjGroup()
    //
    //        - IsProjectileInProjGroup()         - ForProjGroupEx()
    //
    //        - CountProjectilesInProjGroup()     - DestroyProjGroup()
    //
    //        - FirstOfProjGroup()                - GetEnumProjectile()
    //
    //        - ProjGroupClear()                  - GetParentProjGroup()
    //
    //        - GroupEnumProjectilesInRange()     - GetForProjGroupData()  
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Detailed ProjGroup API descriptions:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    Methods:
    //   ¯¯¯¯¯¯¯¯¯
    //      • projgroup.create() -> returns projgroup
    //      or
    //      • CreateProjGroup() -> returns projgroup
    //
    //        - The above method enables users to create a projgroup, which is basically a group for projectiles (similar to
    //          WC3 native groups for units). This method will returns a projgroup to be saved into a variable.
    //        - The alternative WC3 naming for this requires no parameters as well.
    //
    //      • this.add(projectile p) -> returns boolean
    //      or
    //      • ProjGroupAddProjectile(projgroup g, projectile p) -> returns boolean
    //
    //        - The above method adds a projectile to a projgroup (similar to GroupAddUnit()). This method will return true
    //          if the projectile was successfully added and false if it wasn't.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the projectile parameter.
    //
    //      • this.remove(projectile p) -> returns boolean
    //      or
    //      • ProjGroupRemoveProjectile(projgroup g, projectile p) -> returns boolean
    //
    //        - This method removes a projectile from a projgroup (similar to GroupRemoveUnit()). This method will return true
    //          if the projectile was successfully removed and false if it wasn't.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the projectile parameter.
    //
    //      • this.isInGroup(projectile p) -> returns boolean
    //      or
    //      • IsProjectileInProjGroup(projgroup g, projectile p) -> returns boolean
    //
    //        - This method checks to see if a specified projectile is in a projgroup (similar to IsUnitInGroup()). This method
    //          will return true if the projectile is in the group and false if it isn't.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the projectile parameter.
    //
    //      • this.getCount() -> returns integer
    //      or
    //      • CountProjectilesInProjGroup(projgroup g) -> returns integer
    //
    //        - This method will return an integer that represents the number of projectiles currently in a group (similar to
    //          CountUnitsInGroup()).
    //        - The alternative WC3 naming for this requires a projgroup parameter.
    //
    //      • this.getFirst() -> returns projectile
    //      or
    //      • FirstOfProjGroup(projgroup g) -> returns projectile
    //
    //        - This method attempts to simulate the WC3 native FirstOfGroup(). It will return a projectile that is at the
    //          start of the internal projectile array of a projgroup. Useful for first-of-group-loops.
    //        - The alternative WC3 naming for this requires a projgroup parameter.
    //
    //      • this.clear() -> returns nothing
    //      or
    //      • ProjGroupClear(projgroup g) -> returns nothing
    //
    //        - This method will clear all projectiles from a projgroup, emptying it of all data completely (similar to
    //          GroupClear()). It returns nothing.
    //        - The alternative WC3 naming for this requires a projgroup parameter.
    //
    //      • this.enumNearby(real x, real y, real z, real radius) -> returns nothing
    //      or
    //      • GroupEnumProjectilesInRange(projgroup g, real x, real y, real z, real radius) -> returns nothing
    //
    //        - This method will group all projectiles in a specified radius around given coordinates and add them to a
    //          projgroup. Before adding projectiles to the projgroup it will clear to projgroup of all existing projectiles,
    //          to better simulate the WC3 GroupEnumUnitsInRange(). It takes four parameters, the first three being the x, y and
    //          z coordinates around which you want projectiles to be added, and the fourth being the radius in which
    //          projectiles need to be to be added to the projgroup.
    //        - The alternative WC3 naming for this requires a projgroup parameter before other parameters.
    //
    //      • this.forGroup(enumFunc e) -> returns nothing
    //      or
    //      • ForProjGroup(projgroup g, enumFunc e) -> returns nothing
    //
    //        - This method will perform a function for every projectile in a projgroup. It has one parameter, which is the
    //          function that will be executed for all projectiles, it is similar to the function interface members for the
    //          projectile struct. The function that is to be passed through this method as an parameter must take nothing and
    //          return nothing. For example:
    //
    //            private function EnumFunctionExample takes nothing and returns nothing
    //                call EnumProjectile.terminate()
    //            endfunction
    //
    //        - As you can see above the function takes nothing and returns nothing, and inside this function users can use
    //          the EnumProjectile global to access the current projectile the function is being executed for.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the enumFunc parameter.
    //
    //      • this.forGroupEx(enumFunc e, integer i) -> returns nothing
    //      or
    //      • ForProjGroupEx(projgroup g, enumFunc e, integer i) -> returns nothing
    //
    //        - This method works in the exact same way as the above-mentioned .forGroup() method, except that it takes one
    //          more parameter. This last parameter (that comes after the enumFunc parameter) refers to any temporary data
    //          that a user wants to access in the enumFunc provided by the user. It also provides access to the parent
    //          projgroup that the method was used for. For example:
    //
    //            private function EnumFunctionExample takes nothing and returns nothing
    //                call Data(ForProjGroupData).destroy() <-- Needs to be typecasted, as with some timer data systems.
    //                call EnumProjectile.terminate()
    //                call ParentProjGroup.destroy()
    //            endfunction
    //
    //        - As you can see above the function takes nothing and returns nothing, and inside this function users can
    //          access not only the projectile the function is being executed for, but also any temporary data and the
    //          parent projgroup that the .forGroupEx() method was called for.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the other parameters.
    //
    //      • this.forNearby(real x, real y, real z, real radius, integer i, enumFunc e)
    //      or
    //      • ForNearbyProjectilesInRange(projgroup p, real x, real y, real z, real r, integer i, enumFunc e)
    //
    //        - The above method works similarly to .enumNearby(), however instead of just adding the projectiles to the group
    //          it will also execute the enumFunc for each projectile added. Think of it as a mix between .enumNearby() and
    //          .forGroupEx(). This method also takes an integer parameter before the enumFunc that can be set to temporary
    //          data for use.
    //        - The alternative WC3 naming for this requires a projgroup parameter before the other parameters.
    //
    //      • this.forNearbyEx(real x, real y, real z, real radius, integer i, enumFunc e1, enumFunc e2)
    //      or 
    //      • ForNearbyProjectilesInRangeEx(projgroup p, real x, real y, real z, real r, integer i, enumFunc e1, enumFunc e2)
    //
    //        - The above method works in the same way as .forNearby(), however it has an extra enumFunc parameter that will
    //          be executed when any projectiles that are still in the projgroup are removed from the group before the
    //          enumerating begins. The first enumFunc parameter is for when the projectiles get removed, while the second
    //          enumFunc parameter is for when a projectile is added to the projgroup. This method can also save and access
    //          temporary data and parent projgroups for .forGroupEx().
    //        - The alternative WC3 naming for this requires a projgroup parameter before the other parameters.
    //
    //      • this.destroy() -> returns nothing
    //      or
    //      • DestroyProjGroup(projgroup g) -> returns nothing
    //
    //        - This method destroys a projgroup, clearing it of all data (similar to DestroyGroup()). This method returns
    //          nothing.
    //        - The alternative WC3 naming for this requires a projgroup parameter.
    //
    //    Globals:
    //   ¯¯¯¯¯¯¯¯¯
    //      • EnumProjectile -> returns projectile
    //      or
    //      • GetEnumProjectile() -> returns projectile
    //
    //        - This global returns the most recent projectile a function from .forGroup() has been called for. It is to be
    //          used like GetEnumUnit() in a normal ForGroup() call.
    //        - The alternative WC3 naming for this is a function not a global.
    //
    //      • ParentProjGroup -> returns projectile
    //      or
    //      • GetParentProjGroup() -> returns projectile
    //
    //        - This global returns the most recent projgroup taht .forGroupEx() has been called for. It could come in handy
    //          for some situations.
    //        - The alternative WC3 naming for this is a function not a global.
    //
    //      • ForProjGroupData -> returns projectile
    //      or
    //      • GetForProjGroupData() -> returns projectile
    //
    //        - This global returns the most recent temporary data that a user wanted to access in the .forGroupEx() method.
    //          This can be used to access extra data needed for the function.
    //        - The alternative WC3 naming for this is a function not a global.
    //
    //      • GlobalProjGroup -> returns projgroup
    //      or
    //      • GetGlobalProjGroup() -> returns projgroup
    //
    //        - This global is to be used like the temporary group from GroupUtils. It saves the user from creating and 
    //          destroying a projgroup if they need to use one .enumNearby() and .forGroup() call.
    //        - The alternative WC3 naming for this is a function not a global.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Miscellaneous API:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    • This is a quick over-view of all the other miscellaneous functions available to users that haven't been covered.
    //
    //    Various functions:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • These functions have been added to the system for completeness, and also offer some use for both debugging and
    //        gameplay purposes. They include:
    //
    //        - GetTotalProjectiles()
    //
    //        - IsUnitProjectile()
    //
    //        - GetUnitProjectileData()
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Detailed miscellaneous API descriptions:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    Functions:
    //   ¯¯¯¯¯¯¯¯¯¯¯
    //      • GetTotalProjectiles() -> returns integer
    //
    //        - This function returns the total amount of projectiles that are currently active in the map. This can be useful
    //          for debugging purposes.
    //
    //      • IsUnitProjectile(unit u) -> returns boolean
    //
    //        - This function takes a unit parameter (referring to which unit the user wants to check) and checks whether or not
    //          it is a projectile.
    //
    //      • GetUnitProjectileData(unit u) -> returns projectile
    //
    //        - This function retrieves the projectile data that is attached to the unit passed through the function. Be sure
    //          to check if the unit is a projectile beforehand.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //------------------------------------------------------------------------------------------------------------------------\\
    //
    //  Configurables:
    // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //    Public configurables:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • DUMMY_ID            -> The raw code of the dummy unit used in this system. Make sure you change this to the raw
    //                               code of the dummy unit in your map.
    //      • CROW_FORM           -> The raw code for the crow form ability that allows for unit heights to be changed. If you
    //                               have changed this ability in any way, you may want to make another and change the raw code.
    //      • OWNER_ID            -> The owning player of the dummy units used for the projectiles in this system. Can be used
    //                               for debugging purposes.
    //      • RECYCLE             -> Whether or not the system is set to recycle dummy units when they are no longer being used.
    //                               Useful for keeping lag to a minimum.
    //    Private configurables:
    //   ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    //      • DEFAULT_UNIT_COLL   -> The default unit collision radius for projectiles on unit collisions.
    //      • DEFAULT_DEST_COLL   -> The default destructable collision radius for projectile on destructable collisions.
    //
    //      • REMOVAL_DELAY       -> Default time taken to remove a projectile if .allowDeathSfx is true (can be changed dynamically).
    //
    //      • MAX_PROJECTILES     -> How many projectiles can be active at any one time. This number will never need to change.
    //      • MAX_PROJGROUPS      -> How many projgroups can be active at any given time. This number will never need to change.
    //
    //      • PRELOAD_PROJECTILES -> Whether or not to allow preloading of projectiles. This only matters if RECYCLE is true.
    //      • PRELOAD_AMOUNT      -> How many projectiles should be preloaded if preloading is allowed.
    //
    //------------------------------------------------------------------------------------------------------------------------\\
   
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Configurables: See above for descriptions.
    //
    globals
        public  constant integer DUMMY_ID            = 'h02N'
        public  constant integer CROW_FORM           = 'Amrf'
        public  constant player  OWNER_ID            = Player(PLAYER_NEUTRAL_PASSIVE)
        public  constant boolean RECYCLE             = false

        private constant real    DEFAULT_UNIT_COLL   = 64.00
        private constant real    DEFAULT_DEST_COLL   = 64.00
        
        private constant real    REMOVAL_DELAY       = 2.00
        
        private constant integer MAX_PROJECTILES     = 8190
        private constant integer MAX_PROJGROUPS      = 8190
        
        private constant boolean PRELOAD_PROJECTILES = false
        private constant integer PRELOAD_AMOUNT      = 300
    endglobals
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  DO NOT TOUCH PAST THIS POINT UNLESS YOU KNOW WHAT YOUR ARE DOING!!!
    //                           
    globals    
        projgroup  GlobalProjGroup  = 0           // Global temporary projgroup for enums.
        projgroup  ParentProjGroup  = 0           // Parent projgroup that used .forGroupEx() or .forNearbyEx().
        projectile EnumProjectile   = 0           // Used in .forGroup() and .forNearby() methods for projgroups.
        integer    ForProjGroupData = 0           // Temporary data that can be used in .forGroupEx() or .forNearbyEx().
    endglobals
    
    native UnitAlive takes unit whichUnit returns boolean
                
    globals
        private projectile ProjectileList = 0     // Linked list to keep track of projectiles.
        private integer    RecycledCount  = 0     // Counter for unit recycling.
        private real       WorldMaxX      = 0.00  // Map boundaries for internal BoundSentinel.
        private real       WorldMaxY      = 0.00  // Map boundaries for internal BoundSentinel.
        private real       WorldMinX      = 0.00  // Map boundaries for internal BoundSentinel.
        private real       WorldMinY      = 0.00  // Map boundaries for internal BoundSentinel.
        private hashtable  StorageOne     = null  // Hashtable used for trigger and projectile storage.
        private hashtable  StorageTwo     = null  // Hashtable needed for removing projectiles from projgroups.
        private unit array RecycledUnits          // Array to keep track of recycled units.
    endglobals
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Temporary globals: Needed for the periodic method.
    //
    globals
        private real     TempX = 0.00             // Temporary x coordinate for targets and distances.
        private real     TempY = 0.00             // Temporary y coordinate for targets and distances.
        private real     TempZ = 0.00             // Temporary z coordinate z heights of xy coordinates.
        private real     TempD = 0.00             // Temporary real for distance calculations.
        private real     TempP = 0.00             // Temporary real for animation calculations.
        private location TempL = null             // Temporary location for z heights of xy coordinates.
    endglobals
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Projectile counter: Easier way to find out how many active projectiles there are.
    //
    function GetTotalProjectiles takes nothing returns integer
        return ProjectileList.size
    endfunction

    //------------------------------------------------------------------------------------------------------------------------\\
    //  Function interfaces: Bonus functions available for greater control.
    //
    private function interface EnumEvents takes nothing returns nothing
    private function interface UserEvents takes projectile instance returns nothing
    private function interface UnitImpact takes projectile instance, unit whichUnit returns nothing
    private function interface DestImpact takes projectile instance, destructable whichDest returns nothing
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Projectile recycling: For more efficient projectile creation.
    //
    private function NewProjectile takes real xPos, real yPos, real facing returns unit
        if RecycledCount == 0 then
            set RecycledUnits[0] = CreateUnit(OWNER_ID,DUMMY_ID,xPos,yPos,facing * bj_RADTODEG)
            call UnitAddAbility(RecycledUnits[0],CROW_FORM)
            call UnitRemoveAbility(RecycledUnits[0],CROW_FORM)
        else
            set RecycledCount = RecycledCount - 1
            call PauseUnit(RecycledUnits[RecycledCount],false)
            call SetUnitFacing(RecycledUnits[RecycledCount],facing * bj_RADTODEG)
        endif
        
        return RecycledUnits[RecycledCount]
    endfunction
    
    private function ReleaseProjectile takes unit whichUnit returns boolean
        call SetUnitX(whichUnit,WorldMaxX)
        call SetUnitY(whichUnit,WorldMaxY)
        call PauseUnit(whichUnit,true)
        set RecycledUnits[RecycledCount] = whichUnit
        set RecycledCount = RecycledCount + 1
        
        return true
    endfunction
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  ProjData: Stores Projectile structs allocated to dummy units. 
    //
    private struct ProjData extends array
        //! runtextmacro AIDS()
        
        public projectile data

        private static method AIDS_filter takes unit whichUnit returns boolean
            return GetUnitTypeId(whichUnit) == DUMMY_ID
        endmethod
        
        private method AIDS_onCreate takes nothing returns nothing
            set this.data = 0
        endmethod
        
        private method AIDS_onDestroy takes nothing returns nothing
            set this.data = 0
        endmethod
        
    endstruct
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Delayed Unit Remover: To show the death effect of projectiles.
    //
    private struct DelayedRemoval
    
        private unit temp = null
        private real tick = 0.00
        
        private method remove takes nothing returns nothing
            static if RECYCLE then
                call ReleaseProjectile(this.temp)
            else
                call RemoveUnit(this.temp)
            endif
            
            set this.temp = null
            call this.deallocate()
        endmethod
        
        private method periodic takes nothing returns nothing
            if this.tick == T32_Tick then
                call this.stopPeriodic()
                call this.remove()
            endif
        endmethod
        
        implement T32x
        
        static method add takes unit whichUnit, real delay returns nothing
            local thistype this = thistype.allocate()
            
            set this.temp = whichUnit
            set this.tick = T32_Tick + R2I(delay / T32_PERIOD)
            
            call this.startPeriodic()
        endmethod
        
    endstruct
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  ProjMethods: Bonus method operators for users. Easier for me to maintain.
    //
    private module ProjOperators
        
        //------------------------------------------------------------\\
        //  Projectile scale size.
        method operator scaleSize= takes real value returns nothing
            call SetUnitScale(this.dummy,value,0.00,0.00)
            set this.scale = value
        endmethod
        method operator scaleSize takes nothing returns real
            return this.scale
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile model and effect path.
        method operator effectPath= takes string whichPath returns nothing
            if this.sfx != null then
                call DestroyEffect(this.sfx)
                set this.path = ""
            endif
           
            if whichPath == "" then
                set this.sfx  = null
                set this.path = ""
            else
                set this.sfx  = AddSpecialEffectTarget(whichPath,this.dummy,"origin")
                set this.path = whichPath
            endif
        endmethod
        method operator effectPath takes nothing returns string
            return this.path
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile speeds.
        method operator currentSpeed= takes real value returns nothing
            local real factor = value * T32_PERIOD / this.speed
            
            if value <= 0.00 then
                debug call BJDebugMsg("|cFFFF0000Error using Projectile:|r .currentSpeed must be a non-zero positive value.")
                return
            endif
            
            set this.oldSpeed = this.speed
            set this.speed    = value * T32_PERIOD
            set this.time     = this.time / factor
            set this.velX     = this.velX * factor
            set this.velX     = this.velY * factor
            set this.velZ     = this.velZ * factor
            set this.accZ     = this.accZ * factor * factor
        endmethod
        method operator currentSpeed takes nothing returns real
            return this.speed / T32_PERIOD
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile target unit.
        method operator targetUnit= takes unit targ returns nothing
            set this.update = true
            set this.target = targ
        endmethod
        method operator targetUnit takes nothing returns unit
            return this.target
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile distances.
        method operator distanceMax takes nothing returns real
            return SquareRoot((this.tarX - this.strX) * (this.tarX - this.strX) + (this.tarY - this.strY) * (this.tarY - this.strY))
        endmethod
        method operator distanceLeft takes nothing returns real
            return SquareRoot((this.tarX - this.posX) * (this.tarX - this.posX) + (this.tarY - this.posY) * (this.tarY - this.posY))
        endmethod
        method operator distanceDone takes nothing returns real
            return SquareRoot((this.posX - this.strX) * (this.posX - this.strX) + (this.posY - this.strY) * (this.posY - this.strY))
        endmethod
        
        //------------------------------------------------------------\\
        //  Previous projectile speeds.
        method operator previousSpeed takes nothing returns real
            return this.oldSpeed / T32_PERIOD
        endmethod
        method operator originalSpeed takes nothing returns real
            return this.oriSpeed / T32_PERIOD
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile facing angle.
        method operator angle takes nothing returns real
            return Atan2((this.posY + this.velY) - this.posY,(this.posX + this.velX) - this.posX)
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile termination boolean.
        method operator isTerminated takes nothing returns boolean
            return this.stop
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile static method operator.
        static method operator[] takes unit whichUnit returns thistype
            return ProjData[whichUnit].data
        endmethod
        
    endmodule
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  ProjMethods: Bonus methods for users. Easier for me to maintain.
    //
    private module ProjMethods
        
        //------------------------------------------------------------\\
        //  Set target coordinates of projectile.
        method setTargPoint takes real xPos, real yPos, real zPos, boolean wantUpdate returns nothing
            set this.target  = null
            set this.arcSize = 0.00
            set this.tarX    = xPos
            set this.tarY    = yPos
            call MoveLocation(TempL,this.tarX,this.tarY)
            set this.tarZ    = zPos + GetLocationZ(TempL)
            set this.update  = wantUpdate
        endmethod
        
        //------------------------------------------------------------\\
        //  Set projectile coordinates.
        method setProjPoint takes real xPos, real yPos, real zPos, boolean wantUpdate returns nothing
            set this.posX   = xPos
            set this.posY   = yPos
            set this.posZ   = zPos
            set this.update = wantUpdate
        endmethod
        
        //------------------------------------------------------------\\
        //  Disjoint projectile to stop homing and remove target.
        method disjoint takes nothing returns nothing
            set this.target = null
            set this.allowTargetHoming = false
        endmethod
        
        //------------------------------------------------------------\\
        //  New reset method.
        method refresh takes boolean flag returns nothing
            call this.stopPeriodic()
            set this.launched = false
            set this.update = true
            if not flag then
                set this.onStart = 0
            endif
        endmethod
        
        //------------------------------------------------------------\\
        //  Terminate projectile instead of destroy.
        method terminate takes nothing returns nothing
            set this.effectPath = ""
            set this.stop = true
        endmethod
        
        //------------------------------------------------------------\\
        //  Manual damage group methods. Added for completeness.
        method addUnit takes unit whichUnit returns nothing
            if not IsUnitInGroup(whichUnit,this.dmgGroup) then
                call GroupAddUnit(this.dmgGroup,whichUnit)
            endif
        endmethod
        method isUnitAdded takes unit whichUnit returns boolean
            return IsUnitInGroup(whichUnit,this.dmgGroup)
        endmethod
        method removeUnit takes unit whichUnit returns nothing
            if IsUnitInGroup(whichUnit,this.dmgGroup) then
                call GroupRemoveUnit(this.dmgGroup,whichUnit)
            endif
        endmethod
        method removeAll takes nothing returns nothing
            call GroupClear(this.dmgGroup)
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile data attachment wrappers.
        method attachData takes integer whichData returns nothing
            call SaveInteger(StorageOne,0,integer(this),whichData)
        endmethod
        method getData takes nothing returns integer
            return LoadInteger(StorageOne,0,integer(this))
        endmethod
        method hasData takes nothing returns boolean
            return HaveSavedInteger(StorageOne,0,integer(this))
        endmethod
        method detachData takes nothing returns nothing
            call RemoveSavedInteger(StorageOne,0,integer(this))
        endmethod
        
    endmodule
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Projectile: The main struct interface for the system.
    //
    struct projectile[MAX_PROJECTILES]
        implement LinkedList
        
        //------------------------------------------------------------\\
        //  Public members.
        public      unit          sourceUnit             = null               // Source unit of the projectile.
        public      player        owningPlayer           = null               // Normally the owning unit of the source unit.
        public      real          destHitRadius          = DEFAULT_DEST_COLL  // Collision radius for dest/proj collisions.
        public      real          unitHitRadius          = DEFAULT_UNIT_COLL  // Collision radius for unit/proj collisions.
        public      real          zOffset                = 0.00               // Z offset for unit targetting.
        public      real          damageDealt            = 0.00               // Easier to pass damage through projectile.
        public      real          timedLife              = 0.00               // Timed life of a projectile. Defaults to distance / speed.
        public      real          timeScale              = 1.00               // Time scale of a projectile. Determines speed by percentage.
        public      real          removalDelay           = REMOVAL_DELAY      // Time taken to remove a unit if .allowDeathSfx is true.
        public      boolean       pauseProj              = false              // If the projectile has been paused or not.
        public      boolean       allowDeathSfx          = false              // Whether or not to show the projectiles death effect.
        public      boolean       allowExpiration        = false              // Whether or not the projectile will expire when its timed life runs out.
        public      boolean       allowArcAnimReset      = false              // Whether or not the projectiles arc animation is reset on death.
        public      boolean       allowTargetHoming      = false              // If the projectile is homing (must have a target unit to work).
        public      boolean       allowDestCollisions    = false              // Whether or not to allow projectile on destructable collisions.
        public      boolean       allowUnitCollisions    = false              // Whether or not to allow projectile on unit collisions.
        public      UserEvents    onStart                = 0                  // Function that is executed when the projectile is launched.
        public      UserEvents    onLoop                 = 0                  // Function that is executed each iteration or the periodic timer.
        public      UserEvents    onFinish               = 0                  // Function that is executed when the projectile ends.
        public      UserEvents    onExpire               = 0                  // Function that is executed when the projectiles timed life ends.
        public      UserEvents    onLand                 = 0                  // Function that is executed when the projectile hits the ground.
        public      UnitImpact    onUnit                 = 0                  // Function that is executed when the projectile hits a unit.
        public      DestImpact    onDest                 = 0                  // Function that is executed when the projectile hits a destructable.
        
        //------------------------------------------------------------\\
        //  Readonly members.
        readonly    unit          dummy                  = null               // The actual projectile unit.
        readonly    real          arcSize                = 0.00               // Arc size of a projectiles z movement.
        readonly    real          posX                   = 0.00               // X coordinate for the projectiles current position.
        readonly    real          posY                   = 0.00               // Y coordinate for the projectiles current position.
        readonly    real          posZ                   = 0.00               // Z coordinate for the projectiles current position.
        readonly    real          velX                   = 0.00               // X velocity of the projectile.
        readonly    real          velY                   = 0.00               // Y velocity of the projectile.
        readonly    real          velZ                   = 0.00               // Z velocity of the projectile.
        readonly    real          tarX                   = 0.00               // X coordinate for the current target location of the projectile.
        readonly    real          tarY                   = 0.00               // Y coordinate for the current target location of the projectile.
        readonly    real          tarZ                   = 0.00               // Z coordinate for the current target location of the projectile.
        readonly    real          strX                   = 0.00               // X coordinate of the starting location of the projectile.
        readonly    real          strY                   = 0.00               // Y coordinate of the starting location of the projectile.
        readonly    real          strZ                   = 0.00               // Z coordinate of the starting location of the projectile.
        
        //------------------------------------------------------------\\
        //  Private members.
        private     unit          target                 = null               // Target unit for projectiles.
        private     effect        sfx                    = null               // Special effect added to the dummy unit to give it a model.
        private     string        path                   = ""                 // Model path of the special effect.
        private     boolean       stop                   = false              // If the projectile instance has been stopped (destroyed).
        private     boolean       launched               = false              // Safety boolean to stop re-firing of projectile.         
        private     boolean       update                 = true               // Whether or not to update homing. Must be true to start off.
        private     real          speed                  = 0.00               // The current speed of the projectile.
        private     real          oriSpeed               = 0.00               // The previous speed of the projectile.
        private     real          oldSpeed               = 0.00               // The original speed of the projectile.
        private     real          time                   = 0.00               // Time taken for the projectile to travel.
        private     real          accZ                   = 0.00               // Z acceleration for the arc movement.
        private     real          scale                  = 0.00               // Saves the scale size of the projectile.
        private     group         dmgGroup                                    // Group needed so units aren't hit more than once.
         
        //------------------------------------------------------------\\
        //  Static members.
        private static rect     destRect = null         // Rect for filtering destructables.
        private static group    temGroup = null         // Group needed for unit collision.
        private static boolexpr destFilt = null         // The condition used for dest collision.
        private static boolexpr unitFilt = null         // The condition used for unit collision.
        private static thistype currInst = 0            // Current struct instance for dest collision.
        
        //------------------------------------------------------------\\
        //  Implementing required modules.
        implement ProjOperators
        implement ProjMethods
        
        //------------------------------------------------------------\\
        //  Implementing optional modules.
        implement optional ProjShadows
        implement optional ProjBounces
        
        //------------------------------------------------------------\\
        //  Destroy method: Clear all data from projectiles.
        private method destroy takes nothing returns nothing
            local integer i = 0
            
            call this.onFinish.execute(this)
            
            if HaveSavedInteger(StorageOne,this,-1) then
                set i = LoadInteger(StorageOne,this,-1) - 1
                loop
                    exitwhen i < 0
                    call projgroup(LoadInteger(StorageOne,this,i)).remove(this)
                    set i = i - 1
                endloop
                call FlushChildHashtable(StorageOne,this)
                call FlushChildHashtable(StorageTwo,this)
            endif
            
            if this.allowArcAnimReset then
                call SetUnitAnimationByIndex(this.dummy,90)
            endif
            
            if this.sfx != null then
                call DestroyEffect(this.sfx)
            endif
            
            if this.allowDeathSfx then
                call DelayedRemoval.add(this.dummy,this.removalDelay)
            else
                static if RECYCLE then
                    call ReleaseProjectile(this.dummy)
                else
                    call RemoveUnit(this.dummy)
                endif
            endif
            
            if HaveSavedInteger(StorageOne,0,integer(this)) then
                call RemoveSavedInteger(StorageOne,0,integer(this))
            endif
            
            static if LIBRARY_Recycle then
                call Group.release(this.dmgGroup)
                set this.dmgGroup = null
            elseif LIBRARY_GroupUtils then
                call ReleaseGroup(this.dmgGroup)
                set this.dmgGroup = null
            else
                call GroupClear(this.dmgGroup)
            endif
            
            static if LIBRARY_ProjShadows then
                if this.hasShadow then
                    call this.detachShadow()
                endif
            endif
            
            set ProjData[this.dummy].data = 0
            
            set this.sourceUnit = null
            set this.dummy      = null
            set this.sfx        = null
            set this.path       = ""
            
            call this.deallocate()
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile on destructable collision detection.
        private static method destCollisionFilt takes nothing returns boolean
            local thistype     this = thistype.currInst
            local destructable dest = GetFilterDestructable()
            local real         desx = GetDestructableX(dest)
            local real         desy = GetDestructableY(dest)
            
            if GetWidgetLife(dest) > 0.405 then
                if (this.posX - desx) * (this.posX - desx) + (this.posY - desy) * (this.posY - desy) <= this.destHitRadius * this.destHitRadius then
                    call this.onDest.execute(this,dest)
                endif
            endif
            
            set dest = null
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile on unit collision detection.
        private static method unitCollisionFilt takes nothing returns boolean
            local thistype this = thistype.currInst
            local unit     filt = GetFilterUnit()
            
            if not IsUnitInGroup(filt,this.dmgGroup) then
                call GroupAddUnit(this.dmgGroup,filt)
                call this.onUnit.execute(this,filt)
            endif
            
            set filt = null
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  Periodic method: Update projectile movement.
        private method periodic takes nothing returns nothing   
            if this.stop then
                call this.stopPeriodic()
                call this.destroyThis()
            else
                if this.onLoop != 0 then
                    call this.onLoop.execute(this)
                endif
                
                if this.allowDestCollisions then
                    set thistype.currInst = this
                    call SetRect(thistype.destRect,this.posX - this.destHitRadius,this.posY - this.destHitRadius,this.posX + this.destHitRadius,this.posY + this.destHitRadius)
                    call EnumDestructablesInRect(thistype.destRect,thistype.destFilt,null)
                endif
                
                if this.allowUnitCollisions then
                    set thistype.currInst = this
                    call GroupEnumUnitsInRange(thistype.temGroup,this.posX,this.posY,this.unitHitRadius,thistype.unitFilt)
                endif
                
                if not this.pauseProj then                    
                    if this.target != null and this.allowTargetHoming and UnitAlive(this.target) then
                        set TempX = GetUnitX(this.target)
                        set TempY = GetUnitY(this.target)
                        call MoveLocation(TempL,TempX,TempY)
                        set TempZ = GetUnitFlyHeight(this.target) + GetLocationZ(TempL) + this.zOffset
                        if this.tarX != TempX or this.tarY != TempY or this.tarZ != TempZ then
                            set this.tarX  = TempX
                            set this.tarY  = TempY
                            set this.tarZ  = TempZ
                            set this.update = true
                        endif
                    endif
                    
                    if this.update then
                        set TempX     = this.tarX - this.posX
                        set TempY     = this.tarY - this.posY
                        set TempZ     = this.tarZ - this.posZ
                        set TempD     = SquareRoot(TempX * TempX + TempY * TempY + TempZ * TempZ)
                        set this.velX = TempX / TempD * this.speed
                        set this.velY = TempY / TempD * this.speed
                        set this.time = TempD / this.speed * T32_PERIOD
                        if this.time <= 0.00 then
                            set this.time = T32_PERIOD
                        endif
                        if this.arcSize != 0.00 then
                            set this.accZ = 2.00 * (TempZ / this.time / this.time * T32_PERIOD * T32_PERIOD - (this.velZ * T32_PERIOD) / this.time)
                        else
                            set this.velZ = TempZ / TempD * this.speed
                            set this.accZ = 0.00
                        endif
                        call SetUnitFacing(this.dummy,Atan2(TempY,TempX) * bj_RADTODEG)
                        set this.update = false
                    endif

                    set TempP     = this.posZ
                    set this.velZ = this.velZ + this.accZ * this.timeScale
                    set this.posX = this.posX + this.velX * this.timeScale
                    set this.posY = this.posY + this.velY * this.timeScale
                    set this.posZ = this.posZ + this.velZ * this.timeScale
                    
                    call MoveLocation(TempL,this.posX,this.posY)
                    set TempZ = GetLocationZ(TempL)
                    
                    call SetUnitX(this.dummy,this.posX)
                    call SetUnitY(this.dummy,this.posY)
                    call SetUnitFlyHeight(this.dummy,this.posZ - TempZ,0.00)
                    call SetUnitAnimationByIndex(this.dummy,R2I(bj_RADTODEG * Atan2((this.posZ - TempP),SquareRoot(this.velX * this.velX + this.velY * this.velY) * this.timeScale) + 90.50))
                    
                    static if LIBRARY_ProjShadows then
                        if this.hasShadow then
                            call this.updateShadow()
                        endif
                    endif
                    
                    set this.timedLife = this.timedLife - T32_PERIOD * this.timeScale
                    
                    if this.timedLife <= 0.00 then
                        if this.allowExpiration then
                            set this.stop = true
                        endif
                        if this.onExpire != 0 then
                            call this.onExpire.execute(this)
                        endif
                    endif
                    
                    if this.posZ <= TempZ then
                        static if LIBRARY_ProjBounces then
                            if this.allowBouncing then
                                call this.bounce()
                            endif
                        endif
                        if this.onLand != 0 then
                            call this.onLand.execute(this)
                        endif
                    endif
                endif
            endif
        endmethod
        
        implement T32x
        
        //------------------------------------------------------------\\
        //  Common method: Set all common members from project methods.
        private method setCommon takes real xPos, real yPos, real zPos, real speed, real arc returns nothing
            local real tempX   = xPos - this.posX
            local real tempY   = yPos - this.posY
            local real tempZ   = zPos - this.posZ
            local real tempD   = SquareRoot(tempX * tempX + tempY * tempY + tempZ * tempZ)
            
            if speed <= 0.00 or tempD <= 0.00 then
                set this.posX  = xPos
                set this.posY  = yPos
                set this.posZ  = zPos
                set this.time  = 0.00
            else
                set this.time  = tempD / speed
            endif
            
            set this.speed     = speed * T32_PERIOD
            set this.oriSpeed  = this.speed
            set this.oldSpeed  = this.speed
            set this.arcSize   = arc
            set this.tarX      = xPos
            set this.tarY      = yPos
            set this.tarZ      = zPos
            set this.velX      = tempX / tempD * this.speed
            set this.velY      = tempY / tempD * this.speed
            set this.velZ      = ((tempD * arc) / (this.time / 4.00) + tempZ / this.time ) * T32_PERIOD
            
            if this.timedLife == 0.00 then
                set this.timedLife = this.time
            endif
        endmethod
        
        //------------------------------------------------------------\\
        //  Project normal method: Launch without arc.
        method projectNormal takes real xPos, real yPos, real zPos, real speed returns boolean
            if not this.launched then
                set this.launched = true
                call this.setCommon(xPos,yPos,zPos,speed,0.00)
                call this.onStart.execute(this)
                call this.startPeriodic()
                return true
            endif
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  Project arcing method: Lauch with arc.
        method projectArcing takes real xPos, real yPos, real zPos, real speed, real arc returns boolean
            if not this.launched then
                set this.launched = true
                call this.setCommon(xPos,yPos,zPos,speed,arc)
                call this.onStart.execute(this)
                call this.startPeriodic()
                return true
            endif
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  Projectile creation.
        static method create takes real xPos, real yPos, real zPos, real facing returns thistype
            local thistype this = thistype.allocate()
            
            static if RECYCLE then
                set this.dummy = NewProjectile(xPos,yPos,facing)
            else
                set this.dummy = CreateUnit(OWNER_ID,DUMMY_ID,xPos,yPos,facing * bj_RADTODEG)
                call UnitAddAbility(this.dummy,CROW_FORM)
                call UnitRemoveAbility(this.dummy,CROW_FORM)
            endif
            
            call SetUnitX(this.dummy,xPos)
            call SetUnitY(this.dummy,yPos)
            call MoveLocation(TempL,xPos,yPos)
            call SetUnitFlyHeight(this.dummy,zPos,0.00)
            
            set this.posX = xPos
            set this.posY = yPos
            set this.posZ = zPos + GetLocationZ(TempL)
            set this.strX = xPos
            set this.strY = xPos
            set this.strZ = zPos + GetLocationZ(TempL)
            set ProjData[this.dummy].data = this
            
            static if LIBRARY_Recycle then
                set this.dmgGroup = Group.get()
            elseif LIBRARY_GroupUtils then  
                set this.dmgGroup = NewGroup()
            else
                if this.dmgGroup == null then
                    set this.dmgGroup = CreateGroup()
                endif
            endif
            
            return ProjectileList.addToStart(this)
        endmethod
        
        //------------------------------------------------------------\\
        //  OnInit method: Setup static members.
        private static method onInit takes nothing returns nothing
            set thistype.temGroup = CreateGroup()
            set thistype.destRect = Rect(0.00,0.00,0.00,0.00)
            set thistype.destFilt = Condition(function thistype.destCollisionFilt)
            set thistype.unitFilt = Condition(function thistype.unitCollisionFilt)
        endmethod
        
    endstruct
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  ForGroupStack: For recursion safety for projectile groups.
    //
    private struct ForGroupStack extends array

        public integer   callback
        public integer   tempData
        public projgroup whichGrp
        
        public static thistype top = 0
        
        static method increment takes nothing returns nothing
            set thistype.top = thistype(thistype.top + 1)
        endmethod
        
        static method decrement takes nothing returns nothing
            set thistype.top = thistype(thistype.top - 1)
        endmethod
        
    endstruct

    //------------------------------------------------------------------------------------------------------------------------\\
    //  Projectile groups: More advanced and all-encompassing grouping system.
    //
    private function ForProjGroupExCallback takes nothing returns nothing
        set EnumProjectile   = ProjData[GetEnumUnit()].data
        set ParentProjGroup  = ForGroupStack.top.whichGrp
        set ForProjGroupData = ForGroupStack.top.tempData
        call EnumEvents(ForGroupStack.top.callback).execute()
    endfunction
    
    private function ForProjGroupCallback takes nothing returns nothing
        set EnumProjectile = ProjData[GetEnumUnit()].data
        call EnumEvents(ForGroupStack.top.callback).execute()
    endfunction
    
    struct projgroup[MAX_PROJGROUPS]

        private integer max = 0
        private group   grp
        
        //------------------------------------------------------------\\
        //  Destroy method: Clear all data and destroy the struct.
        method destroy takes nothing returns nothing
            call this.clear()
            
            static if LIBRARY_Recycle then
                call Group.release(this.grp)
                set this.grp = null
            elseif LIBRARY_GroupUtils then
                call ReleaseGroup(this.grp)
                set this.grp = null
            else
                call GroupClear(this.grp)
            endif
            
            call this.deallocate()
        endmethod
        
        //------------------------------------------------------------\\
        //  ForGroupEx method: Execute function for all projectiles.
        method forGroupEx takes EnumEvents whichFunc, integer whichData returns nothing
            call ForGroupStack.increment()
            set ForGroupStack.top.callback = whichFunc
            set ForGroupStack.top.tempData = whichData
            set ForGroupStack.top.whichGrp = this
            call ForGroup(this.grp,function ForProjGroupExCallback)
            call ForGroupStack.decrement()
        endmethod
        
        //------------------------------------------------------------\\
        //  ForGroup method: Execute function for all projectiles.
        method forGroup takes EnumEvents whichFunc returns nothing
            call ForGroupStack.increment()
            set ForGroupStack.top.callback = whichFunc
            call ForGroup(this.grp,function ForProjGroupCallback)
            call ForGroupStack.decrement()
        endmethod
        
        //------------------------------------------------------------\\
        //  Remove method: Remove a projectile from a projgroup.
        method remove takes projectile whichProj returns boolean 
            local integer i = 0
            local integer j = 0
            
            if whichProj != 0 and IsUnitInGroup(whichProj.dummy,this.grp) then
                call GroupRemoveUnit(this.grp,whichProj.dummy)
                set this.max = this.max - 1
                
                set i = LoadInteger(StorageOne,integer(whichProj),-1) - 1
                set j = LoadInteger(StorageTwo,integer(whichProj),this)
                call SaveInteger(StorageOne,integer(whichProj),-1,i)
                call SaveInteger(StorageOne,integer(whichProj),j,LoadInteger(StorageOne,integer(whichProj),i))
                call SaveInteger(StorageTwo,integer(whichProj),LoadInteger(StorageOne,integer(whichProj),j),j)
                
                if i < 1 then
                    call FlushChildHashtable(StorageOne,integer(whichProj))
                    call FlushChildHashtable(StorageTwo,integer(whichProj))
                endif
                
                return true
            endif
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  Add method: Add a projectile to a projgroup.
        method add takes projectile whichProj returns boolean
            local integer i = 0
            
            if whichProj != 0 and not IsUnitInGroup(whichProj.dummy,this.grp) then
                call GroupAddUnit(this.grp,whichProj.dummy)
                set this.max = this.max + 1
                
                if HaveSavedInteger(StorageOne,integer(whichProj),-1) then
                    set i = LoadInteger(StorageOne,integer(whichProj),-1)
                endif
                
                call SaveInteger(StorageOne,integer(whichProj),i,this)
                call SaveInteger(StorageTwo,integer(whichProj),this,i)
                call SaveInteger(StorageOne,integer(whichProj),-1,i + 1)
                
                return true
            endif
            
            return false
        endmethod
        
        //------------------------------------------------------------\\
        //  IsInGroup method: Check if a projectile is in a projgroup.
        method isInGroup takes projectile whichProj returns boolean
            return IsUnitInGroup(whichProj.dummy,this.grp)
        endmethod
        
        //------------------------------------------------------------\\
        //  Extended for nearby Method: Execute functions and grouping.
        method forNearbyEx takes real x, real y, real z, real r, integer i, EnumEvents e1, EnumEvents e2 returns nothing
            local projectile p = ProjectileList.head
            
            loop
                exitwhen p == 0
                if this.isInGroup(p) then
                    call this.remove(p)
                    if e1 != 0 then
                        set EnumProjectile   = p
                        set ParentProjGroup  = this
                        set ForProjGroupData = i
                        call e1.execute()
                    endif
                endif
                if r * r > ((p.posX - x) * (p.posX - x) + (p.posY - y) * (p.posY - y) + (p.posZ - z) * (p.posZ - z)) then
                    call this.add(p)
                    if e2 != 0 then
                        set EnumProjectile   = p
                        set ParentProjGroup  = this
                        set ForProjGroupData = i
                        call e2.execute()
                    endif
                endif
                set p = p.next
            endloop
        endmethod
        
        //------------------------------------------------------------\\
        //  For nearby Method: Execute functions and grouping.
        method forNearby takes real x, real y, real z, real r, integer i, EnumEvents e returns nothing
            local projectile p = ProjectileList.head
            
            call this.clear()
            
            loop
                exitwhen p == 0
                if r * r > ((p.posX - x) * (p.posX - x) + (p.posY - y) * (p.posY - y) + (p.posZ - z) * (p.posZ - z)) then
                    call this.add(p)
                    if e != 0 then
                        set EnumProjectile   = p
                        set ParentProjGroup  = this
                        set ForProjGroupData = i
                        call e.execute()
                    endif
                endif
                set p = p.next
            endloop
        endmethod
        
        //------------------------------------------------------------\\
        //  Enum method: Group all nearby projectiles.
        method enumNearby takes real x, real y, real z, real r returns nothing
            local projectile p = ProjectileList.head
            
            call this.clear()
            
            loop
                exitwhen p == 0
                if r * r > ((p.posX - x) * (p.posX - x) + (p.posY - y) * (p.posY - y) + (p.posZ - z) * (p.posZ - z)) then
                    call this.add(p)
                endif
                set p = p.next
            endloop
        endmethod
        
        //------------------------------------------------------------\\
        //  Clear method: Clear all data from a projgroup.
        method clear takes nothing returns nothing
            local unit u = null
            
            loop
                set u = FirstOfGroup(this.grp)
                exitwhen u == null
                call this.remove(ProjData[u].data)
            endloop
            
            call GroupClear(this.grp)
            set this.max = 0
            
            set u = null
        endmethod
        
        //------------------------------------------------------------\\
        //  First of group method: Retrieve first projectile.
        method getFirst takes nothing returns projectile
            return ProjData[FirstOfGroup(this.grp)].data
        endmethod
        
        //------------------------------------------------------------\\
        //  Count method: Retrieve number of projectiles in projgroup.
        method getCount takes nothing returns integer
            return this.max
        endmethod
        
        //------------------------------------------------------------\\
        //  Projgroup creation.
        static method create takes nothing returns thistype
            local thistype this = thistype.allocate()
            
            static if LIBRARY_Recycle then
                set this.grp = Group.get()
            elseif LIBRARY_GroupUtils then
                set this.grp = NewGroup()
            else
                if this.grp == null then
                    set this.grp = CreateGroup()
                endif
            endif
            
            return this
        endmethod
        
    endstruct
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Projectile groups: WC3 style wrappers for projectile groups. For nostalgia's sake.
    //
    function CreateProjGroup takes nothing returns projgroup
        return projgroup.create()
    endfunction
    
    function CountProjectilesInProjGroup takes projgroup whichGroup returns integer
        return whichGroup.getCount()
    endfunction
    
    function FirstOfProjGroup takes projgroup whichGroup returns projectile
        return whichGroup.getFirst()
    endfunction
    
    function IsProjectileInProjGroup takes projectile whichProj, projgroup whichGroup returns boolean
        return whichGroup.isInGroup(whichProj)
    endfunction
    
    function ProjGroupClear takes projgroup whichGroup returns nothing
        call whichGroup.clear()
    endfunction
    
    function ProjGroupAddProjectile takes projectile whichProj, projgroup whichGroup returns boolean
        return whichGroup.add(whichProj)
    endfunction
    
    function ProjGroupRemoveProjectile takes projectile whichProj, projgroup whichGroup returns boolean
        return whichGroup.remove(whichProj)
    endfunction
    
    function GroupEnumProjectilesInRange takes projgroup whichGroup, real x, real y, real z, real r returns nothing
        call whichGroup.enumNearby(x,y,z,r)
    endfunction
    
    function ForEnumProjectilesInRange takes projgroup whichGroup, real x, real y, real z, real r, integer i, EnumEvents e returns nothing
        call whichGroup.forNearby(x,y,z,r,i,e)
    endfunction
    
    function ForEnumProjectilesInRangeEx takes projgroup whichGroup, real x, real y, real z, real r, integer i, EnumEvents e1, EnumEvents e2 returns nothing
        call whichGroup.forNearbyEx(x,y,z,r,i,e1,e2)
    endfunction
    
    function ForProjGroup takes projgroup whichGroup, EnumEvents whichFunc returns nothing
        call whichGroup.forGroup(whichFunc)
    endfunction
    
    function ForProjGroupEx takes projgroup whichGroup, EnumEvents whichFunc, integer whichData returns nothing
        call whichGroup.forGroupEx(whichFunc,whichData)
    endfunction
    
    function DestroyProjGroup takes projgroup whichGroup returns nothing
        call whichGroup.destroy()
    endfunction
    
    function GetEnumProjectile takes nothing returns projectile
        return EnumProjectile
    endfunction
    
    function GetParentProjGroup takes nothing returns projgroup
        return ParentProjGroup
    endfunction
    
    function GetForProjGroupData takes nothing returns integer
        return ForProjGroupData
    endfunction
    
    function GetGlobalProjGroup takes nothing returns projgroup
        return GlobalProjGroup
    endfunction
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  WC3 style wrappers: For people who like normal WC3 style functions.
    //
    function IsUnitProjectile takes unit whichUnit returns boolean
        return ProjData[whichUnit].data != 0
    endfunction
    
    function GetUnitProjectileData takes unit whichUnit returns projectile
        return ProjData[whichUnit].data
    endfunction
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Bounds detection: Projectiles are destroyed when they try to leave the map.
    //
    private function OutsideMapRemoval takes nothing returns boolean
        local unit       u = GetLeavingUnit()
        local real       x = GetUnitX(u)
        local real       y = GetUnitY(u)
        local projectile p = ProjData[u].data
        
        if p != 0 then
            call p.terminate()
        else
            if(x > WorldMaxX) then
                set x = WorldMaxX
            elseif(x < WorldMinX) then
                set x = WorldMinX
            endif
            
            if(y > WorldMaxY) then
                set y = WorldMaxY
            elseif(y < WorldMinY) then
                set y = WorldMinY
            endif
            
            call SetUnitX(u,x)
            call SetUnitY(u,y)
        endif

        set u = null
        
        return false
    endfunction
    
    //------------------------------------------------------------------------------------------------------------------------\\
    //  Initialisation: Collision event, linked list, hashtable.
    //
    private function OnInit takes nothing returns nothing
        local trigger trig  = CreateTrigger()
        local region  reg   = CreateRegion()
        local rect    rec   = null

        set ProjectileList  = projectile.createList()
        set GlobalProjGroup = projgroup.create()
        set StorageOne      = InitHashtable()
        set StorageTwo      = InitHashtable()
        set TempL           = Location(0.00,0.00)
        set WorldMaxX       = GetRectMaxX(bj_mapInitialPlayableArea) - 64.00
        set WorldMaxY       = GetRectMaxY(bj_mapInitialPlayableArea) - 64.00
        set WorldMinX       = GetRectMinX(bj_mapInitialPlayableArea) + 64.00
        set WorldMinY       = GetRectMinY(bj_mapInitialPlayableArea) + 64.00
        set rec             = Rect(WorldMinX,WorldMinY,WorldMaxX,WorldMaxY)
        
        static if PRELOAD_PROJECTILES and RECYCLE then
            loop
                exitwhen RecycledCount == PRELOAD_AMOUNT
                set RecycledUnits[RecycledCount] = CreateUnit(OWNER_ID,DUMMY_ID,WorldMaxX,WorldMaxY,0.00)
                call UnitAddAbility(RecycledUnits[RecycledCount],CROW_FORM)
                call UnitRemoveAbility(RecycledUnits[RecycledCount],CROW_FORM)
                call PauseUnit(RecycledUnits[RecycledCount],true)
                set RecycledCount = RecycledCount + 1
            endloop
            set RecycledCount = PRELOAD_AMOUNT
        endif
        
        call RegionAddRect(reg,rec)
        call TriggerRegisterLeaveRegion(trig,reg,null)
        call TriggerAddCondition(trig,Condition(function OutsideMapRemoval))
        
        call RemoveRect(rec)
        
        set trig = null
        set rec  = null
        set reg  = null
    endfunction
    
endlibrary    