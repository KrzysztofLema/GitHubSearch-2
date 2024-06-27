#!/bin/sh

echo "Decoding GoogleService-Info.plist from environment variable..."
echo "$GOOGLE_INFO_PLIST" | base64 --decode > ../GitHubSearch-2/SupportingFiles/GoogleService-Info.plist
echo "$DEV_CONFIGURATION" | base64 --decode > ../GitHubSearch-2/SupportingFiles/DevConfiguration.xcconfig

echo "Stage: PRE-Xcode Build is DONE .... "
