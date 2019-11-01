//
//  AppDelegate.m
//  Chasing Alpha
//
//  Created by fengj on 2018/6/14.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <IQKeyboardManager.h>
#import <YYTextView.h>
//#import "DFLocationManager.h"

#import "AppDelegate.h"

//// 引入 JPush 功能所需头文件
//#import "JPUSHService.h"
//// iOS10 注册 APNs 所需头文件
//#ifdef NSFoundationVersionNumber_iOS_9_x_Max
//#import <UserNotifications/UserNotifications.h>
//#endif
//// 如果需要使用 idfa 功能所需要引入的头文件（可选）
//
//#import <NSObject+YYModel.h>
//
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
//#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

/* 控制器 */
#import "DFRootViewController.h"

#import "DFBaseViewController.h"
#import "DFBaseNavigationController.h"
//#import "DFAcountNavigationController.h"
//#import "EaseConversationListViewController.h"

#import "DFLoginViewController.h"

#import "DFMainViewController.h"
#import "DFMsgViewController.h"
//#import "DFOrderViewController.h"
#import "DFMyViewController.h"

//#import "QUPayManager.h"

//#import <AlipaySDK/AlipaySDK.h>
//#import "EaseUI.h"
//#import "AppDelegate+DFphenate.h"

//分享
//#import "DFShareManager.h"
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//
//
//#import "DFMsgMgr.h"

@interface AppDelegate () <UITabBarControllerDelegate>
@property (nonatomic, assign) BOOL didEnterBackground;
@end

@implementation AppDelegate {
//    TencentOAuth *_tencentOAuth;
}


#pragma mark - life cycle




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//    if (launchOptions&&[launchOptions.allKeys containsObject:UIApplicationLaunchOptionsRemoteNotificationKey]) {
//        //app未启动 收到通知 点击进来的
//        [self recvNewNoti:launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]];
//    }
    
    
//    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101656663" andDelegate:self];
//
//    [DFShareManager share];
//
//    [DFLocationManager share];

    
    self.didEnterBackground = NO;
    //[[UserManager share] startTimerToCheckLoginStatus];//30分钟自动重连机制
    //初始化环信SDK
    //[self configDFpehenateSDK];
    
    [self setup];
    //[self setupJPushWithOptions:launchOptions];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:DFRootViewController.new];
    [self.window makeKeyAndVisible];
    
    

    return YES;
}

//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    self.didEnterBackground = YES;
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
//
//}
//
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    //如果之前进入后台,则进入前台查询下登录状态,判断是否需要重连
//    if (self.didEnterBackground) {
//        [[UserManager share] checkLoginStatus];
//    }
//    [[EMClient sharedClient] applicationWillEnterForeground:application];
//    [self cleanBadgeNumber:application];
//}
//
//- (void)cleanBadgeNumber:(UIApplication *)application {
//    [application setApplicationIconBadgeNumber:0]; //清除角标
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];//清除APP所有通知消息
//    [JPUSHService setBadge:0];
//}
//
//- (void)setupJPushWithOptions:(NSDictionary *)launchOptions {
//    //极光推送
//    
//    //Required
//    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
//    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
//    //JPAuthorizationOptionProvidesAppNotificationSettings
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        // 可以添加自定义 categories
//        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
//        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
//    }
//    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    
//    
//    // Required
//    // init Push
//    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
//    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
//    BOOL isProduction = YES;
//    NSString *channel = @"appstore";
//#ifdef DEBUG
//    isProduction = NO;
//    channel = @"debug mode";
//#endif
//    [JPUSHService setupWithOption:launchOptions appKey:@"1d9c334b119bd8b7267b5e01"
//                          channel:channel
//                 apsForProduction:isProduction];
//    
//    
//    //自定义消息
////        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
////        [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
//}
//
////- (void)networkDidReceiveMessage:(NSNotification *)notification {
////    NSDictionary *userInfo = [notification userInfo];
////
//    /*
//    {"eventDescription":"",
//     "msgData":{"orderBizId":"156854603851268201"},
//     "msgTime":1568546046491,
//     "msgType":1,
//     "notifyDescription":"你的拼单的商品已成团，请前往查看",
//     "systemNotifyFlag":1,
//     "triggerUserAvatar":"@SYSTEM_LOGO",
//     "triggerUserId":0,"triggerUserNickName":"系统消息"}
//     */
//    
//    
////    NSString *content = [userInfo valueForKey:@"content"];
////    QUMsgModel *msg = [QUMsgModel modelWithJSON:content];
////    if (msg) {
////        //本地持久化收到的消息
////
////    }
////    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"自定义消息" message:content delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
////    [alert show];
////
////    NSString *messageID = [userInfo valueForKey:@"_j_msgid"];
////    NSDictionary *extras = [userInfo valueForKey:@"extras"];
////    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //服务端传递的 Extras 附加字段，key 是自己定义的
////}
//
- (void)setup {
    //Manager Keyboard
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    /*
     UIKIT_EXTERN NSString *const YYTextViewTextDidBeginEditingNotification;
     UIKIT_EXTERN NSString *const YYTextViewTextDidChangeNotification;
     UIKIT_EXTERN NSString *const YYTextViewTextDidEndEditingNotification;
     */
    [[IQKeyboardManager sharedManager] registerTextFieldViewClass:YYTextView.class didBeginEditingNotificationName:YYTextViewTextDidBeginEditingNotification didEndEditingNotificationName:YYTextViewTextDidEndEditingNotification];
    
//    [QUPayManager share];//初始化微信支付宝SDK
    
    
    //要使用百度地图，请先启动BMKMapManager
//    _mapManager = [[BMKMapManager alloc] init];
    
    /**
     百度地图SDK所有API均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
//    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
//        NSLog(@"经纬度类型设置成功");
//    } else {
//        NSLog(@"经纬度类型设置失败");
//    }
//
//    //启动引擎并设置AK并设置delegate
//    BOOL result = [_mapManager start:@"PBCZz1Tr1jaLmbvXyptLChQPNN53BZxu" generalDelegate:self];
//    if (!result) {
//        NSLog(@"启动引擎失败");
//    }
}
//
//#pragma mark - Controller Init
//
//- (void)presentLoginControllerFrom:(UIViewController *)vc {
//    if (!vc) {
//        return;
//    }
//    DFLoginViewController *loginVC = DFLoginViewController.new;
//    loginVC.visitorLogin = YES;
//    DFAcountNavigationController *nav = [[DFAcountNavigationController alloc]initWithRootViewController:loginVC];
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    [nav setNavigationBarHidden:YES animated:NO];
//    [vc presentViewController:nav animated:YES completion:nil];
//}
//
- (void)setupLoginController {
    DFLoginViewController *vc = DFLoginViewController.new;
    DFBaseNavigationController *nav = [[DFBaseNavigationController alloc]initWithRootViewController:vc];
    [nav setNavigationBarHidden:YES animated:NO];
    [self.window setRootViewController:nav];
    
}

- (void)setupTabBarController {
    self.tabBarController = [self createTabBarController];
    [self.window setRootViewController:self.tabBarController];
}

- (UITabBarController *)createTabBarController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController = [[UITabBarController alloc] init];
    
    tabBarController.delegate = self;
    
    //创建 首页控制器
    DFMainViewController *mainVC = [[DFMainViewController alloc] init];
    
    //创建 提问控制器
    DFMsgViewController *msgVC = [DFMsgViewController new];

    //创建 我的控制器
    DFMyViewController *myVC = [[DFMyViewController alloc] init];
    
    
    DFBaseNavigationController *navigation = [[DFBaseNavigationController alloc] initWithRootViewController:mainVC];
    DFBaseNavigationController *navigation1 = [[DFBaseNavigationController alloc] initWithRootViewController:msgVC];
    DFBaseNavigationController *navigation2 = [[DFBaseNavigationController alloc] initWithRootViewController:myVC];

    
    navigation.fd_fullscreenPopGestureRecognizer.enabled  =
    navigation1.fd_fullscreenPopGestureRecognizer.enabled  =
    navigation2.fd_fullscreenPopGestureRecognizer.enabled = NO;
    
    [navigation setNavigationBarHidden:YES animated:NO];
    [navigation1 setNavigationBarHidden:YES animated:NO];
    [navigation2 setNavigationBarHidden:YES animated:NO];

    NSArray <DFBaseNavigationController *> *navigations = @[navigation, navigation1, navigation2];
    
    NSDictionary *icon = @{@"normal":@[@"tabbar_main_normal",@"tabbar_msg_normal",@"tabbar_my_normal"],@"selected":@[@"tabbar_main_highlight",@"tabbar_msg_highlight",@"tabbar_my_highlight"]};
    // 自定义tabbar
    NSArray *titles = @[@"首页", @"消息",@"我的"];
    for (int i = 0; i< titles.count; i++) {
        NSString *imageName = icon[@"normal"][i];
        NSString *imageNameSel = icon[@"selected"][i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *selImg = [UIImage imageNamed:imageNameSel];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:titles[i] image:image?image:nil selectedImage:selImg?selImg:nil];
        
        item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSFontAttributeName:FONTR(10),NSForegroundColorAttributeName:FontColor1,} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:FONTR(10),NSForegroundColorAttributeName:FontColor1,} forState:UIControlStateSelected];
        
        navigations[i].tabBarItem = item;
    }
    
    [UITabBar appearance].translucent = NO;
    
    [tabBarController.tabBar setBarTintColor:[UIColor whiteColor]];
    
    [tabBarController setViewControllers:@[navigation,navigation1,navigation2]];

    return tabBarController;
}

//#pragma mark - UITabBarControllerDelegate
//
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
//    if ([UserManager share].isVisitor) {
//        NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
//        if (index!=0) {
//            //访客账户 只能访问首页
//            UIViewController *vc = tabBarController.viewControllers.firstObject;
//            [self presentLoginControllerFrom:vc];
//            return NO;
//        }
//    }
//    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
//    if (index == 1) {
//        [self cleanBadgeNumber:[UIApplication sharedApplication]];
//    }
//    return YES;
//}
//
//#pragma mark - 微信 支付宝 回调
//
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//
//    if ([TencentOAuth CanHandleOpenURL:url]) {
//        return [TencentOAuth HandleOpenURL:url];
//    }
//    if([QQApiInterface handleOpenURL:url  delegate:[DFShareManager share]]) {
//        return YES;
//    }
//    if ([WXApi handleOpenURL:url delegate:[QUPayManager share]]) {
//        return YES;
//    }
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [[QUPayManager share]aliPayPaymentResult:resultDic];
//        }];
//    }
//    return YES;
//}

//#pragma mark - 推送相关
//
//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[EMClient sharedClient] bindDeviceToken:deviceToken];
//    });
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    [self recvNewNoti:userInfo];
//
//    // Required, iOS 7 Support
//    [JPUSHService handleRemoteNotification:userInfo];
//    [JPUSHService setBadge:0];
//
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    [self recvNewNoti:userInfo];
//
//    // Required, For systems with less than or equal to iOS 6
//    [JPUSHService handleRemoteNotification:userInfo];
//    [JPUSHService setBadge:0];
//}
//
//#pragma mark- JPUSHRegisterDelegate
//
//// iOS 12 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
//    
//    
//    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //从通知界面直接进入应用
//    }else{
//        //从通知设置界面进入应用
//    }
//    
//    NSDictionary * userInfo = notification.request.content.userInfo;
//
//    [self recvNewNoti:userInfo];
//}
//
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    
//    /*
//     前台模式下  推送走这里
//     {
//     "_j_business" = 1;
//     "_j_msgid" = 38280619866253999;
//     "_j_uid" = 29847243158;
//     aps =     {
//     alert = 123;
//     badge = 1;
//     sound = default;
//     };
//     }
//     */
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [self recvNewNoti:userInfo];
//        //前台模式下  推送 走这里
//        [JPUSHService handleRemoteNotification:userInfo];
//    }
//    completionHandler(UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
//    [JPUSHService setBadge:0];
//}
//
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
//    // Required
//    
//
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    
//    
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//        [self recvNewNoti:userInfo];
//        //点击通知栏通知 进入app  走这里
//    }
//    completionHandler();  // 系统要求执行这个方法
//    [JPUSHService setBadge:0];
//}
//
//#pragma mark - QQ分享相关 TencentSessionDelegate
//
////登录功能没添加，但调用TencentOAuth相关方法进行分享必须添加<TencentSessionDelegate>，则以下方法必须实现，尽管并不需要实际使用它们
////登录成功
//- (void)tencentDidLogin
//{
//    //    _labelTitle.text = @"登录完成";
//    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
//    {
//        // 记录登录用户的OpenID、Token以及过期时间
//        //        _labelAccessToken.text = _tencentOAuth.accessToken;
//    }
//    else
//    {
//        //登录不成功 没有获取accesstoken
//    }
//}
//
//
////非网络错误导致登录失败
//-(void)tencentDidNotLogin:(BOOL)cancelled
//{
//    if (cancelled)
//    {
//        //用户取消登录
//    }
//    else
//    {
//        //登录失败
//    }
//}
//
////网络错误导致登录失败
//-(void)tencentDidNotNetWork
//{
//    //无网络连接，请设置网络
//}
//
//#pragma mark - 推送消息
//
//- (void)recvNewNoti:(NSDictionary *)notiDict {
//    if (!notiDict) {
//        return;
//    }
//    
//    
//    /* ext 为自定义数据的字段 */
//    if (![notiDict.allKeys containsObject:@"ext"]) {
//        return;
//    }
//
//    NSString *extStr = [notiDict objectForKey:@"ext"];
//    if (!extStr.length) {
//        return;
//    }
//    NSData *extData = [extStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSDictionary *ext = [NSJSONSerialization JSONObjectWithData:extData options:NSJSONReadingAllowFragments error:&error];
//    if (error) {
//        NSLog(@"%@",error.localizedDescription);
//        return;
//    }
//    
//    if ([ext.allKeys containsObject:@"msgType"]) {
//        NSInteger msgType = [[ext objectForKey:@"msgType"] integerValue];
//        if (msgType == 5 || msgType == 6 || msgType == 7) {
//            //收到即时通信的推送消息
//        } else {
//            //拼团 退款 用户反馈的消息
//            [self setNewMsgUnRead];
//        }
//    }
//    
//    /*
//    {"eventDescription":"",
//     "msgData":{"orderBizId":"156854603851268201"},
//     "msgTime":1568546046491,
//     "msgType":1,
//     "notifyDescription":"你的拼单的商品已成团，请前往查看",
//     "systemNotifyFlag":1,
//     "triggerUserAvatar":"@SYSTEM_LOGO",
//     "triggerUserId":0,"triggerUserNickName":"系统消息"}
//     */
//    
//    /*
//     msgType = 1（拼团成功消息）
//     msgType = 2（退款消息）
//     msgType = 3（系统回复用户反馈消息）
//     msgType = 5（圈子聊天消息）
//     msgType = 6（客服聊天消息消息）
//     msgType = 7（好友聊天消息消息）
//     */
//    
//}
//
//- (void)setNewMsgUnRead {
//    [DFMsgMgr share].newMsgUnread = YES;
//}
//
//#pragma mark - 百度地图
//
///**
// 联网结果回调
// 
// @param iError 联网结果错误码信息，0代表联网成功
// */
//- (void)onGetNetworkState:(int)iError {
//    if (0 == iError) {
//        NSLog(@"百度地图 联网成功");
//    } else {
//        NSLog(@"百度地图 联网失败：%d", iError);
//    }
//}
//
///**
// 鉴权结果回调
//
// @param iError 鉴权结果错误码信息，0代表鉴权成功
// */
//- (void)onGetPermissionState:(int)iError {
//    if (0 == iError) {
//        NSLog(@"百度地图 授权成功");
//
//    } else {
//        NSLog(@"百度地图 授权失败：%d", iError);
//    }
//}

@end
