@echo off
echo Starting build...
md temp

echo Copying base map to output directory...
copy sourceMaps\BlankMap.w3x compiledMaps\OutputMap.w3x

echo MPQEditor: Extracting war3map.j...
buildTools\\MPQEditor\MPQEditor.exe extract compiledMaps\\OutputMap.w3x war3map.j compiledMaps

echo Merging project .j files into war3map.j...
pushd jass\
for /r %%a in (*.j) do (
  type "%%a" >> "e:\\Users\\Zak\\Documents\\YakaryBovine Maps\\AzerothWarsLR\\compiledMaps\\war3map.j"
  echo. >> "e:\\Users\\Zak\\Documents\\YakaryBovine Maps\\AzerothWarsLR\\compiledMaps\\war3map.j"
)
popd

echo MPQEditor: adding merged war3map.j back to output map...
buildTools\\MPQEditor\MPQEditor.exe add compiledMaps\\OutputMap.w3x compiledMaps\\war3map.j /c /auto /r

echo JassHelper: Processing war3map.j...
buildTools\\JassHelper\\jasshelper.exe buildTools\\common.j buildTools\\Blizzard.j compiledMaps\\OutputMap.w3x

echo Cleaning up...
rd /s /q temp