@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

set "GRADLE_VERSION=8.13"
set "GRADLE_HOME=%~dp0.gradle-local\gradle-%GRADLE_VERSION%"
set "GRADLE_ZIP=%TEMP%\gradle-%GRADLE_VERSION%-bin.zip"
set "GRADLE_URL=https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip"

where java >nul 2>&1
if errorlevel 1 (
  echo ERROR: Java is not installed or is not on PATH.
  echo Install a 64-bit JDK 17 or newer, then reopen this window.
  exit /b 1
)

java -version 2>&1 | findstr /i "64-Bit" >nul
if errorlevel 1 echo WARNING: A 64-bit Java runtime was not detected. Use a 64-bit JDK on Windows 11.

if not exist "%GRADLE_HOME%\bin\gradle.bat" (
  echo Gradle %GRADLE_VERSION% is not cached locally.
  echo Downloading the official Windows-compatible Gradle distribution...
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; Invoke-WebRequest -UseBasicParsing -Uri '%GRADLE_URL%' -OutFile '%GRADLE_ZIP%'; New-Item -ItemType Directory -Force -Path '.gradle-local' | Out-Null; Expand-Archive -LiteralPath '%GRADLE_ZIP%' -DestinationPath '.gradle-local' -Force"
  if errorlevel 1 (
    echo ERROR: Could not download Gradle. Check your Internet connection or proxy.
    exit /b 2
  )
  del /q "%GRADLE_ZIP%" >nul 2>&1
)

if not exist "%GRADLE_HOME%\bin\gradle.bat" (
  echo ERROR: Gradle extraction did not produce gradle.bat.
  exit /b 3
)

if not defined ANDROID_HOME if defined ANDROID_SDK_ROOT set "ANDROID_HOME=%ANDROID_SDK_ROOT%"
if not defined ANDROID_HOME if exist "%LOCALAPPDATA%\Android\Sdk" set "ANDROID_HOME=%LOCALAPPDATA%\Android\Sdk"
if not defined ANDROID_HOME (
  echo ERROR: Android SDK not found.
  echo Install Android Studio and Android SDK Platform 37, then set ANDROID_HOME if necessary.
  exit /b 4
)
set "ANDROID_SDK_ROOT=%ANDROID_HOME%"

echo.
echo Building ViHealth2SHQ for Android API 37...
echo ABI support: armeabi-v7a, arm64-v8a, x86, x86_64
call "%GRADLE_HOME%\bin\gradle.bat" clean assembleDebug --no-daemon %*
if errorlevel 1 (
  echo.
  echo BUILD FAILED.
  exit /b %errorlevel%
)

echo.
echo BUILD SUCCEEDED.
echo APK files:
for /r "app\build\outputs\apk" %%F in (*.apk) do echo   %%F
endlocal
