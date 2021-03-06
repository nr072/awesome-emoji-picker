#!/bin/sh
#
# Makes a release ZIP of the add-on.
#
# IMPORTANT: This is only useful for building release versions of the add-on.
# For development, please rather follow the guidance in the contributing doc.
#

EXTENSION_NAME="awesome-emoji-picker@rugk.github.io"

mkdir -p "build"

# license should be in add-on
mv LICENSE.md src/LICENSE.md

# make sure we are using the stable manifest
# as the dev edition manifest.json allows mocha.css and mocha.js in the CSP
cp "./scripts/manifests/firefox.json" "./src/manifest.json" || exit

# create zip
cd src || exit
zip -r -FS "../build/$EXTENSION_NAME.xpi" ./* -x "tests/*" -x "**/tests/*" \
    -x "docs/*" -x "**/docs/*" \
    -x "examples/*" -x "**/examples/*" -x "**/*.example" \
    -x "**/README.md" -x "**/CONTRIBUTING.md" -x "**/manifest.json" \
    -x "**/.git" -x "**/.gitignore" -x "**/.gitmodules"  -x "**/.gitkeep" \
    -x "**/.eslintrc" \
    -x "**/package.json" -x "**/package-lock.json" -x "**/webpack.config.js" \
    -x "popup/lib/emoji-mart-embed/src.js" \
    -x "**/.editorconfig"

# revert changes
mv LICENSE.md ../LICENSE.md
cp "../scripts/manifests/dev.json" "../src/manifest.json"

cd ..
