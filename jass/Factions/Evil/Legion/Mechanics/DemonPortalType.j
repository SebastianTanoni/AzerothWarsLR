library DemonPortalType

    struct DemonPortalType
        readonly static Table demonPortalTypesByIndex
        readonly static Table demonPortalTypesById
        readonly static integer count = 0

        readonly integer unitTypeId = 0
        readonly real manaMax = 0 
        readonly real manaRegen = 0
        readonly real manaStart = 0

        method setManaMax takes real value returns nothing
            set this.manaMax = value
        endmethod

        method setManaRegen takes real value returns nothing
            set this.manaRegen = value
        endmethod

        method setManaStart takes real value returns nothing
            set this.manaStart = value
        endmethod

        static method create takes integer unitTypeId returns thistype
            local thistype this = thistype.allocate()

            set this.unitTypeId = unitTypeId
            set thistype.demonPortalTypesById[unitTypeId] = this
            set thistype.demonPortalTypesByIndex[count] = this
            set thistype.count = thistype.count + 1

            return this        
        endmethod

        static method onInit takes nothing returns nothing
            set thistype.demonPortalTypesById = Table.create()
            set thistype.demonPortalTypesByIndex = Table.create()
        endmethod    
    endstruct

endlibrary