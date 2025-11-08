#!/bin/bash
set -e

echo "=== Witt3D_GIS Setup für Google Jules (Android SDK) ==="

SDK_DIR="$HOME/Android/sdk"
mkdir -p "$SDK_DIR/cmdline-tools"

if [ ! -d "$SDK_DIR/cmdline-tools/latest" ]; then
    echo "Lade Android SDK..."
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O /tmp/cmd.zip
    unzip -q /tmp/cmd.zip -d /tmp
    mv /tmp/cmdline-tools "$SDK_DIR/cmdline-tools/latest"
    rm -rf /tmp/cmd.zip /tmp/cmdline-tools
fi

export ANDROID_SDK_ROOT="$SDK_DIR"
export ANDROID_HOME="$SDK_DIR"
export PATH="${PATH}:${SDK_DIR}/cmdline-tools/latest/bin:${SDK_DIR}/platform-tools"

if [ ! -d "$SDK_DIR/platforms/android-35" ]; then
    "$SDK_DIR/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK_DIR" "platform-tools" "platforms;android-35" "build-tools;35.0.1" < /dev/null
fi

yes | "$SDK_DIR/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK_DIR" --licenses

echo "sdk.dir=$SDK_DIR" > local.properties

# Rechte setzen
chmod +x gradlew 2>/dev/null || true
chmod +x gradle/bin/gradle 2>/dev/null || true

echo "Baue Witt3D_GIS..."
./gradlew assembleDebug --no-daemon

if [ -f "app/build/outputs/apk/debug/app-debug.apk" ]; then
    echo "Build erfolgreich! APK: app/build/outputs/apk/debug/app-debug.apk"
else
    echo "Build fehlgeschlagen."
    exit 1
fi

echo "=== Setup abgeschlossen! ==="