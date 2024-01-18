import { ClassInfoList } from '../api/graduation';
import { CommonDataSource } from '../utils/CommonDataSource';
import { Commodity } from '../viewmodel/CommondityModel'
import { commodityData } from '../viewmodel/ShopData'
import EmptyPage from './EmptyPage';

@Component
export default struct CommodityList {
  @Link commodityData: Commodity[]
  @Prop column: number;
  private commonDataSource = new CommonDataSource<Commodity>(this.commodityData)

  build() {
    if (this.commodityData.length > 0) {
      List({ space: 6 }) {
        // 遍历商品数组,生成商品列表
        LazyForEach(this.commonDataSource, (item: Commodity) => {
          ListItem() {
            this.ProductItem(item)
          }
          .onClick(() => {
            if (this.onItemClick !== undefined) {
              this.onItemClick(item)
            }
          })
          .margin({ left: 6, right: 6 })
          .borderRadius(15)
        }, item => item.id)
      }
      .margin({ left: -6, right: -6 })
      .listDirection(Axis.Vertical)
      .lanes(2)
    } else {
      // 加载空页面
      EmptyPage()
    }
  }

  @Builder
  ProductItem(info: Commodity) {
    Column() {
      Image(
          (info.image.indexOf('https') != -1 || info.image.indexOf('http') != -1)
          ? info.image
          : 'https://v3.shopro.top' + info.image
      )
        .width('100%')
        .objectFit(ImageFit.Contain)
        .borderRadius(15)
      Column() {
        Text(info.title)
        Text(info.price + '')
      }
      .width('100%')
      .margin({ top: 6 })
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 6, bottom: 6 })
    }
    .borderRadius(15)
    .backgroundColor(Color.Gray)
    .margin({ top: 6 })
  }

  // 父组件传递一个事件函数,当子组件的商品被点击时,调用该事件函数,并把被点击的商品传递给它
  private onItemClick? = (Commodity: Commodity) => {
  }
}