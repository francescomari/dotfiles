#!/bin/sh

# Default locale
export LC_ALL="en_US"

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Go
export PATH="$PATH:$HOME/go/bin"

# Generic executables
export PATH="$BIN:$PATH"

# Switch JDKs dinamically
function jdk() {
  if [ $# -ne 0 ]; then
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
    export PATH=$JAVA_HOME/bin:$PATH
  fi
}

# Maven aliases
alias mci="mvn clean install -DskipTests"
alias mcti="mvn clean install"
