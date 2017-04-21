#!/bin/sh

# Default editor
export EDITOR="vim"

# Binary folder
export BIN="$HOME/bin"

# Go
export GOPATH="$HOME/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

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
