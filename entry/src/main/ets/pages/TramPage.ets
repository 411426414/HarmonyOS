import { WaterFlowDataSource } from '../utils/WaterFlowDataSource'
import { Commodity } from '../viewmodel/CommondityModel'
import { commodityData } from '../viewmodel/ShopData'

@Entry
@Component
export default struct TramPage {
  @State commodityList: Commodity[] = []
  scroller: Scroller = new Scroller()
  private datasource
  private itemWidthArray: number[] = []
  private itemHeightArray: number[] = []

  aboutToAppear() {
    this.commodityList = commodityData
    this.getItemSizeArray(commodityData)
    this.datasource = new WaterFlowDataSource(commodityData)
  }

  // 保存flow item宽/高
  getItemSizeArray(data) {
    data.forEach((item: Commodity, index) => {
      if (item.image_wh !== null) {
        // this.itemWidthArray.push(Number(item.image_wh.w))
        this.itemHeightArray.push(
          Number(item.image_wh.h) / (Number(item.image_wh.w) / 163)
        )
      }
    })
  }

  build() {
    Column() {
      this.WeatherBox()
    }
  }

  @Builder itemFoot() {
    Column() {
      Text(`Footer`)
        .fontSize(10)
        .backgroundColor(Color.Red)
        .width(50)
        .height(50)
        .align(Alignment.Center)
        .margin({ top: 2 })
    }
  }

  @Builder WeatherBox() {
    Column({ space: 6 }) {
      // footer: this.itemFoot.bind(this),
      WaterFlow({ scroller: this.scroller }) {
        LazyForEach(this.datasource, (item: Commodity, index: number) => {
          FlowItem() {
            Column() {
              Image((item.image.indexOf('https') != -1 || item.image.indexOf('http') != -1) ? item.image : 'https://v3.shopro.top' + item.image)
                // .width('163vp')
                .width('100%')
                .height(this.itemHeightArray[index])
                .objectFit(ImageFit.Contain)
                .borderRadius(15)
              Column() {
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)

                Text('￥' + item.price)
                  .fontSize(12)
                  .height('16')
                  .margin({ top: 5 })
                  .fontColor(Color.Red)
                  .fontWeight(FontWeight.Bold)

                Flex({
                  wrap: FlexWrap.Wrap,
                  alignContent: FlexAlign.Start
                }) {
                  //  判断是否是上架中
                  Text(item.status_text)
                    .fontSize(8)
                    .height('16')
                    .backgroundColor(Color.Green)
                    .borderRadius(5)
                    .padding({ left: 5, right: 5 })
                    .margin({ top: 5, right: 5 })

                  // 判断是否是虚拟商品
                  Text(item.type_text)
                    .fontSize(8)
                    .height('16')
                    .backgroundColor(Color.Orange)
                    .borderRadius(5)
                    .padding({ left: 5, right: 5 })
                    .margin({ top: 5, right: 5 })

                  // 判断是否是自动发货
                  Text(item.dispatch_type_text)
                    .fontSize(8)
                    .height('16')
                    .backgroundColor(Color.Yellow)
                    .borderRadius(5)
                    .padding({ left: 5, right: 5 })
                    .margin({ top: 5, right: 5 })
                }
              }
              .alignItems(HorizontalAlign.Start)
              .padding({ top: 6, bottom: 6, left: 6, right: 6 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .borderRadius(15)
          .margin({ left: 6, right: 6 })
          .backgroundColor('#ffececec')
        }, item => item)
      }
      .columnsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(5)
      // .backgroundColor(0xFAEEE0)
      .width('100%')
      .height('100%')
      .layoutDirection(FlexDirection.Column)
      .itemConstraintSize({
        minWidth: 0,
        maxWidth: '100%',
        minHeight: 0,
        maxHeight: '100%'
      })
      .onReachStart(() => {
        console.info("onReachStart")
      })
      .onReachEnd(() => {
        console.info("onReachEnd")
      })
    }
  }
}