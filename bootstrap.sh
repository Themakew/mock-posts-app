#!/bin/sh

# Function to handle errors
handle_error() {
  if [ $? -ne 0 ]; then
    echo "❌ Error: $1"
    exit 1
  fi
}

# Brew
if ! which brew > /dev/null; then
  echo "⌛️ Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  handle_error "Homebrew installation failed."
else
  echo "✅ Homebrew already installed."
fi

# SwiftLint
if ! which swiftlint > /dev/null; then
  echo "⌛️ Installing SwiftLint..."
  brew install swiftlint
  handle_error "SwiftLint installation failed."
else
  echo "✅ SwiftLint already installed."
fi

# CocoaPods
if ! which pod > /dev/null; then
  echo "⌛️ Installing CocoaPods..."
  brew install cocoapods
  handle_error "CocoaPods installation failed."
else
  echo "✅ CocoaPods already installed."
fi

# Pod Install
if [ -f "Podfile" ]; then
  echo "⌛️ Installing pods..."
  pod install
  handle_error "Failed to install pods. Please check your Podfile."
else
  echo "❌ Error: No Podfile found in the current directory."
  exit 1
fi

# Open the current directory in Xcode
if which xed > /dev/null; then
  echo "⌛️ Opening Xcode..."
  xed .
  handle_error "Failed to open Xcode."
else
  echo "❌ Error: Xcode command line tools not found. Please install them or update your PATH."
  exit 1
fi

# Finished
echo "🚀 Bootstrap Finished!"
