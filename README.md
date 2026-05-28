# FSPZ-R-E
Reverse engineering Unity APK game using only AI.
# Fury Survivor v1.068 — Offline Bypass Community Package

**Package:** `com.mrxw.android.ltgames`  
**Game version:** 1.068 (Unity IL2CPP + XLua + Leiting SDK)  
**Latest patched build:** `apk/fury-survivor-v1.068-offline-bypass-v186.apk`  
**Last updated:** 2026-05-28

---

## What this folder is

This is a **complete handoff package** for the reverse-engineering community. We are trying to make **Fury Survivor** (a mobile survival game) playable **fully offline** — airplane mode, no Leiting login servers, no `game.ltgamesglobal.com` backend.

We have made significant progress bypassing resource checks, SDK gates, and boot state machines, but we are **stuck on the title splash** — the game loads Unity, passes privacy/agreement, shows the title screen, and does not reach the in-game HUD (map + joystick).

**We need community help** to get past the login/data-sync wall.

---

## Quick start (5 minutes)

### Install and test the latest build

Requirements: Android phone (arm64), USB debugging, `adb`, Java.

```powershell
adb install -r apk/fury-survivor-v1.068-offline-bypass-v186.apk
adb shell pm clear com.mrxw.android.ltgames
adb shell settings put global airplane_mode_on 1
adb shell am start -n com.mrxw.android.ltgames/com.mrxw.android.ltgames.UnityPlayerActivity
# Wait 60–120 seconds with screen ON (see testing notes below)
adb shell screencap -p /sdcard/test.png && adb pull /sdcard/test.png
```

Or use the automated script (from repo root or adjust paths):

```powershell
powershell -NoProfile -File tools/test_offline_capture.ps1 -Apk "apk\fury-survivor-v1.068-offline-bypass-v186.apk" -WaitSeconds 120 -AirplaneMode
powershell -NoProfile -File tools/device_keep_awake.ps1 -Action Enable   # run BEFORE long waits
```

### Rebuild from source

See [07_BUILD_AND_TEST.md](07_BUILD_AND_TEST.md).

---

## Documentation index

| File | Contents |
|------|----------|
| [REDDIT_POST_DRAFT.md](REDDIT_POST_DRAFT.md) | Ready-to-post text for r/ReverseEngineering |
| [01_PROJECT_OVERVIEW.md](01_PROJECT_OVERVIEW.md) | Goals, motivation, legal context |
| [02_ARCHITECTURE.md](02_ARCHITECTURE.md) | App stack, boot flow, three-server login chain |
| [03_WHAT_WORKED.md](03_WHAT_WORKED.md) | Patches and approaches that succeeded |
| [04_WHAT_FAILED.md](04_WHAT_FAILED.md) | Dead ends — do not repeat these |
| [05_CURRENT_STATUS.md](05_CURRENT_STATUS.md) | Where we are right now (v186) |
| [06_NEXT_STEPS.md](06_NEXT_STEPS.md) | Highest-value work for contributors |
| [07_BUILD_AND_TEST.md](07_BUILD_AND_TEST.md) | Build pipeline, tools, device testing |
| [08_FILE_CATALOG.md](08_FILE_CATALOG.md) | Every file in this package, categorized |
| [09_VERSION_HISTORY.md](09_VERSION_HISTORY.md) | Timeline from v1.066 through v186 |
| [10_NATIVE_PATCH_REFERENCE.md](10_NATIVE_PATCH_REFERENCE.md) | IL2CPP RVAs, caves, telemetry |

---

## Folder structure

```
REDDIT/
├── README.md                          ← you are here
├── REDDIT_POST_DRAFT.md               ← post this on Reddit
├── 01–10_*.md                         ← detailed docs
├── apk/
│   └── fury-survivor-v1.068-offline-bypass-v186.apk   (696 MB, latest build)
├── extracted/
│   ├── il2cpp_dump_1068/              Il2CppDumper output (dump.cs, script.json)
│   ├── native/                        stock + patched libil2cpp.so
│   ├── smali/                         modified Java-layer callbacks
│   ├── mock_server_json/              captured guest login payloads
│   └── stock_base_apk/                unmodified v1.068 reference APK
├── tools/                             build scripts, apktool, signer
└── evidence/                          logs, patch notes, screenshots, handoff notes
```

The full decoded APK (`apk_decoded_1068/`) lives in the parent SURVIVOR workspace (~2 GB). To reproduce it:

```powershell
java -jar tools/apktool.jar d extracted/stock_base_apk/fury-survivor-pixel-z-1-068.apk -o apk_decoded_1068
# Then apply smali from extracted/smali/ and rebuild per 07_BUILD_AND_TEST.md
```

---

## Success criterion

Launch in airplane mode → past frozen title splash → **in-game HUD with map tile + joystick**, stable for 60+ seconds, no crash.

**Baseline failure screenshot** (what we still see): SHA1 `102c7577f66dea811fd5e31cb7b336aaf471016a` (~2.87 MB PNG) — frozen title splash with black bar.

**Partial progress screenshot** (v165b, 120s): SHA1 `a64e23c8…` (~4.6 MB) — visual change but still not playable HUD.

---

## How to contribute

1. Read [04_WHAT_FAILED.md](04_WHAT_FAILED.md) first — saves weeks of repeated crashes.
2. Install v186, capture screenshot + logcat with screen awake (see [07_BUILD_AND_TEST.md](07_BUILD_AND_TEST.md)).
3. Focus on the login/data chain in [02_ARCHITECTURE.md](02_ARCHITECTURE.md) — that is the current wall.
4. Share findings: telemetry at `libil2cpp+0x3BDD4C0`, `Main.cur_state` value at inject time, any new SIGSEGV backtraces.

---

## Privacy note

Captured login logs may contain real session tokens and (in some captures) Google account data. Files in `extracted/mock_server_json/` use **sanitized guest tokens** captured from our test device. Do not share raw logcat publicly without redacting PII.
