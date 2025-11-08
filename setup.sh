#!/usr/bin/env bash
set -e

echo "=== Witt3D_GIS Build (Gradle 8.7-all + AGP 8.5) ==="

echo "sdk.dir=$HOME/Android/sdk" > local.properties

chmod +x gradlew

echo "Lade Gradle 8.7..."
./gradlew --version

echo "Baue APK..."
./gradlew assembleDebug --no-daemon

if [ -f "app/build/outputs/apk/debug/app-debug.apk" ]; then
    echo "APK erfolgreich gebaut!"
else
    echo "Build fehlgeschlagen."
    exit 1
fi