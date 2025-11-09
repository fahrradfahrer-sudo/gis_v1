#!/usr/bin/env bash
set -e
APP_HOME="$(cd "`dirname "$0"`" && pwd)"
exec java -jar "$APP_HOME/gradle/wrapper/gradle-wrapper.jar" "$@"