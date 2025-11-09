#!/bin/bash
set -e

APP_HOME="$$ (cd " $$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec java -jar "$$ APP_HOME/gradle/wrapper/gradle-wrapper.jar" " $$@"
