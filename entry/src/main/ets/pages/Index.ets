import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import HomePage from './HomePage';
import ZixunPage from './ZixunPage';
import TramPage from './TramPage';
import MinePage from './MinePage';
import AddressPage from './Device/AddressPage';
import HuaweiPage from './HuaweiPage';

/**
 * 首页显示“首页”和“我的页面”。
 * 用法:开发者定义页面并在TabContent中引用它们
 */
@Entry
@Component
struct Index {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State currentIndex: number = CommonConstants.HOME_TAB_INDEX;

  build() {
    Tabs({
      barPosition: this.currentDeviceSize === CommonConstants.LG ? BarPosition.Start : BarPosition.End,
      index: this.currentIndex
    }) {
      TabContent() {
        HomePage()
      }
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX, $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')))

      TabContent() {
        // AddressPage()
        HuaweiPage()
      }
      .tabBar(this.TabBuilder(CommonConstants.ADDRESS_TITLE, CommonConstants.ADDRESS_TAB_INDEX, $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')))

      TabContent() {
        ZixunPage()
      }
      .tabBar(this.TabBuilder(CommonConstants.ZIXUN_TITLE, CommonConstants.ZIXUN_TAB_INDEX, $r('app.media.ic_home_selected'), $r('app.media.ic_home_normal')))

      TabContent() {
        TramPage()
      }
      .tabBar(this.TabBuilder(CommonConstants.TRAM_TITLE, CommonConstants.TRAM_TAB_INDEX, $r('app.media.ic_mine_selected'), $r('app.media.ic_mine_normal')))

      TabContent() {
        MinePage()
      }
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX, $r('app.media.ic_mine_selected'), $r('app.media.ic_mine_normal')))
    }
    .barWidth(this.currentDeviceSize === CommonConstants.LG ? StyleConstants.BAR_WIDTH_LG : StyleConstants.FULL_PARENT)
    .barHeight(this.currentDeviceSize === CommonConstants.LG ? StyleConstants.BAR_HEIGHT_LG : StyleConstants.BAR_DEFAULT_HEIGHT)
    .vertical(this.currentDeviceSize === CommonConstants.LG)
    .backgroundColor('#cedbd9d9')
    .barMode(BarMode.Fixed)
    .scrollable(false)
    .onChange((index: number) => this.currentIndex = index)
  }

  @Builder TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === index ? selectedImg : normalImg)
        .width($r('app.float.base_tab_size'))
        .height($r('app.float.base_tab_size'))
      Text(title)
        .margin({ top: $r('app.float.base_tab_top') })
        .fontSize($r("app.float.tab_font_size"))
        .fontColor(this.currentIndex === index ? $r('app.color.main_page_selected') : $r('app.color.main_page_normal'))
    }
    .justifyContent(FlexAlign.Center)
    .height(StyleConstants.FULL_PARENT)
    .width(StyleConstants.FULL_PARENT)
  }
}