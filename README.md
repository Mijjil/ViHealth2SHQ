# ViHealth2SHQ

Android companion app for receiving a ViHealth Binary export and uploading it to SleepHQ.

## Compatibility

- Android 8.0+ (API 26+)
- Target Android 17 / API 37
- Designed to work across Android phone manufacturers, including Samsung Galaxy S25
- Universal APK support for ARM32, ARM64, x86, and x86_64
- Windows 11 x64 build environment

## Usage

1. Export a Binary file from ViHealth.
2. Choose **Share** and select **ViHealth2SHQ**, or open the app and choose the Binary file manually.
3. Connect to SleepHQ.
4. Select the SleepHQ team/device.
5. Upload the file.

The app uses Android's standard content URI/share APIs and does not depend on access to ViHealth's private application directory.

See `README-WINDOWS-11.md` for the Windows build instructions.


## Oximetry import correction (revision)

This revision passes the selected existing SleepHQ machine ID and the matched SleepHQ device-type ID when creating an import. It refuses to create an import if it cannot match an oximetry machine to an oximetry-like device type, rather than silently creating an untyped/CPAP-default import. The file content hash is MD5(file bytes followed by UTF-8 filename), matching the published SleepHQ API specification.

Note: the SleepHQ API does not expose a dedicated O2Ring-specific import endpoint in its public API reference. Whether ViHealth O2Ring Binary exports can be processed depends on SleepHQ's supported device types and importer. If the API's `/devices` response does not include a matching oximetry device type, this app will stop before creating an import and show a diagnostic message instead of uploading to a potentially incorrect device.


## Null-safety update

This revision hardens the post-upload status path against missing/null import IDs, empty API response bodies, and null/empty processing status fields. If the app still shows an exception after SleepHQ reports completion, capture the Android Logcat stack trace; the exact exception line is needed to identify any remaining cause.
