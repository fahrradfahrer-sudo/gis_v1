#!/bin/bash
DIR=$(dirname "$0")
exec "$DIR/gradle/bin/gradle" "$@"