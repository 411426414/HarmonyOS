import { expect, Level } from '@ohos/hypium';
import CommonUtils from '../../common/utils/CommonUtils';
import TextPro from '../components/TextPro'
import Constant from '../../common/constants/Constant'
import CommonConstants from '../../common/constants/CommonConstants';
import StyleConstants from '../../common/constants/StyleConstants';
import { CenterGridItem, InfoListItem } from '../../viewmodel/HomePage';
import { ClassInfoList, ZixunInfoList } from '../../api/graduation';
import promptAction from '@ohos.promptAction';

@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State sex: string[] = ['保密', '男', '女']
  @State msg: string = ''
  @State CenterGridData: Array<CenterGridItem> = []

  build() {
    Scroll() {
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
        TabsBar({ centerGridData: $CenterGridData })
        // Scroll() {}.scrollBar(BarState.Off)
      }
      .width(StyleConstants.FULL_PARENT)
      .height(StyleConstants.BUTTON_WIDTH)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor($r('app.color.background'))
    }
    .scrollBar(BarState.Off)
    .height('100%')
  }

  aboutToAppear() {
    this.getClassInfoList()
  }
  // 获取信息分类列表
  getClassInfoList() {
    ClassInfoList()
      .then(res => {
        if (res.code === 1) {
          this.CenterGridData = res.data
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
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
  @Link centerGridData: Array<CenterGridItem>
  @State InfoList: Array<InfoListItem> = []
  @State type: number = 0
  @State search: string = ''

  build() {
    Stack() {
      Row() {
        Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
          ForEach(this.centerGridData, (item, index) => {
            TabContent() {
              // Text(item.name).fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)
              ZiXunContentList({ infoList: $InfoList })
            }.tabBar(item.name)
          }, (item, index) => item.id)
        }
        .barWidth(StyleConstants.COMMON_WIDTH)
        .barHeight(StyleConstants.BAR_DEFAULT_HEIGHT)
        .barMode(BarMode.Fixed)
        .scrollable(true)
        .barMode(BarMode.Scrollable)
        .onChange((index: number) => {
          this.type = index
          this.getZixunInfoList()
        })
      }
      .justifyContent(FlexAlign.Start)
    }
  }

  aboutToAppear() {
    this.getZixunInfoList()
  }

  getZixunInfoList() {
    ZixunInfoList({
      search: this.search,
      type: this.type,
      page: 1,
      pagesize: 10
    }).then(res => {
      if (res.code === 1) {
        this.InfoList = res.data
        console.log('res.data', res.data.length)
        promptAction.showToast({ message: res.msg })
      } else {
        promptAction.showToast({ message: res.msg })
      }
    })
  }
}


@Component
struct ZiXunContentList {
  @Link infoList: Array<InfoListItem>

  build() {
    List({ space: 8 }) {
      ForEach(this.infoList, (item: InfoListItem, index: number) => {
        ListItem() {
          Column() {
            Row() {
              Column() {
                Text(item.title).fontSize(16).fontWeight(FontWeight.Bold)
                Text(`￥${item.price}`).fontSize(12).fontColor(Color.Red)
                  .padding({ top: 5, bottom: 5 })
                Row() {
                  Text(`浏览${item.viewcount}次`).fontSize(12).fontColor(Color.Gray)
                  Divider().backgroundColor(Color.Gray).width(1).height(15).margin({ left: 10, right: 5 })
                  Text(`${item.publishtime}`).fontSize(12).fontColor(Color.Gray)
                }
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Image('https://shopro.411426414.top' + item.coverimage)
                .borderRadius($r('app.float.swiper_radius'))
                .height(50)
                .width(50)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width(StyleConstants.COMMON_WIDTH)
          .borderRadius(10)
          .margin({ top: index == 0 ? 10 : 0, left: 10, right: 10 })
          .padding({ left: 15, top: 15, bottom: 15, right: 15 })
          .backgroundColor(Color.White)
        }
      })
    }
    .backgroundColor('#ffd2cfcf')
    .height('100%')
  }

  @State obj: InfoListItem = {
    "id": 25,
    "createtime": 1680933144,
    "updatetime": 1698991770,
    "title": "第四级菜单",
    "shortdesc": "图片",
    "publishtime": "2023-04-08 13:52:17",
    "coverimage": "/uploads/20230421/50765e68ac91003eae4833fd00f1486c.jpg",
    "audiofile": "",
    "videofile": "",
    "briefcontent": "",
    "price": "0.00",
    "canpointdata": "1",
    "status": "1",
    "zxviplevel_ids": "1,3,4",
    "zxviplevelname": "普通会员,精英会员,黄金会员",
    "viewcount": 61,
    "sharecount": 2,
    "recommend": "0",
    "hot": "0",
    "canpointdata_text": "允许",
    "status_text": "显示",
    "recommend_text": "否",
    "hot_text": "否"
  }
}