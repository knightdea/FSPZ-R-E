# Fury Survivor offline bypass — agent handoff

**Package:** `com.mrxw.android.ltgames` · **v1.068** · Unity IL2CPP · XLua  
**Goal:** Airplane mode → past title splash → login/HUD (map + joystick).  
**Device:** SM-S928B, Android 14.

---

## Install & test (do this first)

**Latest APK:** `ANALYZE/fury-survivor-v1.068-offline-bypass-v176.apk` (splash UI bypass; use `-SkipInstall` or pass `-Apk` in test script)

```powershell
cd C:\Users\Sky\Downloads\SURVIVOR
powershell -NoProfile -File tools\device_keep_awake.ps1 -Action Enable
adb install -r ANALYZE\fury-survivor-v1.068-offline-bypass-v157.apk
adb shell pm clear com.mrxw.android.ltgames
adb shell input keyevent KEYCODE_WAKEUP
adb shell am start -n com.mrxw.android.ltgames/com.mrxw.android.ltgames.UnityPlayerActivity
```

**Automated capture (wake every 15s):**

```powershell
powershell -NoProfile -File tools\test_offline_capture.ps1 -WaitSeconds 120 -AirplaneMode
```

**Restore phone settings when done:** `tools\device_keep_awake.ps1 -Action Restore`

---

## Critical testing notes

1. **~24 KB black PNGs = phone slept during `Start-Sleep`, not a broken APK.** User confirms no real black screen when display stays on. Always run `device_keep_awake.ps1` + USB power before waits >10s. Warn if capture <100 KB.
2. **`pm clear`** = clean install only; not the fix for tiny PNGs.
3. **Baseline awake screenshot:** SHA1 `102c7577f66dea811fd5e31cb7b336aaf471016a` (~2.87 MB) = frozen title splash + black bar. Stable, no crash.

---

## Current symptom (awake, v153–v157)

- Frozen title splash; guest SDK login at Java layer works.
- Delayed inject runs (30s/40s/60s/80s): `LoginCallBack`, `RequestCallBack`, `mainGame.OnLoginSuccessBySdk` — **no visual change** yet on stable builds.
- **Not at map/joystick.**

---

## What works (native + smali)

| Area | Detail |
|------|--------|
| Resource bypass | CheckExtract → `on_ok` @ `0x2B4DFB0`, UpdateResource skip, MoveNext cave @ `0x3BDD230` |
| Mock HTTP | `loginToServer` / `getPlayerAllDataList` caves @ `0x3BDCEE8` region |
| UI | ShowLoadInfo hide, load panel `SetActive(false)` Awake, LoadScene `isDone` NOP |
| v153+ | Force LoadScene + InitAssetBundle complete (`patchLoadSceneCompleteCbz`, `patchInitAssetBundleIsDoneCbz`) |
| v154+ | Skip InitSDK → `JumpToState(6)` @ `0x2B50580`; InitBaseCode → `JumpToState(7)` @ `0x2B506C8` |
| v135 | `openStartBtn` post-`SetActive` hook @ `0x15B3270` → `enter_btn_click`; NOP `getLoginNews` / `loginNow` early return |
| Smali v157 | SDK `loginCallBack` **defers** Unity (log only); `injectOfflineLogin` @ 30/40/60/80s; inject sends `mainGame.OnLoginSuccessBySdk` on attempt ≥3 |

**Stock lib:** `ANALYZE/libil2cpp_stock_1068.so`

---

## Do NOT repeat (crashes or black)

| Change | Result |
|--------|--------|
| `LoginCallBack` Unity message at SDK callback (~2s) | **SIGSEGV** (v151–v152) |
| `Main.Update` hook → `JumpToState(7)` | **SIGSEGV** (v155; brief ~4.6 MB frame `084882ad…` first) |
| Guest-login cave on native `LoginCallBack` (`JumpToState` + `OnLoginOk` early) | Black screen (v141–v142) |
| `openStartBtn` **entry** hook | Skips UI setup |
| Force `JumpToState(7\|8)` from `Main.Update` before assets ready | Crash @ ~`libil2cpp+0x3bcd4c0` |
| Early `injectOfflineLogin` from `LeitingCommon$7` | Fought Unity boot (removed v150) |
| `scheduleInjectAfterSdkLogin` at 2s + immediate Unity | Crash when combined with aggressive native (removed from `loginCallBack`) |
| LoadScene skip to `0x2B51108`; dismiss entire `V_CheckResourceUpdate` root | May blank surface |

---

## Main.State enum (1068 dump)

```
0 None, 1 CheckOBB, 2 CheckExtract, 3 UpdateResource, 4 InitAssetBundle,
5 InitSDK, 6 InitBaseCode, 7 StartLogin, 8 StartGame, 9 Playing
```

**Key RVAs:** `JumpToState` `0x2B50348`, `Main.Update` `0x2B50360`, `XLuaManager.OnLoginOk` `0x2B55394`, `openStartBtn` `0x15B3208`, `enter_btn_click` `0x15B3354`, `LeitingSdkCallBack.LoginCallBack` `0x17F32D8`, `loginToServerSucc` `0x15B21C4`.

**Guest token (captured):** `userId` `u8fdjo7b`, token `b4e4e3744591ec28998eedee5d39460d`

---

## Build pipeline

```powershell
cd C:\Users\Sky\Downloads\SURVIVOR
Copy-Item ANALYZE\libil2cpp_stock_1068.so apk_decoded_1068\lib\arm64-v8a\libil2cpp.so -Force
powershell -NoProfile -File tools\run_v71_1068.ps1 -BranchOnly -SkipSuccBypass -GateFlips
node tools\apply_v97_1068.js
powershell -NoProfile -File tools\build_v97_1068.ps1
```

- **Patches:** `tools/apply_v97_1068.js` (logs `v157 applied`)
- **Apk output:** edit version in `tools/build_v97_1068.ps1`
- **Decoded APK:** `apk_decoded_1068/`
- **Dumper:** `tools/Il2CppDumper/`, `il2cpp_dump_1068/dump.cs`

---

## Smali touchpoints

- `apk_decoded_1068/smali_classes4/com/mrxw/android/ltgames/LeitingCallback.smali` — guest JSON, `injectOfflineLogin`, deferred `loginCallBack`
- `LeitingCallback$InjectRunnable.smali` — delayed `UnitySendMessage`
- `UnityPlayerActivity.smali` — `injectOfflineLogin` onCreate; **no** inject in `LeitingCommon$7` (removed v150)

---

## Version history (recent)

| Build | Notes |
|-------|--------|
| v140/v150 | Stable splash `102c7577…` |
| v149 | Black PNGs — likely sleep + early inject; not sole root cause |
| v151 | ~4.6 MB frame then SIGSEGV (guest cave + aggressive native) |
| v155 | Deferred SDK login + Main.Update jump → crash |
| v156 | v154 native + deferred smali, stable splash |
| **v157** | v156 + late inject + `mainGame.OnLoginSuccessBySdk` |
| **v158** | Guarded `SDK_CallBack.LoginCallBack` bridge @ `0x17F36FC` → mock `loginToServer` when `xluaMain.cur_state>=7`; telemetry `lib+0x3BDD4C0` |
| **v159** | v158 + stock `updateAllPlayerData` on guard miss; bridge marker `0x4249` @ telem+0xC |
| **v160** | Restore stock `OnLoginSuccessBySdk` (remove direct `openStartBtn` B); bridge `cur_state>=6`; `loginNow` inject; `JumpToState` telemetry @ telem+0x10 |
| **v161** | v160 + `Main.Update` hook with `JumpToState(7)` → visual change, **SIGSEGV** ~30s |
| **v163** | Single inject @ 75s (attempt 4 only) |
| **v164** | Force `cur_state` writes (no `JumpToState`); stable splash, no crash |
| **v165** | v164 + `Main.Update` stuck hook writes state 7 in-place (no `JumpToState` BL) |

**2026-05-28 session:** v165b 120s capture **4.6 MB** SHA1 `a64e23c8…` (≠ baseline). **Do not** call `JumpToState` from `Main.Update` hook (crashes). Init skip caves use direct `cur_state` writes. Inject: one shot @ 75s only (`0x12498` ms).

---

## Next agent: highest-value work

1. **Confirm telemetry** after 60s inject: `tools/dump_offline_telemetry.ps1` (root) or Frida read `libil2cpp+0x3BDD4C0` — `[0]`=last_state, `[8]`=bridge_hits, `[c]`=0x4249 if bridge fired.
2. If `last_state` &lt; 7 at inject: fix boot (`JumpToState` skips) before login bridge; do **not** lower guard below 6 without testing.
3. If `last_state` ≥ 7 but no bridge: verify `mainGame` non-null; trace mocked `loginToServer` invoke (`x0`=mainGame).
4. If bridge fires, no UI: chain `loginToServerSucc` → `openStartBtn` → `enter_btn_click` hook.

**Success criterion:** Stable screenshot **≠** `102c7577…` for 60s+, no SIGSEGV, game foreground.

---

## Transcript

Full session: `agent-transcripts/3de33de0-33ee-4bec-bb10-506e4e059496/3de33de0-33ee-4bec-bb10-506e4e059496.jsonl`
