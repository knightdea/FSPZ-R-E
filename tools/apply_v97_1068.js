const fs = require("fs");
const path = require("path");
const OUT = path.join(__dirname, "..", "apk_decoded_1068", "lib", "arm64-v8a", "libil2cpp.so");
const STOCK = path.join(__dirname, "..", "ANALYZE", "libil2cpp_stock_1068.so");
const AGGRESSIVE = process.argv.includes("--aggressive");
const MINIMAL_BOOT = process.argv.includes("--minimal-boot");
const RESOURCE_ONLY = process.argv.includes("--resource-only");
const SHOWLOAD_ONLY = process.argv.includes("--showload-only");
const FULL = AGGRESSIVE || (!MINIMAL_BOOT && !RESOURCE_ONLY && !SHOWLOAD_ONLY);
const A = {
  stringNew: 0xe8bf90,
  toObject: 0x2972f30,
  invoke: 0x2bf9c10,
  cave: 0x3bdcee8,
  jsonLogin: 0x3bdcf88,
  stubPlayer: 0x3bdd000,
  jsonPlayer: 0x3bdd0a0,
  patchLogin: 0x1781930,
  patchPlayer: 0x1782068,
  openStartBtn: 0x15b3208,
  loginToServerSucc: 0x15b21c4,
  actionVoidInvoke: 0x2076e5c,
  caveMoveNextOk: 0x3bdd230,
  caveErrInvokeOk: 0x3bdd270,
  patchCheckExtractSkipNet: 0x2b4df94,
  // Invoke on_ok (x19); 0x2B4DFA4 skips Action.Invoke and leaves Connecting stuck.
  checkExtractSuccessPath: 0x2b4dfb0,
  // Zip/extract path: stock b +5 skipped Action.Invoke (relied on broken MoveNext).
  patchCheckExtractCoroutineDone: 0x2b4dfa8,
  awakeLoadPanelArg: 0x16fdce0,
  awakeLoadPanelCall: 0x16fdcec,
  patchUpdateSkipNet: 0x2b4ebb0,
  updateSuccessPath: 0x2b4eb68,
  patchMoveNext: 0x2b4fae4,
  patchOnCheckResErr: 0x2b4fa34,
  patchOnLoginSdkCbz: 0x15b1dbc,
  patchOnLoginSuccessDirect: 0x15b1d78,
  patchOpenStartBtnHook: 0x15b3270,
  openStartBtnReturn: 0x15b3260,
  caveOpenStartAutoEnter: 0x3bdd420,
  enterBtnClick: 0x15b3354,
  updateShowLogo: 0x15b1038,
  patchShowLoadInfoEntry: 0x16fdff4,
  patchShowLoadInfoFmt: 0x16fe0bc,
  caveUpdateShowLogoBypass: 0x3bdd5e0,
  nopGetLoginNews: 0x15b0c34,
  nopLoginNowEarlyReturn: 0x15b1178,
  patchLoadSceneCompleteCbz: 0x2b51024,
  loadSceneCompleteTarget: 0x2b51124,
  patchInitAssetBundleIsDoneCbz: 0x2b50e04,
  initAssetBundleDoneTarget: 0x2b50e44,
  getGameObject: 0x25fb77c,
  refVCheckInstance: 0x16fdabc,
  patchShowLoadHideDismiss: 0x16fe084,
  showLoadHideDismissResume: 0x16fe088,
  caveDismissLoadRoot: 0x3bdd470,
  caveDismissLoadThis: 0x3bdd640,
  patchInitSdkBranch: 0x2b50580,
  initSdkBranchResume: 0x2b5058c,
  patchInitBaseCodeBranch: 0x2b506c8,
  initBaseCodeBranchResume: 0x2b506cc,
  // InitBaseCode case: gates that skip InitLuaEnv when offline flag is false.
  nopInitBaseLuaGate: 0x2b505b4,
  nopInitBaseLuaNull: 0x2b505d0,
  caveSkipInitSdk: 0x3bdd4a0,
  caveSkipInitBase: 0x3bdd4b0,
  refXluaManagerTi: 0x2b5517c,
  xluaOnLoginOk: 0x2b55394,
  patchLoginCallBackPreServer: 0x17f36fc,
  loginCallBackPreServerResume: 0x17f3700,
  // Skip account.login inside SDK_CallBack.LoginCallBack until Unity inject (resource bypass runs too early).
  nopLoginCallBackServer: 0x17f36fc,
  updateAllPlayerData: 0x1782808,
  caveGuestLoginTelemetry: 0x3bdd4c0,
  caveLoginCallBackBridge: 0x3bdd4e0,
  caveJumpToStateLog: 0x3bdd560,
  caveAfterResourceBoost: 0x3bdd580,
  caveOnLoginSuccessFast: 0x3bdd5c0,
  patchJumpToState: 0x2b50348,
  nopShowLoadInfo: [
    0x16ffc88, 0x16fff7c, 0x264cd44, 0x264ce04, 0x264d22c,
    0x2b4f910, 0x2b4f9f0, 0x2b4fad8, 0x2b500cc,
  ],
  patchB80FastPath: 0x2b50a28,
  b80FastPathTarget: 0x2b50a2c,
  patchShowLoadHide: 0x16fe008,
  showLoadHideTarget: 0x16fe084,
  patchShowLoadAddRet: 0x16fe1b0,
  showLoadAddRetTarget: 0x16fe1f4,
  // LoadScene MoveNext: treat AsyncOperation.isDone as true (offline hang).
  patchLoadSceneIsDoneCbz: 0x2b50ed8,
  nopShowLoadAddInLoadScene: 0x2b510bc,
  patchB82FastPath: 0x2b50cfc,
  b82FastPathTarget: 0x2b50d00,
  patchHideGameStartBlack: 0x15b10a4,
  hideGameStartBlackTarget: 0x15b10b4,
  // MainGame GameStart: skip sea-policy gate -> updateShowLogo + loginNow.
  patchGameStartSkipPolicy: 0x15b0b88,
  gameStartLoginPath: 0x15b0b9c,
  nopHideDelayGate: 0x15b1370,
  refMyGameGolbalTi: 0x15b0b34,
  patchGameStartSplash: 0x15b079c,
  gameStartSplashResume: 0x15b07a0,
  caveGameStartSplash: 0x3bdd2a8,
  patchMainUpdateBoot: 0x2b50398,
  caveMainUpdateBoot: 0x3bdd380,
  initLuaEnv: 0x2b50630,
  nopStartLoginGateA: 0x2b50774,
  nopStartLoginGateB: 0x2b5077c,
  nopInitLuaEnvGateA: 0x2b506dc,
  nopInitLuaEnvGateB: 0x2b506e4,
  setActive: 0x2604ab4,
  nopLoginNowInit: 0x15b1128,
  nopLoginNowEntering: 0x15b1170,
  nopHideBlackNull: 0x15b10b8,
  nopEnterBtnGate: 0x15b3390,
  nopOpenStartInit: 0x15b3220,
  nopOpenStartSeaPolicy: 0x15b32d4,
  patchMainUpdateEntry: 0x2b50398,
  mainUpdateSwitchResume: 0x2b503a0,
  jumpToState: 0x2b50348,
  caveMainSafeJump: 0x3bdd380,
  caveMainSafeJumpState: 0x3bdd3f0, // [0]=frames,[4]=didJump,[8]=lastState,[12]=stuck
  loginNow: 0x15b110c,
};
// Captured guest session (stock online, 2026-05-27)
const GUEST_TOKEN = "b4e4e3744591ec28998eedee5d39460d";
const GUEST_SID = "u8fdjo7b";
const LOGIN = JSON.stringify({
  status: 1,
  code: 0,
  msg: "ok",
  api: "account.login",
  data: {
    status: 1,
    session_id: GUEST_SID,
    access_token: GUEST_TOKEN,
    zone: 1,
    versionState: "0",
    isOpenRank: false,
  },
});
const PLAYER = JSON.stringify({
  status: 1,
  code: 0,
  msg: "ok",
  api: "getPlayerAllDataList",
  data: {
    list: [
      {
        level: "1",
        displayName: "qk8ih8n5",
        updatedat: 1779918263371,
        byhand: 0,
      },
    ],
  },
});
const u32 = (x) => Number(BigInt.asUintN(32, BigInt(x)));
const MASK26 = (1n << 26n) - 1n;
function encB(pc, t) {
  let imm = (BigInt(t) - BigInt(pc)) / 4n;
  while (imm < 0n) imm += 1n << 26n;
  return u32(0x14000000n | (imm & MASK26));
}
function encBl(pc, t) {
  let imm = (BigInt(t) - BigInt(pc)) / 4n;
  while (imm < 0n) imm += 1n << 26n;
  return u32(0x94000000n | (imm & MASK26));
}
function encAdrp(rd, pc, t) {
  const page = BigInt(t) & ~0xfffn;
  const pcPage = BigInt(pc) & ~0xfffn;
  let imm = Number((page - pcPage) / 4096n);
  if (imm < 0) imm = (imm + 0x200000) & 0x1fffff;
  imm &= 0x1fffff;
  return u32(0x90000000 | ((imm & 3) << 29) | (((imm >> 2) & 0x7ffff) << 5) | rd);
}
function encAdd(rd, rn, imm) {
  return u32(0x91000000 | ((imm & 0xfff) << 10) | (rn << 5) | rd);
}
function encMovW(rd, imm) {
  return u32(0x52800000 | ((imm & 0xffff) << 5) | rd);
}
function encLdr64(rt, rn, off) {
  return u32(0xf9400000 | (((off / 8) & 0xfff) << 10) | (rn << 5) | rt);
}
function encStrb(rt, rn, off) {
  return u32(0x39000000 | ((off & 0xfff) << 10) | (rn << 5) | rt);
}
function encStr64(rt, rn, off) {
  return u32(0xf9000000 | (((off / 8) & 0xfff) << 10) | (rn << 5) | rt);
}
function encStr32(rt, rn, off) {
  return u32(0xb9000000 | (((off / 4) & 0xfff) << 10) | (rn << 5) | rt);
}
function encLdr32(rt, rn, off) {
  return u32(0xb9400000 | (((off / 4) & 0xfff) << 10) | (rn << 5) | rt);
}
function encCbz(rt, pc, target) {
  const imm = (target - pc) / 4;
  return u32(0xb4000000 | ((imm & 0x7ffff) << 5) | rt);
}
function encCbnz(rt, pc, target) {
  const imm = (target - pc) / 4;
  return u32(0x35000000 | ((imm & 0x7ffff) << 5) | rt);
}
function adrpPage(refPc, insn) {
  const immlo = (insn >>> 29) & 3;
  const immhi = (insn >>> 5) & 0x7ffff;
  let imm = (immhi << 2) | immlo;
  if (imm & 0x100000) imm -= 0x200000;
  return Number((BigInt(refPc) & ~0xfffn) + BigInt(imm) * 4096n);
}
function buildUpdateShowLogoBypassCave(stubPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xaa0003f3); // mov x19, x0 (MainGame_1)
  for (const off of [0x18, 0x28, 0x30, 0x50]) {
    push(encLdr64(0, 19, off));
    const cbzHide = w.length;
    push(0xb4000000);
    push(encMovW(1, 0));
    push(encBl(pc, A.setActive));
    w[cbzHide] = encCbz(0, stubPc + cbzHide * 4, pc);
  }
  push(encLdr64(0, 19, 0x58)); // enter_btn
  const cbzEnter = w.length;
  push(0xb4000000);
  push(encMovW(1, 1));
  push(encBl(pc, A.setActive));
  w[cbzEnter] = encCbz(0, stubPc + cbzEnter * 4, pc);
  push(0xd65f03c0);
  return w;
}
function buildGameStartSplashCave(stubPc, golbalPage, golbalLdrOff) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  // x19 = MainGame_1 this (set at 0x15B0784 before hook).
  push(encAdrp(20, pc, golbalPage));
  push(encLdr64(20, 20, golbalLdrOff));
  push(encLdr64(8, 20, 0xb8));
  push(encMovW(9, 1));
  push(encStrb(9, 8, 0xa1)); // is_hide_window_delay_over
  push(encStr64(19, 8, 0x8)); // mainGame = this
  push(encLdr64(0, 8, 0x108)); // static gameStartBlack
  const cbzBlack = w.length;
  push(0xb4000000);
  push(encMovW(1, 0));
  push(encBl(pc, A.setActive));
  w[cbzBlack] = encCbz(0, stubPc + cbzBlack * 4, pc);
  push(0xaa1303e0);
  push(encBl(pc, A.updateShowLogo)); // hide logos + show enter_btn
  push(encBl(pc, A.caveDismissLoadRoot));
  push(encB(pc, A.gameStartSplashResume));
  return w;
}
function buildOnLoginSuccessFastCave(stubPc, resumePc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xaa0003f3); // mov x19, x0 (MainGame_1)
  push(encBl(pc, A.openStartBtn));
  push(encBl(pc, A.loginNow));
  push(encB(pc, resumePc));
  return w;
}
function buildMainUpdateBootCave(stubPc, golbalPage, golbalLdrOff, telemAddr) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf4ff4); // stp x20, x19, [sp,#-16]!
  push(encLdr32(8, 19, 0x18));
  push(encLdr32(9, 19, 0x1c));
  push(encAdrp(10, pc, telemAddr & ~0xfff));
  push(encAdd(10, 10, telemAddr & 0xfff));
  push(encStr32(8, 10, 0x0));
  push(encStr32(9, 10, 0x4));
  push(encLdr32(11, 10, 0x20));
  push(0x1100056b);
  push(encStr32(11, 10, 0x20));
  push(encLdr32(8, 19, 0x18));
  push(0x51000508); // subs w8, w8, #1 (stock switch)
  push(0xa8c14ff4); // ldp x20, x19, [sp], #16
  push(encB(pc, A.mainUpdateSwitchResume));
  return w;
}
function encBCond(cond, pc, target) {
  const imm = Number((BigInt(target) - BigInt(pc)) / 4n);
  return u32(0x54000000 | ((imm & 0x7ffff) << 5) | cond);
}
// Main.Update assist: in-place state bump (no JumpToState BL), hide load UI at StartLogin+.
function buildMainUpdateAssistCave(stubPc, stateAddr, telemAddr, dismissPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf4ff4); // stp x20, x19, [sp,#-16]!
  push(0xa9017bfd); // stp x29, x30, [sp,#16]
  push(0xaa0003f4); // mov x20, x0 (Main)
  push(encAdrp(9, pc, stateAddr & ~0xfff));
  push(encAdd(9, 9, stateAddr & 0xfff));
  push(encLdr32(10, 9, 0x0));
  push(0x1100054a);
  push(encStr32(10, 9, 0x0));
  push(encLdr32(8, 20, 0x18));
  push(encLdr32(11, 20, 0x1c));
  push(encAdrp(13, pc, telemAddr & ~0xfff));
  push(encAdd(13, 13, telemAddr & 0xfff));
  push(encStr32(8, 13, 0x0));
  push(encStr32(11, 13, 0x4));
  push(encLdr32(12, 9, 0x8)); // lastState
  push(encLdr32(14, 9, 0xc)); // stuckFrames
  push(0x6b08011f); // cmp w8, w12
  const eqStuckIdx = w.length;
  push(0x54000001); // b.ne reset_stuck
  push(0x110005ce); // add w14, w14, #1
  const afterStuckInc = pc;
  w[eqStuckIdx] = encBCond(0x1, stubPc + eqStuckIdx * 4, afterStuckInc);
  push(encMovW(14, 0));
  push(encStr32(8, 9, 0x8));
  push(encStr32(14, 9, 0xc));
  push(0x7100b45f); // cmp w14, #45 (~0.75s stuck in resource states)
  const bltStairIdx = w.length;
  push(0x54000000); // b.lt skip_stair
  push(0x7100095f); // cmp w8, #2
  const blt2Idx = w.length;
  push(0x54000000);
  push(0x7100157f); // cmp w8, #5
  const bgt5Idx = w.length;
  push(0x54000000);
  push(0x11000508); // add w8, w8, #1
  push(encStr32(8, 20, 0x18));
  push(encMovW(11, 0));
  push(encStr32(11, 20, 0x1c));
  push(encMovW(14, 0));
  push(encStr32(14, 9, 0xc));
  const skipStairPc = pc;
  w[bltStairIdx] = encBCond(0xb, stubPc + bltStairIdx * 4, skipStairPc);
  w[blt2Idx] = encBCond(0xb, stubPc + blt2Idx * 4, skipStairPc);
  w[bgt5Idx] = encBCond(0xa, stubPc + bgt5Idx * 4, skipStairPc);
  push(encLdr32(10, 9, 0x0)); // frames
  push(encLdr32(12, 9, 0x4)); // didJump
  const didJumpIdx = w.length;
  push(0x35000000); // cbnz didJump, skip_force7
  push(0x7101e01f); // cmp w10, #120 (~2s)
  const blt120Idx = w.length;
  push(0x54000000);
  push(encLdr32(8, 20, 0x18));
  push(0x7100181f); // cmp w8, #6 InitBaseCode
  const ne6Idx = w.length;
  push(0x54000001);
  push(encMovW(8, 7));
  push(encStr32(8, 20, 0x18));
  push(encMovW(11, 0));
  push(encStr32(11, 20, 0x1c));
  push(encMovW(12, 1));
  push(encStr32(12, 9, 0x4));
  push(encBl(pc, dismissPc));
  const skipForce7Pc = pc;
  w[didJumpIdx] = encCbnz(12, stubPc + didJumpIdx * 4, skipForce7Pc);
  w[blt120Idx] = encBCond(0xb, stubPc + blt120Idx * 4, skipForce7Pc);
  w[ne6Idx] = encBCond(0x1, stubPc + ne6Idx * 4, skipForce7Pc);
  push(encLdr32(8, 20, 0x18));
  push(encLdr32(15, 9, 0x10)); // dismissDone
  const dismissDoneIdx = w.length;
  push(0x35000000);
  push(0x71001c1f); // cmp w8, #7
  const blt7Idx = w.length;
  push(0x54000000);
  push(encBl(pc, dismissPc));
  push(encMovW(15, 1));
  push(encStr32(15, 9, 0x10));
  const skipDismissPc = pc;
  w[dismissDoneIdx] = encCbnz(15, stubPc + dismissDoneIdx * 4, skipDismissPc);
  w[blt7Idx] = encBCond(0xb, stubPc + blt7Idx * 4, skipDismissPc);
  push(0xaa1403e0); // mov x0, x20
  push(encLdr32(8, 20, 0x18));
  push(0x51000508); // subs w8, w8, #1
  push(0xa9417bfd);
  push(0xa8c14ff4);
  push(encB(pc, A.mainUpdateSwitchResume));
  return w;
}
// SDK_CallBack.LoginCallBack: when xluaMain.cur_state>=7 and mainGame set, mock loginToServer (no OnLoginOk / JumpToState).
function buildLoginCallBackBridgeCave(stubPc, golbalPage, golbalLdrOff, telemAddr, resumePc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bd57f6); // stp x22, x21, [sp,#-48]!
  push(0xa9014ff4); // stp x20, x19, [sp,#16]
  push(0xa9027bfd); // stp x29, x30, [sp,#32]
  push(encAdrp(21, pc, golbalPage));
  push(encLdr64(21, 21, golbalLdrOff));
  push(encLdr64(21, 21, 0xb8)); // static_fields
  push(encLdr64(20, 21, 0x10)); // xluaMain
  const cbzXluaIdx = w.length;
  push(0xb4000000);
  push(encLdr32(8, 20, 0x18)); // cur_state
  push(encLdr32(9, 20, 0x1c)); // cur_sub_state
  push(encAdrp(10, pc, telemAddr & ~0xfff));
  push(encAdd(10, 10, telemAddr & 0xfff));
  push(encStr32(8, 10, 0x0));
  push(encStr32(9, 10, 0x4));
  push(0x71000c1f); // cmp w8, #3 (resource/init far enough for offline guest)
  const bltStateIdx = w.length;
  push(0x54000000);
  push(encLdr64(0, 21, 0x8)); // mainGame
  const cbzGameIdx = w.length;
  push(0xb4000000);
  push(encLdr32(11, 10, 0x8)); // bridge_hits
  push(0x1100056b);
  push(encStr32(11, 10, 0x8));
  push(encMovW(11, 0x4249)); // 'BI' marker @ telem+0xc
  push(encStr32(11, 10, 0xc));
  push(0xaa1f03e1); // mov x1, xzr (succ delegate optional)
  push(0xaa1f03e2); // mov x2, xzr
  push(encBl(pc, A.patchLogin)); // mocked loginToServer entry
  const skipPc = pc;
  w[cbzXluaIdx] = encCbz(20, stubPc + cbzXluaIdx * 4, skipPc);
  w[bltStateIdx] = encBCond(0xb, stubPc + bltStateIdx * 4, skipPc);
  w[cbzGameIdx] = encCbz(0, stubPc + cbzGameIdx * 4, skipPc);
  push(0xaa1f03e0); // stock args
  push(0x2a1f03e1);
  push(0xaa1f03e2);
  push(encBl(pc, A.updateAllPlayerData));
  push(0xa9427bfd);
  push(0xa9414ff4);
  push(0xa8c357f6);
  push(encB(pc, resumePc));
  return w;
}
function buildJumpToStateLogCave(stubPc, telemAddr, dismissPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf7bfd); // stp x29, x30, [sp,#-16]!
  push(0xf90007e0); // str x0, [sp,#8] (Main / XLuaManager)
  push(encAdrp(9, pc, telemAddr & ~0xfff));
  push(encAdd(9, 9, telemAddr & 0xfff));
  push(encStr32(1, 9, 0x10)); // last JumpToState(new_state)
  push(0x71001c3f); // cmp w1, #7 (StartLogin)
  const skipDismissIdx = w.length;
  push(0x54000001); // b.ne skip
  push(encBl(pc, dismissPc)); // hide V_CheckResourceUpdate root
  const skipDismissPc = pc;
  w[skipDismissIdx] = encBCond(0x1, stubPc + skipDismissIdx * 4, skipDismissPc);
  push(0xf94007e0); // ldr x0, [sp,#8]
  push(0x29037c01); // stp w1, w8, [x0,#0x18] (stock JumpToState)
  push(0xa8c17bfd); // ldp x29, x30, [sp], #16
  push(0xd65f03c0);
  return w;
}
function buildGuestLoginBootCave(stubPc, golbalPage, golbalLdrOff, xluaPage, xluaLdrOff) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bd7bfd); // stp x29, x30, [sp,#-48]!
  push(0xf90013f5); // str x21, [sp,#24]
  push(0xa90157f6); // stp x22, x21, [sp,#16]
  push(0xa9004ff4); // stp x20, x19, [sp]
  push(0xaa0003f3); // mov x19, x0 (LeitingSdkCallBack this)
  push(encAdrp(21, pc, golbalPage));
  push(encLdr64(21, 21, golbalLdrOff));
  push(encLdr64(21, 21, 0xb8)); // static_fields
  push(encLdr64(20, 21, 0x10)); // xluaMain
  const cbzMainIdx = w.length;
  push(0xb4000000); // no xluaMain yet
  push(encLdr32(8, 20, 0x18)); // cur_state
  push(0x7100181f); // cmp w8, #6 (InitBaseCode done)
  const bltStIdx = w.length;
  push(0x54000000); // b.lt skip (still in resource/sdk init)
  push(encLdr32(9, 20, 0x1c)); // cur_sub_state
  push(0x7100051f); // cmp w9, #1 (SubState.Update)
  const bneSubIdx = w.length;
  push(0x54000000); // b.ne skip
  push(0xaa1403e0); // mov x0, x20
  push(encMovW(1, 7));
  push(encBl(pc, A.jumpToState));
  const skipJumpPc = pc;
  w[cbzMainIdx] = encCbz(20, stubPc + cbzMainIdx * 4, skipJumpPc);
  w[bltStIdx] = encBCond(0xb, stubPc + bltStIdx * 4, skipJumpPc);
  w[bneSubIdx] = encBCond(0x1, stubPc + bneSubIdx * 4, skipJumpPc);
  push(encAdrp(21, pc, xluaPage));
  push(encLdr64(21, 21, xluaLdrOff));
  push(encLdr64(0, 21, 0)); // XLuaManager.Instance
  const cbzXmIdx = w.length;
  push(0xb4000000);
  push(encBl(pc, A.xluaOnLoginOk));
  const skipXmPc = pc;
  w[cbzXmIdx] = encCbz(0, stubPc + cbzXmIdx * 4, skipXmPc);
  push(0xaa1303e0); // mov x0, x19
  push(0xaa1f03e1);
  push(0xaa1f03e2);
  push(0xa9404ff4); // ldp x20, x19, [sp]
  push(0xa94157f6); // ldp x22, x21, [sp,#16]
  push(0xf94013f5); // ldr x21, [sp,#24]
  push(0xa8c37bfd); // ldp x29, x30, [sp], #48
  push(encBl(pc, A.cave)); // mocked loginToServer
  return w;
}
function buildJumpToStateCave(stubPc, state, resumePc, srcReg) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(srcReg === 20 ? 0xaa1403e0 : 0xaa1303e0); // mov x0, x20|x19
  push(encMovW(1, state));
  push(encMovW(8, 0)); // SubState.Enter
  push(encBl(pc, A.jumpToState));
  push(encB(pc, resumePc));
  return w;
}
// Write Main.cur_state / cur_sub_state without JumpToState handlers (avoids SIGSEGV from Main.Update hook).
function buildForceMainStateCave(stubPc, state, subState, resumePc, srcReg) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(srcReg === 20 ? 0xaa1403e0 : 0xaa1303e0);
  push(encMovW(8, state));
  push(encStr32(8, 0, 0x18));
  push(encMovW(8, subState));
  push(encStr32(8, 0, 0x1c));
  push(encB(pc, resumePc));
  return w;
}
// Hide load UI using V_CheckResourceUpdate.this (works before Instance is set).
function buildDismissLoadThisCave(stubPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  const nullIdx = w.length;
  push(0xb4000000); // cbz x0, early ret
  push(0xa9bf7bfd);
  push(0xf90007e0);
  push(0xaa0003f3);
  push(encBl(pc, A.getGameObject));
  const cbzIdx = w.length;
  push(0xb4000000);
  push(encMovW(1, 0));
  push(encBl(pc, A.setActive));
  const skipPc = pc;
  w[cbzIdx] = encCbz(0, stubPc + cbzIdx * 4, skipPc);
  push(0xf94007e0);
  push(0xa8c17bfd);
  push(0xd65f03c0);
  w[nullIdx] = encCbz(0, stubPc + nullIdx * 4, pc - 4);
  return w;
}
function buildDismissLoadRootCave(stubPc, vciPage, vciLdrOff) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf7bfd); // stp x29, x30, [sp,#-16]!
  push(encAdrp(20, pc, vciPage));
  push(encLdr64(20, 20, vciLdrOff)); // TypeInfo / static fields
  push(encLdr64(0, 20, 0)); // V_CheckResourceUpdate.Instance
  const cbzIdx = w.length;
  push(0xb4000000); // cbz x0, skip
  push(encBl(pc, A.getGameObject));
  push(encMovW(1, 0));
  push(encBl(pc, A.setActive));
  const skipPc = pc;
  w[cbzIdx] = encCbz(0, stubPc + cbzIdx * 4, skipPc);
  push(0xa8c17bfd); // ldp x29, x30, [sp], #16
  push(0xd65f03c0); // ret (also called from JumpToState log cave)
  return w;
}
function buildOpenStartAutoEnterCave(stubPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  // After openStartBtn shows enter_btn, auto-tap instead of loginToServer branch.
  push(0xaa1303e0); // mov x0, x19
  push(encLdr64(1, 0, 0x58)); // ldr x1, [x0,#0x58] enter_btn
  const cbzIdx = w.length;
  push(0xb4000001);
  push(encBl(pc, A.enterBtnClick));
  push(encB(pc, A.openStartBtnReturn));
  const skipPc = pc;
  w[cbzIdx] = encCbz(1, stubPc + cbzIdx * 4, skipPc);
  return w;
}
function buildMainUpdateBootAssistCave(stubPc, frameAddr, dismissPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf7bfd); // stp x29, x30, [sp,#-16]!
  push(0xf90007e0); // str x0, [sp,#8]
  push(0xb9401a08); // ldr w8, [x0,#0x18] cur_state
  push(encAdrp(9, pc, frameAddr & ~0xfff));
  push(encAdd(9, 9, frameAddr & 0xfff));
  push(0xb940012a); // ldr w10, [x9] frame count
  push(0x1100054a); // add w10, w10, #1
  push(0xb900012a); // str w10, [x9]
  push(0xb940012b); // ldr w11, [x9,#4] dismiss_done
  const skipDismissIdx = w.length;
  push(0x35000000); // cbnz w11, skip_dismiss
  push(0x7100f15f); // cmp w10, #60
  const bltDismissIdx = w.length;
  push(0x54000000); // b.lt skip_dismiss
  push(encBl(pc, dismissPc));
  push(0xf94007e0); // reload Main this after dismiss
  push(encMovW(11, 1));
  push(0xb900012b); // str w11, [x9,#4] dismiss_done=1
  const skipDismissPc = pc;
  w[skipDismissIdx] = encCbnz(11, stubPc + skipDismissIdx * 4, skipDismissPc);
  w[bltDismissIdx] = encBCond(0xb, stubPc + bltDismissIdx * 4, skipDismissPc);
  push(0xf94007e0);
  push(0xb9401a08);
  push(0x7101e95f); // cmp w10, #122 (~2s)
  const bltStairIdx = w.length;
  push(0x54000000); // b.lt resume_switch
  push(0x7100191f); // cmp w8, #6
  const bge6Idx = w.length;
  push(0x54000000); // b.ge resume_switch
  push(0xf94007e0);
  push(0xb9401a08);
  push(0x11000508); // add w8, w8, #1 (bump stuck state 2..5 -> next)
  push(encStr32(8, 0, 0x18));
  push(encMovW(11, 0));
  push(encStr32(11, 0, 0x1c));
  const resumeSwitch = pc;
  w[bltStairIdx] = encBCond(0xb, stubPc + bltStairIdx * 4, resumeSwitch);
  w[bge6Idx] = encBCond(0xa, stubPc + bge6Idx * 4, resumeSwitch);
  push(0xf94007e0); // ldr x0, [sp,#8]
  push(0xb9401a08); // ldr w8, [x0,#0x18]
  push(0x7101e95f); // cmp w10, #122
  const bltLoginIdx = w.length;
  push(0x54000000); // b.lt resume_switch
  push(0x71000d1f); // cmp w8, #3
  const bne3Idx = w.length;
  push(0x54000001); // b.ne resume_switch
  push(0xf94007e0);
  push(encMovW(8, 7));
  push(encStr32(8, 0, 0x18));
  push(encMovW(11, 0));
  push(encStr32(11, 0, 0x1c));
  w[bltLoginIdx] = encBCond(0xb, stubPc + bltLoginIdx * 4, resumeSwitch);
  w[bne3Idx] = encBCond(0x1, stubPc + bne3Idx * 4, resumeSwitch);
  push(0xf94007e0);
  push(0xb9401a08);
  push(0x51000508); // subs w8, w8, #1 (stock switch index)
  push(0xa8c17bfd);
  push(encB(pc, A.mainUpdateSwitchResume));
  return w;
}
function buildStub(stubPc, jsonAddr, mode) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9be7bf3);
  push(0xa9014ff4);
  push(0xa90257f6);
  push(mode === "login" ? 0xaa0003f3 : 0xaa0103f4);
  const off = jsonAddr & 0xfff;
  push(encAdrp(0, pc, jsonAddr & ~0xfff));
  push(encAdd(0, 0, off));
  push(encBl(pc, A.stringNew));
  push(0xaa0003f5);
  push(0xaa1f03e1);
  push(encBl(pc, A.toObject));
  push(0xaa0003f6);
  push(mode === "login" ? 0xaa1303e0 : 0xaa1403e0);
  push(0xaa1603e1);
  push(0xaa1f03e2);
  push(encBl(pc, A.invoke));
  push(0xa94257f6);
  push(0xa9414ff4);
  push(0xa8c27bf3);
  push(0xd65f03c0);
  return w;
}
function writeWords(buf, addr, words) {
  words.forEach((w, i) => buf.writeUInt32LE(w, addr + i * 4));
}
function buildAfterResourceBoostCave(stubPc, golbalPage, golbalLdrOff) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf4ff4); // stp x20, x19, [sp,#-16]!
  push(encAdrp(20, pc, golbalPage));
  push(encLdr64(20, 20, golbalLdrOff));
  push(encLdr64(20, 20, 0xb8));
  push(encLdr64(0, 20, 0x10)); // xluaMain
  const cbzIdx = w.length;
  push(0xb4000000);
  push(encLdr32(8, 0, 0x18));
  push(0x71001c1f); // cmp w8, #7
  const doneIdx = w.length;
  push(0x5400000a); // b.ge done
  push(encMovW(1, 7));
  push(encMovW(8, 0));
  push(encBl(pc, A.jumpToState));
  const donePc = pc;
  w[cbzIdx] = encCbz(0, stubPc + cbzIdx * 4, donePc);
  w[doneIdx] = encBCond(0xa, stubPc + doneIdx * 4, donePc);
  push(0xa8c14ff4);
  push(0xd65f03c0);
  return w;
}
function buildMoveNextOk(stubPc, boostPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xaa0003f3); // mov x19, x0 (enumerator)
  push(0xf9401660); // ldr x0, [x19, #0x28] Action on_ok
  const cbzIdx = w.length;
  push(0xb4000000); // cbz x0, skip invoke
  push(0xaa1f03e1); // mov x1, xzr
  push(encBl(pc, A.actionVoidInvoke));
  const skipInvoke = pc;
  w[cbzIdx] = u32(0xb4000000 | (((skipInvoke - (stubPc + cbzIdx * 4)) >> 2) << 5));
  if (boostPc) {
    push(encBl(pc, boostPc));
  }
  push(0xaa1303e0); // mov x0, x19
  push(encB(pc, 0x2b4fb3c)); // stock: state=-1, return false
  return w;
}
function buildErrInvokeOk(stubPc) {
  const w = [];
  let pc = stubPc;
  const push = (i) => {
    w.push(u32(i));
    pc += 4;
  };
  push(0xa9bf7bfd);
  push(0x910003fd);
  push(0xf9400c00);
  const cbzIdx = w.length;
  push(0xb4000000);
  push(0xaa1f03e1);
  push(encBl(pc, A.actionVoidInvoke));
  const skipAt = pc;
  w[cbzIdx] = u32(0xb4000000 | (((skipAt - (stubPc + cbzIdx * 4)) >> 2) << 5));
  push(0xa8c17bfd);
  push(0xd65f03c0);
  return w;
}
const buf = fs.readFileSync(OUT);
const stock = fs.readFileSync(STOCK);
Buffer.from(LOGIN + "\0").copy(buf, A.jsonLogin);
Buffer.from(PLAYER + "\0").copy(buf, A.jsonPlayer);
writeWords(buf, A.cave, buildStub(A.cave, A.jsonLogin, "login"));
writeWords(buf, A.stubPlayer, buildStub(A.stubPlayer, A.jsonPlayer, "player"));
if (FULL) {
  buf.writeUInt32LE(encB(A.patchLogin, A.cave), A.patchLogin);
  buf.writeUInt32LE(encB(A.patchPlayer, A.stubPlayer), A.patchPlayer);
  buf.writeUInt32LE(encB(A.loginToServerSucc, A.openStartBtn), A.loginToServerSucc);
} else {
  buf.writeUInt32LE(stock.readUInt32LE(A.patchLogin), A.patchLogin);
  buf.writeUInt32LE(stock.readUInt32LE(A.patchPlayer), A.patchPlayer);
  buf.writeUInt32LE(stock.readUInt32LE(A.loginToServerSucc), A.loginToServerSucc);
}
if (FULL || !SHOWLOAD_ONLY) {
// Resource check: skip OnCheckResource HTTP; join CheckExtractResource success (Action.Invoke on_ok).
buf.writeUInt32LE(encB(A.patchCheckExtractSkipNet, A.checkExtractSuccessPath), A.patchCheckExtractSkipNet);
buf.writeUInt32LE(encB(A.patchCheckExtractCoroutineDone, A.checkExtractSuccessPath), A.patchCheckExtractCoroutineDone);
buf.writeUInt32LE(encB(A.patchUpdateSkipNet, A.updateSuccessPath), A.patchUpdateSkipNet);
buf.writeUInt32LE(encMovW(1, 100), 0x2b4eb6c); // Action<int>.Invoke(on_ok, progress=100)
if (FULL) {
  const golbalInsnEarly = buf.readUInt32LE(A.refMyGameGolbalTi);
  const golbalPageEarly = adrpPage(A.refMyGameGolbalTi, golbalInsnEarly);
  const golbalLdrOffEarly = ((buf.readUInt32LE(A.refMyGameGolbalTi + 4) >> 10) & 0xfff) * 8;
  writeWords(
    buf,
    A.caveAfterResourceBoost,
    buildAfterResourceBoostCave(A.caveAfterResourceBoost, golbalPageEarly, golbalLdrOffEarly),
  );
  writeWords(buf, A.caveMoveNextOk, buildMoveNextOk(A.caveMoveNextOk, A.caveAfterResourceBoost));
} else {
  writeWords(buf, A.caveMoveNextOk, buildMoveNextOk(A.caveMoveNextOk, 0));
}
buf.writeUInt32LE(encB(A.patchMoveNext, A.caveMoveNextOk), A.patchMoveNext);
writeWords(buf, A.caveErrInvokeOk, buildErrInvokeOk(A.caveErrInvokeOk));
buf.writeUInt32LE(encB(A.patchOnCheckResErr, A.caveErrInvokeOk), A.patchOnCheckResErr);
}
// Keep load panel visible (hiding it left a blank gray splash).
buf.writeUInt32LE(stock.readUInt32LE(A.awakeLoadPanelArg), A.awakeLoadPanelArg);
buf.writeUInt32LE(stock.readUInt32LE(A.awakeLoadPanelCall), A.awakeLoadPanelCall);
for (const off of A.nopShowLoadInfo) {
  buf.writeUInt32LE(0xd503201f, off);
}
if (FULL || !SHOWLOAD_ONLY) {
if (FULL) {
  buf.writeUInt32LE(0xd503201f, A.patchOnLoginSdkCbz);
}
buf.writeUInt32LE(encB(A.patchB80FastPath, A.b80FastPathTarget), A.patchB80FastPath);
buf.writeUInt32LE(encB(A.patchB82FastPath, A.b82FastPathTarget), A.patchB82FastPath);
buf.writeUInt32LE(encB(A.patchLoadSceneCompleteCbz, A.loadSceneCompleteTarget), A.patchLoadSceneCompleteCbz);
buf.writeUInt32LE(encB(A.patchInitAssetBundleIsDoneCbz, A.initAssetBundleDoneTarget), A.patchInitAssetBundleIsDoneCbz);
buf.writeUInt32LE(0xd503201f, A.patchLoadSceneIsDoneCbz);
buf.writeUInt32LE(0xd503201f, A.nopShowLoadAddInLoadScene);
buf.writeUInt32LE(0xd503201f, 0x2b50684);
buf.writeUInt32LE(0xd503201f, A.nopInitBaseLuaGate);
buf.writeUInt32LE(0xd503201f, A.nopInitBaseLuaNull);
buf.writeUInt32LE(0xd503201f, A.nopStartLoginGateA);
buf.writeUInt32LE(0xd503201f, A.nopStartLoginGateB);
buf.writeUInt32LE(0xd503201f, A.nopInitLuaEnvGateA);
buf.writeUInt32LE(0xd503201f, A.nopInitLuaEnvGateB);
}
buf.writeUInt32LE(stock.readUInt32LE(A.patchShowLoadHide), A.patchShowLoadHide);
// ShowLoadAddInfo: no-op (fast path uses this for progress overlay).
buf.writeUInt32LE(encB(A.patchShowLoadAddRet, A.showLoadAddRetTarget), A.patchShowLoadAddRet);
if (FULL) {
buf.writeUInt32LE(encB(A.patchHideGameStartBlack, A.hideGameStartBlackTarget), A.patchHideGameStartBlack);
buf.writeUInt32LE(encB(A.patchGameStartSkipPolicy, A.gameStartLoginPath), A.patchGameStartSkipPolicy);
buf.writeUInt32LE(0xd503201f, A.nopHideDelayGate);
buf.writeUInt32LE(0xd503201f, A.nopLoginNowInit);
buf.writeUInt32LE(0xd503201f, A.nopLoginNowEntering);
buf.writeUInt32LE(0xd503201f, A.nopHideBlackNull);
buf.writeUInt32LE(0xd503201f, A.nopEnterBtnGate);
buf.writeUInt32LE(0xd503201f, A.nopOpenStartInit);
buf.writeUInt32LE(0xd503201f, A.nopOpenStartSeaPolicy);
buf.writeUInt32LE(0xd503201f, A.nopGetLoginNews);
buf.writeUInt32LE(0xd503201f, A.nopLoginNowEarlyReturn);
}
if (FULL) {
writeWords(buf, A.caveSkipInitSdk, buildJumpToStateCave(A.caveSkipInitSdk, 6, A.initSdkBranchResume, 20));
buf.writeUInt32LE(encB(A.patchInitSdkBranch, A.caveSkipInitSdk), A.patchInitSdkBranch);
}
// Do not skip InitBaseCode @ 0x2b506c8 — must run InitLuaEnv (0x199c990) before StartLogin.
const vciInsn = buf.readUInt32LE(A.refVCheckInstance);
const vciPage = adrpPage(A.refVCheckInstance, vciInsn);
const vciLdrOff = ((buf.readUInt32LE(A.refVCheckInstance + 4) >> 10) & 0xfff) * 8;
writeWords(buf, A.caveDismissLoadRoot, buildDismissLoadRootCave(A.caveDismissLoadRoot, vciPage, vciLdrOff));
if (!FULL && (SHOWLOAD_ONLY || !RESOURCE_ONLY)) {
  writeWords(buf, A.caveDismissLoadThis, buildDismissLoadThisCave(A.caveDismissLoadThis));
  buf.writeUInt32LE(encB(A.patchShowLoadInfoEntry, A.caveDismissLoadThis), A.patchShowLoadInfoEntry);
  buf.writeUInt32LE(encB(A.patchShowLoadInfoFmt, A.caveDismissLoadThis), A.patchShowLoadInfoFmt);
  buf.writeUInt32LE(encB(A.patchShowLoadHideDismiss, A.caveDismissLoadRoot), A.patchShowLoadHideDismiss);
}
const golbalInsn = buf.readUInt32LE(A.refMyGameGolbalTi);
const golbalPage = adrpPage(A.refMyGameGolbalTi, golbalInsn);
const golbalLdrOff = ((buf.readUInt32LE(A.refMyGameGolbalTi + 4) >> 10) & 0xfff) * 8;
if (FULL) {
writeWords(buf, A.caveOnLoginSuccessFast, buildOnLoginSuccessFastCave(A.caveOnLoginSuccessFast, 0x15b1d7c));
buf.writeUInt32LE(encB(A.patchOnLoginSuccessDirect, A.caveOnLoginSuccessFast), A.patchOnLoginSuccessDirect);
writeWords(buf, A.caveUpdateShowLogoBypass, buildUpdateShowLogoBypassCave(A.caveUpdateShowLogoBypass));
buf.writeUInt32LE(encB(A.updateShowLogo, A.caveUpdateShowLogoBypass), A.updateShowLogo);
writeWords(buf, A.caveGameStartSplash, buildGameStartSplashCave(A.caveGameStartSplash, golbalPage, golbalLdrOff));
buf.writeUInt32LE(encB(A.patchGameStartSplash, A.caveGameStartSplash), A.patchGameStartSplash);
}
if (FULL || !SHOWLOAD_ONLY) {
buf.writeUInt32LE(0xd503201f, A.nopStartLoginGateA);
buf.writeUInt32LE(0xd503201f, A.nopStartLoginGateB);
buf.writeUInt32LE(0xd503201f, A.nopInitLuaEnvGateA);
buf.writeUInt32LE(0xd503201f, A.nopInitLuaEnvGateB);
}
if (FULL) {
const gateNops = [
  0x15b21f8, 0x15b2218, 0x15b22e0, 0x15b2330, 0x15b236c, 0x15b2548, 0x15b31c0, 0x15b32f0,
  0x15b1d94, 0x15b1de8, 0x15b1e08, 0x15b1e28, 0x15b1e48, 0x15b1e74, 0x15b1f14, 0x15b1f9c,
  0x15b4e94, 0x15b4eec, 0x15b4efc, 0x15b4f0c, 0x15b4f28, 0x15b4f58,
];
for (const off of gateNops) {
  buf.writeUInt32LE(0xd503201f, off);
}
}
buf.writeUInt32LE(0, A.caveGuestLoginTelemetry);
buf.writeUInt32LE(0, A.caveGuestLoginTelemetry + 4);
buf.writeUInt32LE(0, A.caveGuestLoginTelemetry + 8);
writeWords(
  buf,
  A.caveLoginCallBackBridge,
  buildLoginCallBackBridgeCave(
    A.caveLoginCallBackBridge,
    golbalPage,
    golbalLdrOff,
    A.caveGuestLoginTelemetry,
    A.loginCallBackPreServerResume,
  ),
);
// Native LoginCallBack account.login crashes if resource bypass beat XLua; Unity inject handles login.
buf.writeUInt32LE(stock.readUInt32LE(A.patchLoginCallBackPreServer), A.patchLoginCallBackPreServer);
buf.writeUInt32LE(0xd503201f, A.nopLoginCallBackServer);
if (FULL) {
  buf.writeUInt32LE(0, A.caveMainSafeJumpState);
  buf.writeUInt32LE(0, A.caveMainSafeJumpState + 4);
  buf.writeUInt32LE(0, A.caveMainSafeJumpState + 8);
  buf.writeUInt32LE(0, A.caveMainSafeJumpState + 12);
  buf.writeUInt32LE(0, A.caveMainSafeJumpState + 16);
  writeWords(
    buf,
    A.caveMainSafeJump,
    buildMainUpdateAssistCave(
      A.caveMainSafeJump,
      A.caveMainSafeJumpState,
      A.caveGuestLoginTelemetry,
      A.caveDismissLoadRoot,
    ),
  );
  buf.writeUInt32LE(encB(A.patchMainUpdateEntry, A.caveMainSafeJump), A.patchMainUpdateEntry);
  writeWords(
    buf,
    A.caveJumpToStateLog,
    buildJumpToStateLogCave(A.caveJumpToStateLog, A.caveGuestLoginTelemetry, A.caveDismissLoadRoot),
  );
  buf.writeUInt32LE(encB(A.patchJumpToState, A.caveJumpToStateLog), A.patchJumpToState);
}
if (FULL || !SHOWLOAD_ONLY) {
buf.writeUInt32LE(0xd503201f, 0x2b50684);
buf.writeUInt32LE(0xd503201f, A.nopInitBaseLuaGate);
buf.writeUInt32LE(0xd503201f, A.nopInitBaseLuaNull);
}
fs.writeFileSync(OUT, buf);
const tag = AGGRESSIVE
  ? "aggressive"
  : SHOWLOAD_ONLY
    ? "showload-only"
    : MINIMAL_BOOT
      ? "minimal-boot"
      : "full";
console.log(`v187 applied (${tag})`, OUT);
console.log("login patch", buf.readUInt32LE(A.patchLogin).toString(16));
console.log("checkExtract B", buf.readUInt32LE(A.patchCheckExtractSkipNet).toString(16));
console.log("updateRes B", buf.readUInt32LE(A.patchUpdateSkipNet).toString(16));
console.log("moveNext B", buf.readUInt32LE(A.patchMoveNext).toString(16));
console.log("LOGIN bytes", LOGIN.length, "PLAYER bytes", PLAYER.length);


