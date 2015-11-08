//
//  DefineLib.h
//  IphoneIJiJin
//
//  Created by 梅 on 13-3-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef IphoneIJiJin_DefineLib_h
#define IphoneIJiJin_DefineLib_h


#define HOMETABITEMTAG  0 //首页选项卡TAG值
#define MYFUNDTABITEMTAG 1 //我的基金选项卡TAG值
#define FUNDTRADETABITEMTAG 2//基金交易选项卡TAG值

#define MORETABITEMTAG 3//更多选项卡TAG值

#define  kDTSearchListCache @"DTSearchListCache"

//SDK中传入手炒登录用户的accountName
#define IHEXIN_ACCOUNT_NAME @"IHexinAccountName"

#define IHexinAppID @"303191318"
#define IFundAPPID @"641426648"
#define AppstoreLink              @"http://itunes.apple.com/us/app/id%@"


#define SYBIntroductionLink         @"http://fund.10jqka.com.cn/mobilesyb/newsyb.html"

#define RequestParamURL @"http://fund.ijijin.cn/interface/net/minfo/%@_%@_%d_%d_%@_%@_%@_%@_0_0"
#define RequestParamURL_test @"http://172.20.204.25/interface/net/minfo/%@_%@_%d_%d_%@_%@_%@_%@_0_0"

#define RequestFilterParamURL @"http://fund.ijijin.cn/interface/net/minfo/%@_%@_%d_%d_%@_%@_%@_%@_%@_%@"

//#define PushURL @"http://push.10jqka.com.cn/interface/thsTools.php"
//#define PushURL @"http://172.20.0.224/interface/thsTools.php"

//用于判断设备是否为iphone4/4s(3.5inch)
#define IS_IPHONE4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
//用于判断设备是否为iphone5/5s(4.0inch)
#define IS_IPHONE5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//用于判断设备是否为iphone6(4.7inch)
#define IS_IPHONE6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
//用于判断设备是否为iphone6plus(5.5inch)
#define IS_IPHONE6PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

//用于判断系统版本是否为iOS6及以上
#define IS_IOS6 ([[UIDevice currentDevice].systemVersion doubleValue]  >= 6.0)
//用于判断系统版本是否为iOS7及以上
#define IS_IOS7 ([[UIDevice currentDevice].systemVersion doubleValue]  >= 7.0)
//用于判断系统版本是否为iOS8及以上
#define IS_IOS8 ([[UIDevice currentDevice].systemVersion doubleValue]  >= 8.0)


#define IMG_BACK @"Back"
#define IMG_SEARCH @"searchIcon"
#define IMG_MORE @"homeMoreIcon"

#define SCROLLERVIEWHEIGHT 411
#define LOVEFUND @"爱基金"
#define DAILYNETWORTH @"每日净值"
#define INCOMERANK @"收益排行"
#define MORE @"更多"
#define FINANCEBAO @"理财宝"
#define FINANCIALLITERACY @"理财入门宝典"

#define FONTSIZEOFNITEEN 17.f
#define KEY_WECHAT_APPID @"wx7a27ebafe6222290"

#define IFundAPPURLScheme @"hexinIjijin"

#define NotifyAppActive @"notifyAppActive"
#define NotifyAppEnterBackground @"notifyAppEnterBackground"
#define NotifyFilterViewDidDisappear @"filterViewDidDisappear"
#define NotifyPageEndStatistics      @"NotifyPageEndStatistics"
//#define kShouldShowLockGeturePwd     @"shouldShowLockGesturePwd"
#define kShouldShowSetGesturePwd     @"shouldShowSetGesturePwd"
#define kSetGesturePwdSuccess        @"setGesturePwdSuccess"
#define kExitLogionNotification      @"exitLogionNotification"
#define kUnlockGesturePwdSuccess        @"unlockGesturePwdSuccess"


//razor统计相关
#define UMSAGENT_URL @"http://stat.cbas.myhexin.com:8080/razor/index.php?"
#define UMSAGENT_APPKEY @"7e5cb3ccb08397a105eda5e2e01622ec"

#define UMSAGENT_TEST_URL @"http://172.20.0.243/razor/index.php?"

//app store点评界面
#define MAKE_SCORE              @"http://itunes.apple.com/cn/app/tong-hua-shun-ai-ji-jin-ji/id641426648?mt=8"

//了解爱基金页面
#define MORE_ABOUT_IJIJIN @"http://fund.10jqka.com.cn/public/about_mob/index.html"

//更多页面微信分享
#define WeChatShare_WEB @"http://fund.10jqka.com.cn/public/about_mob/share_ios.html"

#define NotifyFundUpdate @"notifyFundAdd"
#define UpdateKey @"fundUpdate"
#define FundCodeKey @"fundCode"
#define NotifyHftUpdate @"notifyHftUpdate"
#define UpdateHft @"HftUpdate"

#define kIFundApplicationDidBecomeActionNotification @"kIFundApplicationDidBecomeActionNotification"

#define kTabbarControllerDidSelectTabIndexNotification @"kTabbarControllerDidSelectTabIndexNotification"

//伪push 缓存的KEY
#define kPseudoPushResponseCache @"kPseudoPushResponseCache"

//是否已经显示过每日盈亏页面的缓存KEY
#define kHasShowDailyProfitCache @"kHasShowDailyProfitCache"

//通知中心 缓存的KEY
#define kNoticeMessageResponseCache @"kNoticeMessageResponseCache%@"

//完成版本更新请求的通知
#define kdidFinishUpdateVersionCheckNotification @"kdidFinishUpdateVersionCheckNotification"

//七日年华收益率 缓冲的KEY
#define kMaxSevenDayIncomeResponseCache @"kMaxSevenDayIncomeResponseCache"

//启动图  缓冲的KEY
#define kLaunchImageResponseCache @"kLaunchImageResponseCache"

//首页 head请求 缓冲的KEY
#define kHomeHeadResponseCache @"kHomeHeadResponseCache"

//首页 head请求 控制给赞接口字段KEY
#define kCommentResponse @"comment"
//首页 notice
#define kHomeNoticeResponseCache @"kHomeNoticeResponseCache"

//首页 middle请求 缓冲的KEY
#define kHomeMiddleResponseCache @"kHomeMiddleResponseCache"

//首页 bottom请求 缓冲的KEY
#define kHomeBottomResponseCache @"kHomeBottomResponseCache"

//首页 热点投资请求 缓冲的KEY
#define kHomeHotInvestorResponseCache @"kHomeHotInvestorResponseCache"

//首页 基金社区请求 缓冲的KEY
#define kHomeCommunityResponseCache @"kHomeCommunityResponseCache"

//用户是否已经发送意见反馈的标示量
#define kUserHasSentAppComment @"kUserHasSentAppComment"

//是否需要显示意见反馈的标示量
#define kShouldShowCommentIndicate @"kShouldShowCommentIndicate"

//得到意见反馈的客户端反馈请求的通知
#define kShowGetCommentFeedbackNotification @"kShowGetCommentFeedbackNotification"

//更多页面显示给赞接口标识
#define kShouldShowCommentCell @"kShouldShowCommentCell"

//获取到新的首页Head信息的通知
#define kNewHomeHeadNotification @"kNewHomeHeadNotification"

//获取到新的首页Middle信息的通知
#define kNewHomeMiddleNotification @"kNewHomeMiddleNotification"

//获取到新的首页Bottom信息的通知
#define kNewHomeBottomNotification @"kNewHomeBottomNotification"

//获取到新的首页热点投资的通知
#define kNewHomeHotInvestorNotification @"kNewHomeHotInvestorNotification"

//获取到新的首页Community信息的通知
#define kNewHomeCommunityNotification @"kNewHomeCommunityNotification"

//获取到积分签到底部条信息的通知
#define kIntegralSignBottomInfoNotification @"kIntegralSignBottomInfoNotification"

//获取到新的Notice信息的通知
#define kNewHomeNoticeNotification @"kNewHomeNoticeNotification"

#define FinishRequestRemoteADNotify @"finishRequestRemoteADNotify"
#define FinishRequestWednesdayNotify @"finishRequestWednesdayNotify"

//当收益宝基金购买/赎回/转换成功时给收益宝余额界面发送通知
#define SYBBalanceTableNeedRefreshNotify @"SYBBalanceTableNeedRefreshNotify"
//当买入基金成功时给个基界面发送通知
#define kPurchaseFundSuccessNotify @"PurchaseFundSuccessNotify"

//当登出时通知清除缓存
#define kClearCachesWhenLogOutNotify @"kClearCashWhenLogOutNotify"

//当正在请求同花顺手机炒股关联ID时
#define kDoingUserIDRequestNotification @"kDoingUserIDRequestNotification"

//通知清空本地自选数据
#define kClearLocalSelfFundDataNotification @"kClearLocalSelfFundDataNotification"

//通知登录成功将要返回自选页面
#define kLoginFinishAndWillBackToMyFundNotification @"kLoginFinishAndWillBackToMyFundNotification"

//当同花顺手机炒股关联ID请求完成时
#define kFinishUserIDRequestNotification @"kFinishUserIDRequestNotification"

//通知更新普通型自选基金列表
#define kUpdateSelfTableNotification_nothbx @"kUpdateSelfTableNotification_nothbx"

//通知更新货币型自选基金列表
#define kUpdateSelfTableNotification_hbx @"kUpdateSelfTableNotification_hbx"

//当初始化请求得到数据后
#define kInitializeRequestFinishedNotification @"kInitializeRequestFinishedNotification"

////URL
//#if TARGET_IPHONE_SIMULATOR
//    #define WednesdayUrl        @"http://172.20.204.25/mInterface/wednesday.txt"
//
//    #define AdvertUrl           @"http://172.20.204.25/mInterface/ios_mobile.txt"
//
//    #define HomePromptUrl       @"http://172.20.204.25/mInterface/ios_news.txt"
//
//    #define ShareSuccessUrl       @"http://172.20.204.25/hongbao/share.php?userid=%@"
//
//    #define SUGGESTION_ADDRESS      @"http://testm.10jqka.com.cn/htdocs/eq/iphone_2th/suggestion.php?appver=2.90.01&for=fund&type=%@&sdkn=%@&serverAddr=&deviceid=%@"
//
//    #define RETURN_SUGGESTION       @"http://testm.10jqka.com.cn/htdocs/eq/interface/hasSuggestBacked.php?for=fund&appver=2.90.01&platform=iphone&type=%@&sdkn=%@&serverAddr=&deviceid=%@"
//#else
//    #define WednesdayUrl          @"http://fund.10jqka.com.cn/mInterface/wednesday.txt"
//
//    #define AdvertUrl             @"http://fund.10jqka.com.cn/mInterface/ios_mobile.txt"
//   // #define AdvertUrl             @"http://172.20.204.25/mInterface/ios_mobile.txt"
//
//
//    #define HomePromptUrl         @"http://fund.10jqka.com.cn/mInterface/ios_news.txt"
//
//    #define ShareSuccessUrl       @"http://fund.10jqka.com.cn/hongbao/share.php?userid=%@"
//    //#define ShareSuccessUrl       @"http://172.20.204.25/hongbao/share.php?userid=%@"
//
//    #define SUGGESTION_ADDRESS      @"http://eq.10jqka.com.cn/iphone_2th/suggestion.php?appver=2.90.01&for=fund&type=%@&sdkn=%@&serverAddr=&deviceid=%@"
//
//    #define RETURN_SUGGESTION       @"http://eq.10jqka.com.cn/interface/hasSuggestBacked.php?for=fund&appver=2.90.01&platform=iphone&type=%@&sdkn=%@&serverAddr=&deviceid=%@"
//#endif

#define  kDTSearchListCache @"DTSearchListCache"

#define  IFNavigatorProtocol @"hft://tab/%ld/%@"


#define HTErrorDomain @"HTErrorDomain"

typedef NS_ENUM(int, DTFundPeriod)
{
    PeriodOneYear = 1,     // 近一年
    PeriodTwoYear = 2,     // 近两年
    PeriodThreeYear = 3,     // 近三年
    PeriodFiveYear = 4,     // 近五年
};

typedef NS_ENUM(int, IFBonusType)
{
    IFBonusTypeUnKnow = 0,     // 不可知
    IFBonusTypeConvertible = 3122,     // 可兑换
};

//请求类型
typedef NS_ENUM(NSUInteger, HTRequestType) {
    HTRequestTypeRefresh = 0,
    HTRequestTypeLoadingMore = 1
};

// 定投宝基金类型
typedef NS_ENUM(int, DTFundType)
{
    DTFundTypeAll = 0,     // 全部
    DTFundTypeGPX = 1,     // 股票型
    FundTypeZSX = 2,     // 指数型
    FundTypeZQX = 3,     // 债卷型
    FundTypeQDII = 4     // QDII
};

// 成功页面类型
typedef NS_ENUM(int, IFSucceedType)
{
    IFSucceed_Purchase = 0,     // 购买成功
    IFSucceed_Recharge = 1,     // 充值成功
    IFSucceed_Subscribe = 2,     // 认购成功
    IFSucceed_Switch = 3,     // 转换成功
    IFSucceed_Redemption = 4,     // 赎回成功
    IFSucceed_Enchashment = 5,     // 取现成功
    IFSucceed_DT = 6,     // 定投成功
    IFSucceed_FastEnchashment = 7     // 快速取现成功

};

// 基金购买或者定投成功返回页面controller
typedef NS_ENUM(int, IFNavigatorType)
{
    IFNavigatorType_Default = 0,          //default
    IFNavigatorType_SingleFund = 1,       // 个基页面
    IFNavigatorType_Position = 2,         // 持仓市值页面
    IFNavigatorType_ShouYiBao = 3,        //收益宝首页页面
    IFNavigatorType_ShouYiBaoBalance = 4,        //收益宝余额页面
    IFNavigatorType_ShouYiBaoBuy = 5,     //收益宝购买界面
    IFNavigatorType_ShouYiBaoFundList = 6,//收益宝产品列表界面
    IFNavigatorType_MainPageView = 7,     //基金交易首页
    IFNavigatorType_RootView = 8,          //堆栈首页
    IFNavigatorType_TransactionRecord = 9,     //交易记录
    IFNavigatorType_fundPurchase = 10,         //基金购买
    IFNavigatorType_funddtinit = 11,           //定投
    IFNavigatorType_investmentPlan = 12,       //
    IFNavigatorType_purchaseSearch  = 13,     //购买搜索
    IFNavigatorType_PopBack = 14,          //返回到原来页面
    IFNavigatorType_IntegralSign = 15,     //积分签到页面
    IFNavigatorType_FundIncome = 16,     //单基金明细页面
    IFNavigatorType_AssetsDetail = 17,     //资产明细页面
    IFNavigatorType_FromOtherTab = 18,   //从其他页面跳进交易页面的表示量
    IFNavigatorType_Login = 19,     //登录页面
    IFNavigatorType_GestureLock = 20,     //手势密码登录
    IFNavigatorType_MyFund = 21,    //自选页面
    IFNavigatorType_Web = 22,            //网页跳转
    IFNavigatorType_noDTView = 23,   //无定投计划
    IFNavigatorType_purchaseConfirm = 24, //交易确认页面
    IFNavigatorType_DTConfirm = 25,        //定投确认页面
    IFNavigatorType_TransferConfirm = 26,         //转换确认页面
    IFNavigatorType_DTEditConfirm = 27,           //定投编辑确认页面
    IFNavigatorType_DTOperate = 28,              //定投操作页面
    IFNavigatorType_FundRedemption = 29,       //赎回页面
    IFNavigatorType_FastFundRedemption = 30,       //收益宝赎回页面
    IFNavigatorType_ShortFundRedemption = 31,       //短期理财赎回页面
    IFNavigatorType_ShareBonus = 32,            //分红设置页面
    IFNavigatorType_CommunityDetailWeb = 33,   //基金社区详情页面
    IFNavigatorType_CheckPWDForBankCard = 34   //添加银行卡输入密码页面
};


// 个基页面购买类型
typedef NS_ENUM(int, IFPuachaseButtonType)
{
    IFPuachaseButtonTypeNotDefine = 0,     //没有定义
    IFPuachaseButtonTypeCanBuy = 1,     // 可以购买
    IFPuachaseButtonTypeCanNotBuy = 2,     // 不能购买
    IFPuachaseButtonTypeSuspendBuy = 3,     // 暂停购买
};

// 错误类型
typedef NS_ENUM(int, DTErrorCode)
{
    DTErrorNoData = 0,     // 没有数据
    DTErrorFailed = 1,     // 请求失败
    DTErrorDataInvalid = 2,     // 返回数据格式错误

};


// 时间格式
typedef NS_ENUM(int, IFDateFormatType)
{
    IFDateFormatTypeNormal = -1,     // 普通格式
    IFDateFormatTypeToday = 0,     // 今天
    IFDateFormatTypeYesterday = 1,     // 昨天
    IFDateFormatTypeEarlier = 2,     // 更早
};


typedef enum  {
	HXHUDTypeNONetWork,
	HXHUDTypeNormal
}HXHUDType;

// 基金类型
typedef NS_ENUM(int, IFFundType)
{
    IFFundTypeHBX = 0,     // 货币性
    IFFundTypeNormal = 1,     //普通型
    IFFundTypeLCB = 2,     // 理财宝
};


#define IFNETWORK_CONNECTION_BUILT_FAIL        @"IFnetwokConnectionBuiltFail"

#define IFNETWORK_CONNECTION_BUILT_CODE_CONNECTIONFAIL   110

#define IFNETWORK_CONNECTION_BUILT_CODE_NODATA   111
#define IFNETWORK_CONNECTION_BUILT_CODE_DATAERROR   112

// 定义首页页面布局
#define IFHOME_LAYOUT_ONE   @"10001"
#define IFHOME_LAYOUT_TWO   @"10002"
#define IFHOME_LAYOUT_THREE   @"10003"
#define IFHOME_LAYOUT_FOUR   @"10004"
#define IFHOME_LAYOUT_FIVE   @"10005"
#define IFHOME_LAYOUT_SIX   @"10006"
//基金社区cookie链接
#define GET_COOKIE   @"http://fund.10jqka.com.cn/php/cookie.php?sys=iossdk?deviceid=%@&custid=%@&version=%@"
//基金社区详情页面点击“提问”时若要登录，登录与社区详情页之间的通信－通过通知
#define kLoginFinshedAndReturnCommunityDetailNotification   @"LoginFinshedAndReturnCommunityDetailNotification"
#define kLoadCommunityCookieSuccessNotification @"LoadCommunityCookieSuccessNotification"
#define kLoadCommunityCookieFailedNotification  @"LoadCommunityCookieFailedNotification"
//基金社区列表页面导航栏title
#define kCommunityListTitle @"基金社区"

#endif


#define TABBAR_COLOR [UIColor colorWithRed:245.0 / 255 green:245.0 / 255 blue:245.0 / 255 alpha:1.0]  //底部tabbar栏的颜色



/*
 页面之间传递的参数的key和value
 */
#define FUND_TYPE_KEY   @"fundType"  //基金类型
#define FUND_TYPE_VALUE @"commonFund"//普通基金

#define JUST_SHOW_REDEEM_KEY   @"justShowRedeem"//仅仅显示赎回费率
#define JUST_SHOW_REDEEM_VALUE @"YES"





/*
 不支持赎回业务的提醒
 */
#define     UNAVAILABLE_REASON_KEY @"shinfo" //从comminfo接口返回的字段，该key值对应的value就是不支持赎回的原因
#define     UNAVAILABLE_REASON_MESSAGE     @"常见原因：1、新基金成立后， 一般有不超过3个月的封闭期，期间不可交易；2、基金公司公告的其他情形，详见基金公告；"         //如果comminfo接口没有返回shinfo，或者返回失败，那么默认显示该提示信息
#define     UNAVAILABLE_REASON_TITLE    @"基金状态不允许发起该业务"
