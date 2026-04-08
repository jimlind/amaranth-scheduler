#! /bin/bash
(return 0 2>/dev/null) || {
  echo "Failure. Don't execute this script directly. Run it with source."
  exit 1
}

export JAVA_HOME=/opt/homebrew/opt/openjdk@21