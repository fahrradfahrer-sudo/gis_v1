#!/bin/bash
set -e

echo \"=== Witt3D_GIS Setup für Google Jules ===\"

SDK_DIR=\"\C:\Users\Matthias Witt/Android/sdk\"
mkdir -p \"\/cmdline-tools\"

echo \"Lade Android SDK...\"
wget -q https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O /tmp/cmd.zip
unzip -q /tmp/cmd.zip -d /tmp
mv /tmp/cmdline-tools \"\/cmdline-tools/latest\"
rm -rf /tmp/cmd.zip /tmp/cmdline-tools

export ANDROID_SDK_ROOT=\"\\"
export ANDROID_HOME=\"\\"
export PATH=\"\:\/cmdline-tools/latest/bin:\/platform-tools\"

echo \"Installiere SDK-Komponenten...\"
\"\/cmdline-tools/latest/bin/sdkmanager\" --sdk_root=\"\\" \"platform-tools\" \"platforms;android-35\" \"build-tools;35.0.1\" < /dev/null

echo \"Akzeptiere Lizenzen...\"
yes | \"\/cmdline-tools/latest/bin/sdkmanager\" --sdk_root=\"\\" --licenses

echo \"sdk.dir=\\" > local.properties

chmod +x gradlew 2>/dev/null || true

echo \"Baue App...\"
./gradlew assembleDebug --no-daemon

echo \"Fertig! APK: app/build/outputs/apk/debug/app-debug.apk\"
