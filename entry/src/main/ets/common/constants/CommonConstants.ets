/**
 * 华为设备有限公司版权所有
 * 根据Apache许可证2.0版(“许可证”)进行许可;
 * 除非遵守许可，否则您不得使用此文件。
 * 您可以在以下网址获得许可证的副本
 * http://www.apache.org/licenses/LICENSE-2.0
 * 除非适用法律要求或书面同意，软件根据许可证分发的*是按“现状”分发的，
 * 不提供任何明示或暗示的保证或条件。
 * 请参阅许可证，了解具体的语言管理权限和许可证下的限制。
 */

/**
 * Common constants for all features.
 * 所有特性的公共常量
 */
export default class CommonConstants {

  static readonly READ_TIMEOUT: number = 5000;
  static readonly CONNECT_TIMEOUT: number = 5000;
  /**
   * The main ability tag.
   * 主Ability标签
   *
   */
  static readonly TAG_ABILITY: string = 'EntryAbility';

  /**
   * The login page tag.
   * 登录页面标签
   */
  static readonly TAG_LOGIN_PAGE: string = 'LoginPage';

  /**
   * The main page tag.
   *  主页面标签
   */
  static readonly TAG_MAIN_PAGE: string = 'MainPage';

  /**
   * The common utils tag.
   * 公用utils标签
   */
  static readonly TAG_COMMON_UTILS: string = 'CommonUtils';

  /**
   * The mine page list item cell tag.
   * 我的页面列表项单元格标记
   */
  static readonly TAG_LIST_ITEM: string = 'ListItem';

  /**
   * The mine page tag.
   * 我的页面标签
   */
  static readonly TAG_MINE_PAGE: string = 'MinePage';

  /**
   * Login text.
   * 登录文本
   */
  static readonly LOGIN_TEXT: string = 'login';

  /**
   * Toast duration.
   * 提示框持续时间
   */
  static readonly TOAST_DURATION: number = 3000;

  /**
   * Title text of the home page.
   * 主页的标题文本
   */
  static readonly HOME_TITLE: string = '首页';

  /**
   * Title text of the setting page.
   * 我的页的标题文本
   */
  static readonly MINE_TITLE: string = '我的';

  /**
   * Title text of the setting page.
   * 有轨电车页的标题文本
   */
  static readonly TRAM_TITLE: string = '有轨电车';

  /**
   * Home tab index.
   * 主页标签索引
   */
  static readonly HOME_TAB_INDEX: number = 0;

  /**
   * Mine tab index.
   * 有轨电车页标签索引
   */
  static readonly TRAM_TAB_INDEX: number = 1;

  /**
   * Mine tab index.
   * 我的页标签索引
   */
  static readonly MINE_TAB_INDEX: number = 2;

  /**
   * Swiper cache count of the number 3.
   * Swiper刷缓存计数的数字3
   */
  static readonly SWIPER_CACHE_COUNT: number = 3;

  /**
   * Main page url.
   * 主页文件地址
   */
  static readonly MAIN_PAGE_URL: string = 'pages/MainPage';

  /**
   * Login page url.
   * 登录页文件地址
   */
  static readonly LOGIN_PAGE_URL: string = 'pages/LoginPage';

  /**
   * Break point sm of the tag.
   *
   */
  static readonly SM: string = 'sm';

  /**
   * Break point md of the tag.
   */
  static readonly MD: string = 'md';

  /**
   * Break point lg of the tag.
   */
  static readonly LG: string = 'lg';

  /**
   * Width condition sm filter.
   * sm宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_SM: string = '(320vp<=width<520vp)';

  /**
   * Width condition md filter.
   * md宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_MD: string = '(520vp<=width<840vp)';

  /**
   * Width condition lg filter.
   * lg宽度条件滤波器
   */
  static readonly WIDTH_CONDITION_LG: string = '(840vp<=width)';

  /**
   * Login page button id.
   * 登录页面按钮id
   */
  static readonly LOGIN_BUTTON_ID: string = 'loginButtonId';

  /**
   * Tablet device type.
   * 平板设备类型
   */
  static readonly TABLET_DEVICE_TYPE: string = 'tablet';
}
