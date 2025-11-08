#!/bin/bash
# Gradle start script
# Generated for Google Jules compatibility

# Resolve links ($0 may be a softlink)
PRG="$0"
while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '.*/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

DIR=`dirname "$PRG"`

exec "$DIR/gradle/bin/gradle" "$@"
