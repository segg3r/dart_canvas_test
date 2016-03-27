:: Prerequisites to execute this file: Node.js and Dart SDK

:: Clean
call rmdir build /S /Q
call rmdir electron_build /S /Q

:: Resolve dependencies
call npm install -g electron-packager
call pub --trace get

:: Compile Dart application
call pub build

:: Create Electron build folder
call mkdir electron_build

:: Copy sources for Electron application
call xcopy electron\* electron_build /s
call xcopy build\web\* electron_build /s

:: Build Electron application
cd electron_build
call npm install
call electron-packager . --platform=win32 --arch=all --asar=true
cd ../