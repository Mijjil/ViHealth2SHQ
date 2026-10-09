@echo off
setlocal EnableExtensions
cd /d "%~dp0"
echo ViHealth2SHQ Windows 11 build environment
 echo.
where java >nul 2>&1
if errorlevel 1 (echo [FAIL] Java not found & goto :bad)
java -version
if not exist "%LOCALAPPDATA%\Android\Sdk" if not defined ANDROID_HOME if not defined ANDROID_SDK_ROOT echo [WARN] Android SDK not found at the default location.
if defined ANDROID_HOME echo [OK] ANDROID_HOME=%ANDROID_HOME%
if defined ANDROID_SDK_ROOT echo [OK] ANDROID_SDK_ROOT=%ANDROID_SDK_ROOT%
echo.
echo Required in Android Studio SDK Manager:
echo   Android SDK Platform 37
 echo   Android SDK Build-Tools
 echo.
echo This project produces a universal APK and supports armeabi-v7a, arm64-v8a, x86, and x86_64.
echo Run build-apk.bat to build.
goto :done
:bad
echo.
echo Install a 64-bit JDK 17+ and reopen this command prompt.
exit /b 1
:done
endlocal
