#!/usr/bin/env bash
set -e
APP_HOME="$(cd "`dirname "$0"`" && pwd)"
exec "$APP_HOME/gradle/bin/gradle" "$@"