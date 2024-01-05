import { expect, Level } from '@ohos/hypium';
import CommonConstants from '../../common/constants/CommonConstants';
import StyleConstants from '../../common/constants/StyleConstants';
import CommonUtils from '../../common/utils/CommonUtils';

// @Preview
@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State sex: string[] = ['男', '女']
  @Prop msg: string = ''

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
      TextPlus({
        textImage: $r('app.media.ic_search'),
        title: '性别',
        content: '',
        onItemClick: () => {
          TextPickerDialog.show({
            range: this.sex,
            onAccept: (value: TextPickerResult) => {
              // 设置select 为按下确认按钮时候的选中项的index，这样当弹框再次弹出的时候显示选中的是上一次确定的选项
              this.msg = value.value
            },
            onCancel: () => {
              console.log('取消')
            },
            onChange: (value: TextPickerResult) => {
              console.log('更改')
            }
          })
        }
      })
      TextPro({
        inputImage: $r('app.media.ic_search'),
        hintText: '昵称',
      })
      // Tabs组件
      TabsBar()
      // Scroll() {}.scrollBar(BarState.Off)
    }
    .width(StyleConstants.FULL_PARENT)
    .height(StyleConstants.BUTTON_WIDTH)
    .alignItems(HorizontalAlign.Start)
  }
}

// @Preview
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

@Preview
@Component
struct TabsBar {
  @State currentIndex: number = 0

  build() {
    Row() {
      Tabs({
        barPosition: BarPosition.Start,
        index: this.currentIndex
      }) {
        TabContent() {
          Text("推荐").fontSize($r('app.float.common_text_size'))
            .fontWeight(FontWeight.Medium)
        }

        TabContent() {
          Text("关注").fontSize($r('app.float.common_text_size'))
            .fontWeight(FontWeight.Medium)
        }

        TabContent() {
          Text("热榜").fontSize($r('app.float.common_text_size'))
            .fontWeight(FontWeight.Medium)
        }
        // TabItem({ title: "推荐" })
        // TabItem({ title: "推荐" })
        // TabItem({ title: "关注" })
        // TabItem({ title: "热榜" })
        // TabItem({ title: "历史" })
        // TabItem({ title: "收藏" })
        // TabItem({ title: "问答" })
        // TabItem({ title: "视频" })
        // TabItem({ title: "图片" })
        // TabItem({ title: "文章" })
        // TabItem({ title: "音乐" })
        // TabItem({ title: "活动" })
      }
      // .height($r('app.float.list_start_margin'))
      .barWidth(StyleConstants.FULL_PARENT)
      .barHeight(StyleConstants.BAR_DEFAULT_HEIGHT)
      // .vertical(this.currentDeviceSize === CommonConstants.LG)
      .backgroundColor(Color.White)
      .barMode(BarMode.Fixed)
      .scrollable(false)
    }
  }
}


@Preview
@Component
struct TextPlus {
  private textImage: Resource
  @State title: string = ''
  @State content: string = ''

  onItemClick() {
  }

  build() {
    Row() {
      Image(this.textImage !== undefined ? this.textImage : '')
        .width($r('app.float.common_text_size'))
        .width($r('app.float.common_margin_bottom'))
        .margin({ left: $r('app.float.common_margin_bottom') })
      Text(this.title)
        .fontSize($r('app.float.normal_text_size'))
        .margin({ left: StyleConstants.FULL_PARENT })
        .height('100%')
      Text(this.content)
        .fontSize($r('app.float.normal_text_size'))
        .textAlign(TextAlign.End)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .margin({ left: 16, right: 7 })
        .layoutWeight(1)
        .width(StyleConstants.FULL_PARENT)
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
        .margin({ right: 14 })
    }
    .margin({ top: 24 })
    .borderRadius($r('app.float.common_border_radius'))
    .width('93.3%')
    .height(64)
    .onClick(this.onItemClick)
  }
}

@Component
struct TextPro {
  private inputImage?: Resource
  private hintText?: string

  build() {
    Row() {
      Image(this.inputImage !== undefined ? this.inputImage : '')
        .width($r('app.float.common_text_size'))
        .width($r('app.float.common_margin_bottom'))
        .margin({ left: $r('app.float.common_margin_bottom') })
      TextInput({ placeholder: this.hintText })
        .fontSize(16)
        .padding({ left: 16 })
        .placeholderColor('#99000000')
        .fontWeight(FontWeight.Normal)
        .fontStyle(FontStyle.Normal)
        .fontColor(Color.Black)
        .margin({ right: 32 })
        .layoutWeight(1)
        .height(48)
    }
    .margin({ top: 24 })
    .borderRadius(24)
    .width('93.3%')
    .height(64)
  }
}