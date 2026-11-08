# LitmatchAdControl 0.1.0

A Theos/Logos tweak **source scaffold** targeted at Litmatch `com.litatom.Litmatch`.

## What this build does

- Loads only into the Litmatch bundle (via `LitmatchAdControl.plist`).
- Logs the main bundle identifier.
- Scans currently loaded Mach-O images for names associated with AppLovin, Pangle, Vungle, Moloco, InMobi, Fyber, Google Mobile Ads, and AdsGlobal.
- Logs matching image paths so a later, evidence-based compatibility analysis can distinguish SDKs present in the IPA from SDKs actually loaded at runtime.

## What this build does NOT do

- It does not block, hide, or disable advertisements.
- It does not modify Litmatch networking, login, chat, voice calls, or account state.
- It does not unlock Premium, spoof purchases, or bypass server-side entitlement checks.
- It is source code only; no compiled iOS `.dylib` is included.

## Build requirements

Build on macOS or a supported Theos environment with an iOS SDK and a compatible arm64 toolchain. This workspace does not include Apple's iOS SDK or Theos, so it cannot produce a valid device `.dylib` here.

```sh
# Install/configure Theos first, then:
make clean package
```

Theos normally places the compiled tweak under `.theos/obj/...`. The generated package can also be inspected to obtain the `.dylib` and its matching filter plist. For LiveContainer, use its own current TweakLoader import workflow and follow its signing requirements; do not install the `.deb` as if the device were jailbroken.

## Next diagnostic step

Launch Litmatch through LiveContainer with TweakLoader enabled, then collect the device/app logs containing the `[LitmatchAdControl]` prefix. A loaded-image scan is diagnostic only: some SDKs load dynamically or use renamed binaries, so absence from this scan does not prove an SDK is unused.
