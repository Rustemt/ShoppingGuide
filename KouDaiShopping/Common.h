/*
控件尺寸
*/

// 1.Dock上条目的尺寸
#define kDockItemW 100
#define kDockItemH 80

// 顶部菜单项的宽高
#define kTopMenuItemW 130
#define kTopMenuItemH 44

// 底部菜单项的宽高
#define kBottomMenuItemW 130
#define kBottomMenuItemH 70

// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define MyLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define MyLog(...)
#endif

// 3.通知名称
// 城市改变的通知
#define kCityChangeNote @"city_change"
// 区域改变的通知
#define kDistrictChangeNote @"district_change"
// 分类改变的通知
#define kCategoryChangeNote @"category_change"
// 排序改变的通知
#define kOrderChangeNote @"order_change"
// 收藏改变的通知
#define kCollectChangeNote @"collect_change"

// 城市的key
#define kCityKey @"city"

#define kAddAllNotes(method) \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCityChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kCategoryChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kDistrictChangeNote object:nil]; \
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(method) name:kOrderChangeNote object:nil];


// 4.全局背景色
#define kGlobalBg [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_deal.png"]]


// 5.默认的动画时间
#define kDefaultAnimDuration 0.3


// 6.固定的字符串
#define kAllCategory @"全部分类"
#define kAllDistrict @"全部商区"
#define kAll @"全部"
