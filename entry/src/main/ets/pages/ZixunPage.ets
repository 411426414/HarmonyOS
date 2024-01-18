import CommonConstants from '../constants/CommonConstants'

import { ClassInfoListItem } from '../viewmodel/ClassInfoListItem'
import promptAction from '@ohos.promptAction'
import { InfoListItem } from '../viewmodel/InfoListItem'
import { ClassInfoList, ZixunInfoList } from '../api/graduation'
import StyleConstants from '../constants/StyleConstants'


@Entry
@Component
export default struct ZixunPage {
  @State message: string = 'ZixunPage'
  @State currIndex: number = 0
  @State ClassInfoList: Array<ClassInfoListItem> = []

  onPageShow() {
    ClassInfoList()
      .then((res) => {
        console.log('res', JSON.stringify(res))
        this.ClassInfoList = res.data
      })
  }

  build() {
    Column() {
      // Tabs组件
      TabsBar({ ClassInfoList: $ClassInfoList })
    }
    .height('100%')
  }
}

@Component
struct TabsBar {
  @State currentIndex: number = 0
  @Link ClassInfoList: Array<ClassInfoListItem>
  @State InfoList: Array<InfoListItem> = []
  @State type: number = 0
  @State search: string = ''

  build() {
    Stack() {
      Row() {
        Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
          ForEach(this.ClassInfoList, (item, index) => {
            TabContent() {
              // Text(item.name).fontSize($r('app.float.common_text_size')).fontWeight(FontWeight.Medium)
              ZiXunContentList({ infoList: $InfoList })
                .height(100)

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
    }.height('88%')
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

  build() {
    List({ space: 8 }) {
      ForEach(this.infoList, (item: InfoListItem, index: number) => {
        ListItem() {
          Column() {
            Row() {
              Column() {
                Text(item.title).fontSize(16).fontWeight(FontWeight.Bold)
                if (item.price) {
                  Text(`￥${item.price}`).fontSize(12).fontColor(Color.Red)
                    .padding({ top: 5, bottom: 5 })
                }

                if (item.videofile) {
                  Video({
                    previewUri: 'https://shopro.411426414.top' + item.coverimage,
                    src: 'http://shopro.411426414.top' + item.videofile
                  }).height(100).width('100%')
                  // .autoPlay(true)
                  // .controls(true)
                }
                Row() {
                  Text(`浏览${item.viewcount}次`).fontSize(12).fontColor(Color.Gray)
                  Divider().backgroundColor(Color.Gray).width(1).height(15).margin({ left: 10, right: 5 })
                  Text(`${item.publishtime}`).fontSize(12).fontColor(Color.Gray)
                }
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              if (item.coverimage) {
                Image('https://shopro.411426414.top' + item.coverimage)
                  .borderRadius($r('app.float.swiper_radius'))
                  .height(50)
                  .width(50)
              }
            }
            .alignItems(VerticalAlign.Center)
          }
          .width(StyleConstants.COMMON_WIDTH)
          .borderRadius(10)
          .margin({ top: index == 0 ? 10 : 0, left: 10, right: 10, bottom: index == this.infoList.length ? 10 : 0 })
          .padding({ left: 15, top: 15, bottom: 15, right: 15 })
          .backgroundColor(Color.White)
        }
      })
    }
    .backgroundColor('#ffd2cfcf')
  }
}