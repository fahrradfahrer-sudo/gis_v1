#!/bin/bash
set -e

echo "=== Witt3D_GIS Setup für Google Jules (Android SDK) ==="

SDK_DIR="$HOME/Android/sdk"
mkdir -p "$SDK_DIR/cmdline-tools"

if [ ! -d "$SDK_DIR/cmdline-tools/latest" ]; then
    echo "Lade Android SDK Command-Line Tools..."
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O /tmp/cmd.zip
    unzip -q /tmp/cmd.zip -d /tmp
    mv /tmp/cmdline-tools "$SDK_DIR/cmdline-tools/latest"
    rm -rf /tmp/cmd.zip /tmp/cmdline-tools
    echo "SDK-Tools entpackt."
else
    echo "SDK-Tools bereits vorhanden."
fi

export ANDROID_SDK_ROOT="$SDK_DIR"
export ANDROID_HOME="$SDK_DIR"
export PATH="${PATH}:${SDK_DIR}/cmdline-tools/latest/bin:${SDK_DIR}/platform-tools"

echo "PATH: $PATH"

if [ ! -d "$SDK_DIR/platforms/android-35" ]; then
    echo "Installiere Platform-Tools, Android 35 und Build-Tools..."
    "$SDK_DIR/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK_DIR" "platform-tools" "platforms;android-35" "build-tools;35.0.1" < /dev/null
    echo "Installation abgeschlossen."
else
    echo "SDK-Komponenten bereits installiert."
fi

echo "Akzeptiere Lizenzen..."
yes | "$SDK_DIR/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$SDK_DIR" --licenses

echo "sdk.dir=$SDK_DIR" > local.properties

chmod +x gradlew 2>/dev/null || true

echo "Baue Witt3D_GIS..."
./gradlew assembleDebug --no-daemon

if [ -f "app/build/outputs/apk/debug/app-debug.apk" ]; then
    echo "Build erfolgreich! APK: app/build/outputs/apk/debug/app-debug.apk"
else
    echo "Build fehlgeschlagen."
    exit 1
fi

echo "=== Setup abgeschlossen! ==="
