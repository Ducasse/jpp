#!/usr/bin/env bash

# URLs
IMAGE_URL="https://get.pharo.org/70-minimal"
VM_URL="https://get.pharo.org/vm70"
SOURCES_URL="http://files.pharo.org/sources/PharoV60.sources"
TONEL_URL="github://pharo-vcs/tonel"
JPP_REPOSITORY_URL="github://juliendelplanque/jpp/src"
JPP_SCRIPT_URL="https://raw.githubusercontent.com/juliendelplanque/jpp/master/scripts/jpp"
# Baselines
TONEL_BASELINE="BaselineOfTonel"
JPP_BASELINE="BaselineOfJSONPreprocessor"
# Commands
METACELLO_CMD="./pharo Pharo.image metacello"

################################################################################

# Create directory and enter it.
mkdir "jpp"
cd "jpp"

# Download image, vm and sources files.
curl "$IMAGE_URL" | bash
curl "$VM_URL" | bash
wget "$SOURCES_URL"

# Install Tonel (required because jpp is in Tonel format).
eval "$METACELLO_CMD install $TONEL_URL $TONEL_BASELINE"
# Install jpp.
eval "$METACELLO_CMD install $JPP_REPOSITORY_URL $JPP_BASELINE"

# Clean garbage.
rm -rf github-cache
rm -rf pharo-local
rm -rf image.*
rm -f pharo-ui
rm -f pharo

# Download jpp script
wget "JPP_SCRIPT_URL"

# Go back to original directory.
cd ..
