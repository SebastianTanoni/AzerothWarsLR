# Create GeneratedJ file from content of all .j and .zn files
$InputFiles = Get-ChildItem -Path $JassFolder -Include *.j -Recurse
New-Item $GeneratedJ -ItemType File -Force

ForEach ($File in $InputFiles) {
  Get-Content -Path $File | Add-Content $GeneratedJ
}

# Run jasshelper to perform actual compilation of map script
$Params = $args + @('--scriptonly', $CommonJ, $BlizzardJ, $GeneratedJ, $OutputJ)
& $Jasshelper $Params