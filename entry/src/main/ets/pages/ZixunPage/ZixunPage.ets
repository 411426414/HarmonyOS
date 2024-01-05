import { expect, Level } from '@ohos/hypium';
import CommonUtils from '../../common/utils/CommonUtils';
import CommonConstants from '../../common/constants/CommonConstants';
import StyleConstants from '../../common/constants/StyleConstants';
import TextPro from '../components/TextPro'
import Constant from '../../common/constants/Constant'

@Preview
@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State sex: string[] = ['保密', '男', '女']
  @State msg: string = ''

  build() {
    Column() {
      Text($r('app.string.zixun_page'))
        .fontWeight(FontWeight.Medium)
        .fontSize($r('app.float.common_text_size'))
        .margin({
          left: this.currentDeviceSize === CommonConstants.LG ? $r('app.float.common_margin_larger') : $r('app.float.common_margin'),
          top: $r('app.float.common_margin')
        })
        .alignSelf(ItemAlign.Start)
      // 搜索组件
      SearchBar()
      // Tabs组件
      TabsBar()
      // Scroll() {}.scrollBar(BarState.Off)
    }
    .width(StyleConstants.FULL_PARENT)
    .height(StyleConstants.BUTTON_WIDTH)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SearchBar {
  build() {
    Row() {
      TextInput({ placeholder: "请输入搜索内容" })
        .type(InputType.Normal)
        .margin({ top: $r('app.float.common_margin') })
        .borderRadius($r('app.float.common_border_radius'))
        .margin({
          top: $r('app.float.common_margin'),
          left: $r('app.float.common_margin'),
          right: $r('app.float.common_margin')
        })
        .onChange((value: string) => {
        })
    }
  }
}

@Component
struct TabsBar {
  @State currentIndex: number = 0

  build() {
    Stack(){
      Row() {
        Tabs({
          barPosition: BarPosition.Start,
          index: this.currentIndex
        }) {
          TabContent() {Text("推荐").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}
          TabContent() {Text("关注").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('关注')
          TabContent() {Text("热榜").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('热榜')
          TabContent() {Text("历史").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('历史')
          TabContent() {Text("收藏").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('收藏')
          TabContent() {Text("问答").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('问答')
          TabContent() {Text("视频").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('视频')
          TabContent() {Text("图片").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('图片')
          TabContent() {Text("文章").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('文章')
          TabContent() {Text("音乐").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('音乐')
          TabContent() {Text("活动").fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)}.tabBar('活动')
        }
        // .barWidth(StyleConstants.COMMON_WIDTH)
        .width('75%')
        .barHeight(StyleConstants.BAR_DEFAULT_HEIGHT)
        .backgroundColor(Color.White)
        .barMode(BarMode.Fixed)
        .scrollable(true)
        .barMode(BarMode.Scrollable)
      }
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }
}

