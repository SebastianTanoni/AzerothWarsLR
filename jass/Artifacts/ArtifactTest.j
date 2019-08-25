library ArtifactTest initializer OnInit requires Artifact, ArtifactMenu

    private function OnInit takes nothing returns nothing
        local integer i = 0
        local Artifact tempArtifact = 0
        set tempArtifact = Artifact.create(CreateItem('frgd', 0, 0))
        call tempArtifact.setStatus(ARTIFACT_STATUS_HIDDEN)
        call tempArtifact.setDescription("Assembled from its scattered shards")
        call Artifact.create(CreateItem('modt', 0, 0))
        call Artifact.create(CreateItem('ssil', 0, 0))
        call Artifact.create(CreateItem('dtsb', 0, 0))
        call Artifact.create(CreateItem('odef', 0, 0))
        call Artifact.create(CreateItem('hval', 0, 0))
        call Artifact.create(CreateItem('mcou', 0, 0))
        call Artifact.create(CreateItem('ward', 0, 0))

        call Artifact.create(CreateItem('wild', 0, 0))
        call Artifact.create(CreateItem('ankh', 0, 0))
        call Artifact.create(CreateItem('fgsk', 0, 0))
        call Artifact.create(CreateItem('fgdg', 0, 0))
        call Artifact.create(CreateItem('whwd', 0, 0))
        call Artifact.create(CreateItem('hlst', 0, 0))

        call Artifact.create(CreateItem('lmbr', 0, 0))
        call Artifact.create(CreateItem('gfor', 0, 0))
        call Artifact.create(CreateItem('gold', 0, 0))
        call Artifact.create(CreateItem('manh', 0, 0))
        call Artifact.create(CreateItem('rdis', 0, 0))
        call Artifact.create(CreateItem('desc', 0, 0))

        call Artifact.create(CreateItem('amrc', 0, 0))
        call Artifact.create(CreateItem('axas', 0, 0))
        call Artifact.create(CreateItem('anfg', 0, 0))
        call Artifact.create(CreateItem('pams', 0, 0))
        call Artifact.create(CreateItem('arsc', 0, 0))
        call Artifact.create(CreateItem('arsh', 0, 0))        
        call Artifact.create(CreateItem('asbl', 0, 0))
        call Artifact.create(CreateItem('btst', 0, 0))
        call Artifact.create(CreateItem('blba', 0, 0))
        call Artifact.create(CreateItem('bfhr', 0, 0))
        call Artifact.create(CreateItem('brag', 0, 0))
        call Artifact.create(CreateItem('cosl', 0, 0))  

    endfunction

endlibrary