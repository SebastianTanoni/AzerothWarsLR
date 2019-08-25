library InstanceConfig initializer OnInit requires Instance

    private function OnInit takes nothing returns nothing
        local Instance tempInstance = 0

        set tempInstance = Instance.create()
            call tempInstance.setName("Barrow Deeps")
            call tempInstance.addRect(gg_rct_InstanceBarrowDeeps)

        set tempInstance = Instance.create()
            call tempInstance.setName("Twisting Nether")
            call tempInstance.addRect(gg_rct_TwistingNether)    

        set tempInstance = Instance.create()
            call tempInstance.setName("Dire Maul")
            call tempInstance.addRect(gg_rct_InstanceDireMaul)      

        set tempInstance = Instance.create()
            call tempInstance.setName("Scholomance")
            call tempInstance.addRect(gg_rct_InstanceScholomance)   

        set tempInstance = Instance.create()
            call tempInstance.setName("Ahn'qiraj")
            call tempInstance.addRect(gg_rct_InstanceAhnqiraj)         

        set tempInstance = Instance.create()
            call tempInstance.setName("Blackrock Depths")
            call tempInstance.addRect(gg_rct_InstanceBlackrock)  

        set tempInstance = Instance.create()
            call tempInstance.setName("Tomb of Sargeras")
            call tempInstance.addRect(gg_rct_InstanceSargerasTomb)          

        set tempInstance = Instance.create()
            call tempInstance.setName("Azjol'nerub")
            call tempInstance.addRect(gg_rct_InstanceAzjolNerub)

        set tempInstance = Instance.create()
            call tempInstance.setName("Outland")
            call tempInstance.addRect(gg_rct_InstanceOutland)      

        set tempInstance = Instance.create()
            call tempInstance.setName("Outland")
            call tempInstance.addRect(gg_rct_InstanceNazjatar)      

        set tempInstance = Instance.create()
            call tempInstance.setName("Thunder Bluff")
            call tempInstance.addRect(gg_rct_InstanceThunderBluff)     

        set tempInstance = Instance.create()
            call tempInstance.setName("Dalaran Dungeons")
            call tempInstance.addRect(gg_rct_InstanceDalaranDungeon1)     
            call tempInstance.addRect(gg_rct_InstanceDalaranDungeon2)   
            call tempInstance.addRect(gg_rct_InstanceDalaranDungeon3)   

        set tempInstance = Instance.create()
            call tempInstance.setName("Dalaran Prison")
            call tempInstance.addRect(gg_rct_InstanceDalaranPrison1)          
            call tempInstance.addRect(gg_rct_InstanceDalaranPrison2)                                                                                          
    endfunction

endlibrary