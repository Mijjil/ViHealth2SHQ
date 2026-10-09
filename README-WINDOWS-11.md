# ViHealth2SHQ — Windows 11 x64 build

## Android target

- `compileSdk`: 37
- `targetSdk`: 37
- `minSdk`: 26 (Android 8.0)
- Universal APK with ABI support for `armeabi-v7a`, `arm64-v8a`, `x86`, and `x86_64`.
- The application itself contains no native code, so it is not tied to Samsung or any particular CPU architecture.

This includes the Samsung Galaxy S25 / Android 17 use case while remaining installable on a broad range of Android phones running Android 8.0 or newer.

## Windows requirements

1. 64-bit Windows 11.
2. 64-bit JDK 17 or newer compatible with the selected Android Gradle Plugin.
3. Android Studio with Android SDK Platform 37 and Android SDK Build-Tools installed.
4. Internet access for the first Gradle bootstrap unless Gradle 8.13 is already cached.

## Build

Run:

```bat
setup-windows11.bat
build-apk.bat
```

or:

```bat
gradlew.bat assembleDebug
```

The project deliberately uses a **Windows-native Gradle bootstrap**. It invokes `gradle.bat`; it never attempts to execute Gradle's Unix `bin\gradle` shell script. This avoids the Windows `CreateProcess error=193` problem.

The official Gradle 8.13 binary distribution is downloaded automatically into `.gradle-local` on the first build.

## APK output

The universal APK is under:

`app\build\outputs\apk\universal\debug\app-universal-debug.apk`

Architecture-specific APKs, when generated, are under the corresponding ABI directories.
