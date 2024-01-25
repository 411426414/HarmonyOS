import { BannerList, ClassInfoList, ZixunInfoList } from '../api/graduation'
import { BannerItem } from '../viewmodel/BannerModel'
import StyleConstants from '../constants/StyleConstants'
import { Commodity } from '../viewmodel/CommondityModel'
import { commodityData, commodityData1 } from '../viewmodel/ShopData'
import router from '@ohos.router'

@Entry
@Component
export default struct HomePage {
  @State message: string = 'HomePage'
  @State swiperList: Array<BannerItem> = [{ "coverimage": "/uploads/20230318/5060835d87b8a2383f1eb7e1ec8b2743.png", }]
  @State commodityList: Commodity[] = []

  aboutToAppear() {
    this.commodityList = commodityData
    BannerList()
      .then((res) => {
        this.swiperList = res.data
      })
      .catch(err => {
        console.log('onPageShow', JSON.stringify(err))
      })
  }

  // 父组件传递事件函数
  onItemClick(data: Commodity) {
    console.log('data', data.title)
    // 业务的跳转查询
  }

  build() {
    Column({ space: 8 }) {
      Stack({ alignContent: Alignment.Top }) {
        Flex({ direction: FlexDirection.Column }) {
          Scroll() {
            Column() {
              this.SwiperBox(this.swiperList)

              this.ClassInfo(4)
              Button('配置页面')
                .margin({ top: 20 })
                .width(StyleConstants.BUTTON_WIDTH)
                .height(40)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/Device/DeviceInfoPage' })
                })

              Button('数据库')
                .margin({ top: 20 })
                .width(StyleConstants.BUTTON_WIDTH)
                .height(40)
                .onClick(() => {
                  router.pushUrl({ url: 'pages/TaskManage/TaskManagePage' })
                })

              // CommodityList({
              //   commodityData: $commodityList,
              //   column: 2,
              //   // 把函数传递给了子组件,子组件通过这个函数来调用父组件传递过来的事件函数， 触发onItemClick，并且把data值传回来
              //   onItemClick: (data: Commodity) => this.onItemClick(data)
              // })
            }
          }
        }
      }
    }
    .margin($r('app.float.common_margin'))
  }

  @Builder
  SwiperBox(swiperList: BannerItem[]) {
    // 轮播图
    Swiper() {
      ForEach(this.swiperList, (item: BannerItem) => {
        Image('https://gzh.411426414.top' + item.coverimage)
          .borderRadius($r('app.float.swiper_radius'))
        // .objectFit(ImageFit.Contain)
      }, (item: BannerItem) => JSON.stringify(item))
    }
    .width(StyleConstants.FULL_PARENT)
    .height(200)
    .autoPlay(true)
    .margin({ bottom: 5 })
  }

  @Builder
  ClassInfo(column: number = 4) {
    // 分类信息
    List() {
      ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number, index: number) => {
        ListItem() {
          Column() {
            Image($r('app.media.img')).width(30).borderRadius(15).margin({ bottom: 5 })
            Text('N' + item)
          }
          // .alignItems(HorizontalAlign.Center)
          // .justifyContent(FlexAlign.Center)
          // .padding({ top: index < column ? 5 : 0, bottom: 5, left: 5, right: 5 })
          // .width(StyleConstants.FULL_PARENT)
          .width(50)
        }
      })
    }
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.None)
    .margin({ left: '6.7%' })
    .width('93.3%')
    .height('14.4%')
  }
}
