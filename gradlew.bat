@echo off
rem Windows-native Gradle bootstrap for ViHealth2SHQ.
rem This intentionally invokes gradle.bat, never the Unix bin\gradle launcher.
call "%~dp0build-apk.bat" %*
exit /b %errorlevel%
