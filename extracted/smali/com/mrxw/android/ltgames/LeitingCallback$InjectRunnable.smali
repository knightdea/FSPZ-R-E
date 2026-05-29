.class Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;
.super Ljava/lang/Object;
.source "LeitingCallback.java"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field private final attempt:I


# direct methods
.method constructor <init>(I)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;->attempt:I

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget v0, p0, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;->attempt:I

    const/4 v1, 0x3

    if-lt v0, v1, :cond_log

    const-string v0, "LeitingSdk"

    const-string v1, "RequestCallBack"

    invoke-static {}, Lcom/mrxw/android/ltgames/LeitingCallback;->getOfflineRequestJson()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lcom/mrxw/android/ltgames/LeitingCallback;->getOfflinePlayerListJson()Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mainGame"

    const-string v1, "OnLoginSuccessBySdk"

    const-string v2, ""

    invoke-static {v0, v1, v2}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "updateShowLogo"

    invoke-static {v0, v1, v2}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :cond_log
    const-string v0, "OfflineBypass"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "inject attempt "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/mrxw/android/ltgames/LeitingCallback$InjectRunnable;->attempt:I

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
