#!/bin/sh

echo "Decoding GoogleService-Info.plist from environment variable..."
echo "$GOOGLE_INFO_PLIST" | base64 --decode > ../GitHubSearch-2/SupportingFiles/GoogleService-Info.plist

echo "Stage: PRE-Xcode Build is DONE .... "
