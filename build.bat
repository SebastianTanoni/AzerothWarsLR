@echo off
echo Starting build...

echo Copying base map to output directory...
copy sourceMaps\BlankMap.w3x compiledMaps\OutputMap.w3x

echo Merging .j files in /jass into one...
copy NUL compiledMaps\\merged.j
pushd jass\
for /r %%a in (*.j) do (
  type "%%a" >> "c:\Users\MC\Documents\YakaryBovine Maps\AzerothWarsLR\compiledMaps\merged.j"
  echo. >> "c:\Users\MC\Documents\YakaryBovine Maps\AzerothWarsLR\compiledMaps\merged.j"
)
popd

echo Compiling jass...
copy NUL compiledMaps\\compiled.j
buildTools\\JassHelper\\jasshelper.exe buildTools\\common.j buildTools\\Blizzard.j compiledMaps\\merged.j compiledMaps\\compiled.j --scriptonly