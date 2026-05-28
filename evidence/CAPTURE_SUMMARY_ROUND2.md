# Stock v1.068 capture — round 2 (2026-05-27)

Log: stock_login_round2_20260527_174827.log (~7.2 MB)

## Session map (matches your three steps)

| Step | Time (approx) | What log shows |
|------|----------------|----------------|
| 1 — Guest play and close | 17:49:19 → 17:50:14 | sdkCheckLogin → Unity sdkId=u8fdjo7b → in-game → closed |
| 2 — Same guest, logout | 17:50:18 → 17:50:27 | sdkCheckLogin → same loginCallBack → AuthService/logout |
| 3 — Google + bind | 17:50:32 → 17:53:50 | checkChannelBindStatus → googleplayVerifySession → bound account → logout → relaunch |

## Guest account (unchanged from round 1)

- userId: u8fdjo7b, userName: qk8ih8n5
- token: b4e4e3744591ec28998eedee5d39460d, timestamp: 1779918263371
- isGuest: 1, bind: empty
- File: round2_loginCallBack_1.json

Note: No guestLogin.do in this log — only sdkCheckLogin (returning guest from earlier install).

## Google-bound account (new)

- userId: ycna9n4k, userName: drftqg82
- token: fb16dc7f34e68ea4c99f838673189244, timestamp: 1779918819887
- isGuest: 0, bind: 1
- File: captured_loginCallBack_google_bound.json

## Still not in logcat

- game.ltgamesglobal.com / account.login
- getPlayerAllDataList

## Privacy

Raw log contains Google JWT and email — do not share publicly.
