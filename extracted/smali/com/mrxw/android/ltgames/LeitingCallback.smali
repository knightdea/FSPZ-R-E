.class public Lcom/mrxw/android/ltgames/LeitingCallback;
.super Ljava/lang/Object;
.source "LeitingCallback.java"

# interfaces
.implements Lcom/leiting/sdk/callback/ILeiTingCallback;


# static fields
.field private static sInjectScheduled:Z

.field private static sPostLoginInjectScheduled:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getOfflineLoginJson()Ljava/lang/String;
    .locals 1

    const-string v0, "{\"abTest\":\"\",\"adult\":\"\",\"age\":\"\",\"auth\":\"\",\"bind\":\"\",\"channelNo\":\"310001\",\"game\":\"7\",\"guestUpgrade\":\"\",\"isGuest\":\"1\",\"memo\":\"Login successful\",\"mmid\":\"\",\"nickName\":\"\",\"registTime\":\"\",\"status\":\"1\",\"statusCode\":\"0\",\"thirdImageUrl\":\"\",\"timestamp\":\"1779918263371\",\"token\":\"b4e4e3744591ec28998eedee5d39460d\",\"type\":\"\",\"userId\":\"u8fdjo7b\",\"userName\":\"qk8ih8n5\"}"

    return-object v0
.end method

.method public static getOfflineRequestJson()Ljava/lang/String;
    .locals 1

    const-string v0, "{\"status\":1,\"code\":0,\"msg\":\"ok\",\"api\":\"account.login\",\"data\":{\"status\":1,\"session_id\":\"u8fdjo7b\",\"access_token\":\"b4e4e3744591ec28998eedee5d39460d\",\"zone\":1,\"versionState\":\"0\",\"isOpenRank\":false}}"

    return-object v0
.end method

.method public static getOfflinePlayerListJson()Ljava/lang/String;
    .locals 1

    const-string v0, "{\"status\":1,\"code\":0,\"msg\":\"ok\",\"api\":\"getPlayerAllDataList\",\"data\":{\"list\":[{\"level\":\"1\",\"displayName\":\"qk8ih8n5\",\"updatedat\":1779918263371,\"byhand\":0}]}}"

    return-object v0
.end method

.method public static injectOfflineLogin(Landroid/app/Activity;)V
    .locals 7

    invoke-static {}, Lcom/leiting/sdk/SdkConfigManager;->getInstanse()Lcom/leiting/sdk/SdkConfigManager;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/leiting/sdk/SdkConfigManager;->setThisTimeShowSeaPolicy(Z)V

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    const-string v2, "oversea_first_policy_tags_file"

    const-string v3, "oversea_first_policy_is_dialog_exist"

    invoke-static {p0, v2, v3, v0}, Lcom/leiting/sdk/util/SharedPreferencesUtil;->put(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V

    sget-boolean v0, Lcom/mrxw/android/ltgames/LeitingCallback;->sInjectScheduled:Z

    if-eqz v0, :cond_done

    return-void

    :cond_done
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrxw/android/ltgames/LeitingCallback;->sInjectScheduled:Z

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v2, 0x2

    invoke-direct {v1, v2}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0x7530

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v2, 0x3

    invoke-direct {v1, v2}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0xafc8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v2, 0x4

    invoke-direct {v1, v2}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0xea60

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method public static scheduleInjectAfterSdkLogin()V
    .locals 6

    return-void

    sget-boolean v0, Lcom/mrxw/android/ltgames/LeitingCallback;->sPostLoginInjectScheduled:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x1

    sput-boolean v0, Lcom/mrxw/android/ltgames/LeitingCallback;->sPostLoginInjectScheduled:Z

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v4, 0x1

    invoke-direct {v1, v4}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0x7530

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v4, 0x2

    invoke-direct {v1, v4}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0x9c40

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v4, 0x3

    invoke-direct {v1, v4}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/16 v2, 0xea60

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    new-instance v1, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;

    const/4 v4, 0x4

    invoke-direct {v1, v4}, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;-><init>(I)V

    const-wide/32 v2, 0x13880

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method


# virtual methods
.method public loginCallBack(Ljava/lang/String;)V
    .locals 1

    const-string v0, "==loginCallBack=="

    const-string p1, "sdk ok; defer Unity inject"

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public loginOutCallBack(Ljava/lang/String;)V
    .locals 2

    const-string v0, "LeitingSdk"

    const-string v1, "LogoutCallBack"

    invoke-static {v0, v1, p1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "==loginOutCallBack=="

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public payCallBack(Ljava/lang/String;)V
    .locals 2

    const-string v0, "LeitingSdk"

    const-string v1, "PayCallBack"

    invoke-static {v0, v1, p1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "==payCallBack=="

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public quitCallBack(Ljava/lang/String;)V
    .locals 2

    const-string v0, "LeitingSdk"

    const-string v1, "QuitCallBack"

    invoke-static {v0, v1, p1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "==quitCallBack=="

    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method