# Build from iPhone using GitHub Actions

This repository contains a **diagnostic-only** Theos tweak scaffold. It logs the Litmatch bundle identifier and names of currently loaded images that match known advertising SDK names. It does not block ads, alter network traffic, unlock Premium, or spoof purchases.

## Build

1. Create a new GitHub repository. Keep it private if you prefer.
2. Upload the complete contents of this folder to the repository root, including the hidden `.github/workflows/build.yml` file.
3. Open the repository's **Actions** tab and enable Actions if GitHub asks.
4. Select **Build LitmatchAdControl**, choose **Run workflow**, and run it on `main`.
5. Open the completed workflow run. Under **Artifacts**, download `LitmatchAdControl-ARM64-diagnostic`.
6. Extract the ZIP. It should contain `LitmatchAdControl.dylib` and `LitmatchAdControl.plist`.

The workflow uses GitHub's macOS runner and Xcode's iOS SDK, installs Theos, and compiles with `ARCHS := arm64` from the Makefile. The artifact is not guaranteed to load in every LiveContainer/TweakLoader version; test only with a copy of the app and keep the original IPA unchanged.

Never put your GitHub password, personal access token, Apple ID password, or signing certificates in chat or in the repository. No secrets are needed for this workflow.
