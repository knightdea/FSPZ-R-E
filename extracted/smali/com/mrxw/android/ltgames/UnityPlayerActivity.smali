.class public Lcom/mrxw/android/ltgames/UnityPlayerActivity;
.super Landroid/app/Activity;
.source "UnityPlayerActivity.java"

# interfaces
.implements Lcom/unity3d/player/IUnityPlayerLifecycleEvents;


# static fields
.field private static final CHECK_OP_NO_THROW:Ljava/lang/String; = "checkOpNoThrow"

.field private static final OP_POST_NOTIFICATION:Ljava/lang/String; = "OP_POST_NOTIFICATION"


# instance fields
.field private activity:Landroid/app/Activity;

.field private callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

.field protected mUnityPlayer:Lcom/unity3d/player/UnityPlayer;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 44
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 47
    new-instance v0, Lcom/mrxw/android/ltgames/LeitingCallback;

    invoke-direct {v0}, Lcom/mrxw/android/ltgames/LeitingCallback;-><init>()V

    iput-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    return-void
.end method

.method public static gotoNotificationSetting(Landroid/content/Context;)V
    .locals 3

    .line 503
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/high16 v1, 0x10000000

    const/16 v2, 0x15

    if-lt v0, v2, :cond_0

    .line 504
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 505
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v1, "android.settings.APP_NOTIFICATION_SETTINGS"

    .line 506
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 507
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "app_package"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 508
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->uid:I

    const-string v2, "app_uid"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 509
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    goto :goto_0

    .line 510
    :cond_0
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x13

    if-ne v0, v2, :cond_1

    .line 511
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 512
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    .line 513
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "android.intent.category.DEFAULT"

    .line 514
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 515
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "package:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 516
    invoke-virtual {p0, v0}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :cond_1
    :goto_0
    return-void
.end method

.method public static isNotificationEnabled(Landroid/content/Context;)Z
    .locals 13

    const-string v0, "false"

    const-string v1, "CheckNotificationEnabledCallBack"

    const-string v2, "LeitingSdk"

    const-string v3, "appops"

    .line 454
    invoke-virtual {p0, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/AppOpsManager;

    .line 455
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v4

    .line 456
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    .line 457
    iget v4, v4, Landroid/content/pm/ApplicationInfo;->uid:I

    const/4 v5, 0x0

    .line 461
    :try_start_0
    const-class v6, Landroid/app/AppOpsManager;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    const-string v7, "checkOpNoThrow"

    const/4 v8, 0x3

    new-array v9, v8, [Ljava/lang/Class;

    .line 462
    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v10, v9, v5

    sget-object v10, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v11, 0x1

    aput-object v10, v9, v11

    const-class v10, Ljava/lang/String;

    const/4 v12, 0x2

    aput-object v10, v9, v12

    .line 463
    invoke-virtual {v6, v7, v9}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    const-string v9, "OP_POST_NOTIFICATION"

    .line 469
    invoke-virtual {v6, v9}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v6

    .line 470
    const-class v9, Ljava/lang/Integer;

    invoke-virtual {v6, v9}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Integer;

    invoke-virtual {v6}, Ljava/lang/Integer;->intValue()I

    move-result v6

    new-array v8, v8, [Ljava/lang/Object;

    .line 473
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    aput-object v6, v8, v5

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v8, v11

    aput-object p0, v8, v12

    invoke-virtual {v7, v3, v8}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0

    if-nez p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v11, 0x0

    :goto_0
    if-eqz v11, :cond_1

    const-string p0, "true"

    .line 476
    invoke-static {v2, v1, p0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 478
    :cond_1
    invoke-static {v2, v1, v0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_1
    return v11

    :catch_0
    move-exception p0

    .line 491
    invoke-virtual {p0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_2

    :catch_1
    move-exception p0

    .line 489
    invoke-virtual {p0}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_2

    :catch_2
    move-exception p0

    .line 487
    invoke-virtual {p0}, Ljava/lang/NoSuchFieldException;->printStackTrace()V

    goto :goto_2

    :catch_3
    move-exception p0

    .line 485
    invoke-virtual {p0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    goto :goto_2

    :catch_4
    move-exception p0

    .line 483
    invoke-virtual {p0}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    .line 494
    :goto_2
    invoke-static {v2, v1, v0}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return v5
.end method

.method public static setFullScreenWindowLayout(Landroid/view/Window;)V
    .locals 2

    .line 126
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-ge v0, v1, :cond_0

    return-void

    .line 127
    :cond_0
    invoke-virtual {p0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x500

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    const/high16 v0, -0x80000000

    .line 128
    invoke-virtual {p0, v0}, Landroid/view/Window;->addFlags(I)V

    const/4 v0, 0x0

    .line 129
    invoke-virtual {p0, v0}, Landroid/view/Window;->setStatusBarColor(I)V

    .line 131
    invoke-virtual {p0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    const/4 v1, 0x1

    .line 132
    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    .line 134
    invoke-virtual {p0, v0}, Landroid/view/Window;->setAttributes(Landroid/view/WindowManager$LayoutParams;)V

    return-void
.end method


# virtual methods
.method public AccountCenter()V
    .locals 2

    .line 199
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->accountCenter(Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public Connect(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public CreateRoleReport(Ljava/lang/String;)V
    .locals 2

    const-string v0, "CreateRoleReport::"

    .line 246
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 247
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->createRoleReport(Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public Disconnect(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public EventReport(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const-string v0, "EventReport plugName::"

    .line 251
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "EventReport eventKey::"

    .line 252
    invoke-static {v0, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const-string v0, "EventReport Value::"

    .line 253
    invoke-static {v0, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 254
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/leiting/sdk/channel/base/IChannelService;->eventReport(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public GetChannelExtInfo(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4

    const-string v0, "\\|"

    .line 577
    invoke-virtual {p2, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p2

    .line 578
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 579
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const/4 v2, 0x0

    .line 580
    :goto_0
    array-length v3, p2

    if-ge v2, v3, :cond_0

    .line 581
    aget-object v3, p2, v2

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    const-string p2, "productInfo"

    .line 583
    invoke-interface {v0, p2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 584
    new-instance p2, Lcom/google/gson/Gson;

    invoke-direct {p2}, Lcom/google/gson/Gson;-><init>()V

    invoke-virtual {p2, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    const-string v0, "sdkCharge1"

    .line 585
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 586
    invoke-static {v0, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 587
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$7;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$7;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, p2, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->getChannelExtInfo(Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public GetLangSystem()Ljava/lang/String;
    .locals 1

    .line 162
    invoke-static {p0}, Lcom/leiting/sdk/util/LanguageUtil;->getLanguageCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public GetPayOrderStatus(Ljava/lang/String;)V
    .locals 2

    .line 608
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$9;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$9;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->getPayOrderStatus(Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public GetPropertie(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 175
    new-instance v0, Ljava/util/Properties;

    invoke-direct {v0}, Ljava/util/Properties;-><init>()V

    .line 177
    :try_start_0
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    .line 178
    invoke-virtual {v0, p1}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 179
    invoke-virtual {p1}, Ljava/io/InputStream;->close()V

    .line 180
    invoke-virtual {v0, p2}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const-string p1, ""

    return-object p1
.end method

.method public GetProperties(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    const-string v0, "terminInfo"

    .line 225
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 226
    sget-object p1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object p1

    :cond_0
    const-string v0, "osVer"

    .line 227
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 228
    sget-object p1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    return-object p1

    .line 230
    :cond_1
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/leiting/sdk/channel/base/IChannelService;->getPropertiesValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public Helper(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 204
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, p1, p2, p3, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->helper(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public HeroSdkGetLang()V
    .locals 3

    .line 150
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 151
    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    .line 153
    iget-object v1, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v1}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v1

    .line 154
    iget-object v0, v0, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0}, Ljava/util/Locale;->getCountry()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 155
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_0

    .line 156
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "-"

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    :cond_0
    const-string v0, "HeroSdk"

    const-string v2, "GetLangCallBack"

    .line 158
    invoke-static {v0, v2, v1}, Lcom/unity3d/player/UnityPlayer;->UnitySendMessage(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public InitSDK()V
    .locals 0

    return-void
.end method

.method public Invite(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 318
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$5;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$5;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, p2, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->invite(Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public LeitingLogin()V
    .locals 2

    .line 538
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->leitingLogin(Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public LevelUpReport(Ljava/lang/String;)V
    .locals 2

    const-string v0, "LevelUpReport::"

    .line 236
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 237
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->levelUpReport(Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public Login()V
    .locals 2

    .line 188
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->login(Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public LoginReport(Ljava/lang/String;)V
    .locals 2

    const-string v0, "LoginReport::"

    .line 241
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 242
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->loginReport(Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public Logout()V
    .locals 2

    .line 533
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->logout(Lcom/leiting/sdk/callback/ILeiTingCallback;)Z

    return-void
.end method

.method public NotificationEnabled()Z
    .locals 12

    const-string v0, "checkOpNoThrow"

    const-string v1, "OP_POST_NOTIFICATION"

    const-string v2, "appops"

    .line 405
    invoke-virtual {p0, v2}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/app/AppOpsManager;

    .line 406
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v3

    .line 407
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    invoke-virtual {v4}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v4

    .line 408
    iget v3, v3, Landroid/content/pm/ApplicationInfo;->uid:I

    const/4 v5, 0x0

    .line 413
    :try_start_0
    const-class v6, Landroid/app/AppOpsManager;

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    const/4 v7, 0x3

    new-array v8, v7, [Ljava/lang/Class;

    .line 414
    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v9, v8, v5

    sget-object v9, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const/4 v10, 0x1

    aput-object v9, v8, v10

    const-class v9, Ljava/lang/String;

    const/4 v11, 0x2

    aput-object v9, v8, v11

    invoke-virtual {v6, v0, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 416
    invoke-virtual {v6, v1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1

    .line 418
    const-class v6, Ljava/lang/Integer;

    invoke-virtual {v1, v6}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    new-array v6, v7, [Ljava/lang/Object;

    .line 419
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v6, v5

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    aput-object v1, v6, v10

    aput-object v4, v6, v11

    invoke-virtual {v0, v2, v6}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    const/4 v5, 0x1

    :cond_0
    return v5

    :catch_0
    move-exception v0

    .line 422
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    return v5
.end method

.method public ObbDownload(Ljava/lang/String;)V
    .locals 2

    .line 598
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$8;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$8;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->start(Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public OpenNotificationSetting()V
    .locals 4

    .line 430
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 431
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const-string v2, "android.settings.APP_NOTIFICATION_SETTINGS"

    const/16 v3, 0x1a

    if-lt v1, v3, :cond_0

    .line 433
    invoke-virtual {v0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 434
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "android.provider.extra.APP_PACKAGE"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0

    .line 435
    :cond_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x15

    if-lt v1, v3, :cond_1

    .line 437
    invoke-virtual {v0, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 438
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "app_package"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 439
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget v1, v1, Landroid/content/pm/ApplicationInfo;->uid:I

    const-string v2, "app_uid"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    goto :goto_0

    :cond_1
    const-string v1, "android.settings.APPLICATION_DETAILS_SETTINGS"

    .line 442
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 443
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    const-string v3, "package"

    invoke-static {v3, v1, v2}, Landroid/net/Uri;->fromParts(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    :goto_0
    const/high16 v1, 0x10000000

    .line 445
    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 446
    invoke-virtual {p0, v0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->startActivity(Landroid/content/Intent;)V

    return-void
.end method

.method public Pay(Ljava/lang/String;)V
    .locals 2

    const-string v0, "unityPay"

    .line 193
    invoke-static {v0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 194
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->pay(Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public PlayAd(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    const-string p1, "sdkad"

    .line 213
    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object p1

    new-instance v0, Lcom/mrxw/android/ltgames/UnityPlayerActivity$3;

    invoke-direct {v0, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$3;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    const-string v1, "OfficialSeaAd"

    invoke-interface {p1, v1, p2, v0}, Lcom/leiting/sdk/channel/base/IChannelService;->start(Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public Quit()V
    .locals 2

    .line 209
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->quit(Lcom/leiting/sdk/callback/ILeiTingCallback;)Z

    return-void
.end method

.method public Request(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 567
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$6;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$6;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, p2, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->request(Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public SetLangSystem(Ljava/lang/String;)V
    .locals 2

    .line 166
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$2;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$2;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->switchLanguage(Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public Share(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    .line 308
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$4;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$4;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-interface {v0, p1, p2, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->share(Ljava/lang/String;Ljava/lang/String;Lcom/leiting/sdk/callback/Callable;)V

    return-void
.end method

.method public ShowAchievements(Ljava/lang/String;)V
    .locals 1

    .line 562
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/leiting/sdk/channel/base/IChannelService;->showAchievements(Ljava/lang/String;)V

    return-void
.end method

.method public ShowLeaderboards(Ljava/lang/String;)V
    .locals 1

    .line 547
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/leiting/sdk/channel/base/IChannelService;->showLeaderboards(Ljava/lang/String;)V

    return-void
.end method

.method public SubmitScore(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 1

    .line 552
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3, p4}, Lcom/leiting/sdk/channel/base/IChannelService;->submitScore(Ljava/lang/String;Ljava/lang/String;J)V

    return-void
.end method

.method public SwitchAccount()V
    .locals 2

    .line 528
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    iget-object v1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    invoke-interface {v0, v1}, Lcom/leiting/sdk/channel/base/IChannelService;->switchAccount(Lcom/leiting/sdk/callback/ILeiTingCallback;)V

    return-void
.end method

.method public UnlockAchievement(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 1

    .line 557
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/leiting/sdk/channel/base/IChannelService;->unlockAchievement(Ljava/lang/String;Ljava/lang/String;I)V

    return-void
.end method

.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 2

    .line 385
    invoke-virtual {p1}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 386
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->injectEvent(Landroid/view/InputEvent;)Z

    move-result p1

    return p1

    .line 387
    :cond_0
    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 2

    .line 274
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, " -- "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    if-nez p3, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "unityPayResult"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 276
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/leiting/sdk/channel/base/IChannelService;->onActivityResult(IILandroid/content/Intent;)V

    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1

    .line 369
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 370
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->configurationChanged(Landroid/content/res/Configuration;)V

    .line 371
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/leiting/sdk/channel/base/IChannelService;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    const/4 v0, 0x1

    .line 66
    invoke-virtual {p0, v0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->requestWindowFeature(I)Z

    .line 67
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 68
    iput-object p0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->activity:Landroid/app/Activity;

    .line 70
    invoke-static {p0}, Lcom/leiting/sdk/util/LanguageUtil;->getLanguageCode(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->callback:Lcom/leiting/sdk/callback/ILeiTingCallback;

    new-instance v1, Lcom/mrxw/android/ltgames/UnityPlayerActivity$1;

    invoke-direct {v1, p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity$1;-><init>(Lcom/mrxw/android/ltgames/UnityPlayerActivity;)V

    invoke-static {p0, p1, v0, v1}, Lcom/leiting/sdk/LeitingSDK;->initSDK(Landroid/app/Activity;Ljava/lang/String;Lcom/leiting/sdk/callback/ILeiTingCallback;Lcom/leiting/sdk/callback/Callable;)V

    invoke-static {p0}, Lcom/mrxw/android/ltgames/LeitingCallback;->injectOfflineLogin(Landroid/app/Activity;)V

    .line 80
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v0, "unity"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->updateUnityCommandLineArguments(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 81
    invoke-virtual {p0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, v0, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 82
    new-instance p1, Lcom/unity3d/player/UnityPlayer;

    invoke-direct {p1, p0, p0}, Lcom/unity3d/player/UnityPlayer;-><init>(Landroid/content/Context;Lcom/unity3d/player/IUnityPlayerLifecycleEvents;)V

    iput-object p1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    .line 83
    invoke-virtual {p0, p1}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->setContentView(Landroid/view/View;)V

    .line 84
    iget-object p1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1}, Lcom/unity3d/player/UnityPlayer;->requestFocus()Z

    return-void
.end method

.method protected onDestroy()V
    .locals 1

    .line 260
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->destroy()V

    .line 261
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 262
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onDestroy()V

    return-void
.end method

.method public onGenericMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 394
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->injectEvent(Landroid/view/InputEvent;)Z

    move-result p1

    return p1
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 0

    .line 392
    iget-object p1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1, p2}, Lcom/unity3d/player/UnityPlayer;->injectEvent(Landroid/view/InputEvent;)Z

    move-result p1

    return p1
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 0

    .line 391
    iget-object p1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1, p2}, Lcom/unity3d/player/UnityPlayer;->injectEvent(Landroid/view/InputEvent;)Z

    move-result p1

    return p1
.end method

.method public onLowMemory()V
    .locals 1

    .line 352
    invoke-super {p0}, Landroid/app/Activity;->onLowMemory()V

    .line 353
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->lowMemory()V

    return-void
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 1

    .line 143
    invoke-virtual {p0, p1}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->setIntent(Landroid/content/Intent;)V

    .line 144
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->newIntent(Landroid/content/Intent;)V

    .line 145
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/leiting/sdk/channel/base/IChannelService;->onNewIntent(Landroid/content/Intent;)V

    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 331
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 332
    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->saveMultiWindowMode(Landroid/app/Activity;)V

    .line 333
    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->getAllowResizableWindow(Landroid/app/Activity;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    .line 335
    :cond_0
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->pause()V

    .line 336
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onPause()V

    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 1

    .line 299
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 300
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/leiting/sdk/channel/base/IChannelService;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    return-void
.end method

.method protected onRestart()V
    .locals 1

    .line 267
    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    .line 268
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onRestart()V

    return-void
.end method

.method protected onResume()V
    .locals 1

    .line 342
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 343
    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->getAllowResizableWindow(Landroid/app/Activity;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->isMultiWindowModeChangedToTrue(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 345
    :cond_0
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->resume()V

    .line 346
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onResume()V

    return-void
.end method

.method protected onStart()V
    .locals 1

    .line 290
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 291
    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->getAllowResizableWindow(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 293
    :cond_0
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->resume()V

    .line 294
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onStart()V

    return-void
.end method

.method protected onStop()V
    .locals 1

    .line 281
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 282
    invoke-static {p0}, Lcom/unity3d/player/MultiWindowSupport;->getAllowResizableWindow(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 284
    :cond_0
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0}, Lcom/unity3d/player/UnityPlayer;->pause()V

    .line 285
    invoke-static {}, Lcom/leiting/sdk/LeitingSDK;->getInstance()Lcom/leiting/sdk/channel/base/IChannelService;

    move-result-object v0

    invoke-interface {v0}, Lcom/leiting/sdk/channel/base/IChannelService;->onStop()V

    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    .line 393
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->injectEvent(Landroid/view/InputEvent;)Z

    move-result p1

    return p1
.end method

.method public onTrimMemory(I)V
    .locals 1

    .line 359
    invoke-super {p0, p1}, Landroid/app/Activity;->onTrimMemory(I)V

    const/16 v0, 0xf

    if-ne p1, v0, :cond_0

    .line 362
    iget-object p1, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {p1}, Lcom/unity3d/player/UnityPlayer;->lowMemory()V

    :cond_0
    return-void
.end method

.method public onUnityPlayerQuitted()V
    .locals 1

    .line 96
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    return-void
.end method

.method public onUnityPlayerUnloaded()V
    .locals 1

    const/4 v0, 0x1

    .line 91
    invoke-virtual {p0, v0}, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->moveTaskToBack(Z)Z

    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1

    .line 377
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    .line 378
    iget-object v0, p0, Lcom/mrxw/android/ltgames/UnityPlayerActivity;->mUnityPlayer:Lcom/unity3d/player/UnityPlayer;

    invoke-virtual {v0, p1}, Lcom/unity3d/player/UnityPlayer;->windowFocusChanged(Z)V

    return-void
.end method

.method protected updateUnityCommandLineArguments(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    return-object p1
.end method
