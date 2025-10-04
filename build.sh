#!/bin/bash
# Build directory
buildFolder="build"

# Recreate build directory
[ -d "$buildFolder" ] && rm -rf "$buildFolder"
mkdir "$buildFolder"

# Install dependencies
npm install

# Build the application (assuming it outputs to dist/)
npm run rebuild

# Copy package files
cp package*.json "$buildFolder/"

# Copy Firebase configs if present
if ls firebase*.json 1> /dev/null 2>&1; then
  cp firebase*.json "$buildFolder/"
fi

# Copy PM2 config
cp pm2.config.js "$buildFolder/"

# Copy dist (compiled app)
cp -r dist "$buildFolder/dist"

# Copy public folder
cp -r public "$buildFolder/public"

# Copy migration script
cp migrate.sh "$buildFolder/"

# Make logs directory
mkdir "$buildFolder/logs"

# Cleanup local build artifacts
rm -rf dist release
