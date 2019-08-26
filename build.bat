@echo off
echo Starting build...
md temp

echo Copying base map to output directory...
copy sourceMaps\\BlankMap.w3x compiledMaps\\OutputMap.w3x

echo MPQEditor: Extracting war3map.j from AzerothWarsSource...
buildTools\\MPQEditor\MPQEditor.exe extract sourceMaps\\AzerothWarsSource.w3x war3map.j compiledMaps

echo Merging project .j files into war3map.j...
pushd jass\
for /r %%a in (*.j) do (
  type "%%a" >> "e:\\Users\\Zak\\Documents\\YakaryBovine Maps\\AzerothWarsLR\\compiledMaps\\war3map.j"
  echo. >> "e:\\Users\\Zak\\Documents\\YakaryBovine Maps\\AzerothWarsLR\\compiledMaps\\war3map.j"
)
popd

echo MPQEditor: adding merged war3map.j into OutputMap.w3x...
buildTools\\MPQEditor\\MPQEditor.exe add compiledMaps\\war3map.j compiledMaps\\OutputMap.w3x

echo JassHelper: Processing war3map.j...
copy NUL compiledMaps\\compiled.j
buildTools\\JassHelper\\jasshelper.exe buildTools\\common.j buildTools\\Blizzard.j compiledMaps\\war3map.j compiledMaps\\compiled.j

echo Cleaning up...
rd /s /q temp