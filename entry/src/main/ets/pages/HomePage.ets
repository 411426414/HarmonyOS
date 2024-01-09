// @ts-nocheck
import mainViewModel from '../viewmodel/MainViewModel';
import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants';
import CommonUtils from '../common/utils/CommonUtils';
import ItemData from '../viewmodel/ItemData';
import { BannerList,ClassInfoList } from '../api/graduation';
import promptAction from '@ohos.promptAction';
import  {SwiperItem, CenterGridItem} from '../viewmodel/HomePage'


@Entry
@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State SwiperListData: Array<SwiperItem> = [{
      "id": 1,
      "title": "轮播图标题",
      "coverimage": "/uploads/20230318/5060835d87b8a2383f1eb7e1ec8b2743.png",
      "type": "1",
      "briefcontent": "<span style=\"color:#333333;font-family:&quot;Source Sans Pro&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;font-size:14px;text-align:right;white-space:normal;background-color:#FFFFFF;\">详情</span>",
      "exhibits_id": null,
      "status": "1",
      "weigh": 1,
      "createtime": 1677816088,
      "updatetime": 1679128186,
      "status_text": "显示"
    }];
  @State CenterGridData: Array<CenterGridItem> = []

  build() {
    Scroll() {
      Column() {
        Text($r('app.string.main_page'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.common_text_size'))
          .margin({
            left: this.currentDeviceSize === CommonConstants.LG ? $r('app.float.common_margin_larger') : $r('app.float.common_margin'),
            top: $r('app.float.common_margin')
          })
          .alignSelf(ItemAlign.Start)
        // Swiper轮播图组件
        SwiperView({ swiperListData: $SwiperListData })
        // 中间Grid组件
        CenterGridView({ centerGridData: $CenterGridData })
        // 底部图片列表组件
        ListImageView()
      }
      .width(StyleConstants.FULL_PARENT)
      .backgroundColor($r('app.color.background'))
    }
    .scrollBar(BarState.Off)
  }

  aboutToAppear() {
    this.getBannerList()
    this.getClassInfoList()
  }

  // 轮播图
  getBannerList() {
    BannerList()
      .then(res => {
        if (res.code === 1) {
          this.SwiperListData = res.data
          console.log(res.data.toString())
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
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
struct SwiperView {
  @Link swiperListData: Array<SwiperItem>
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Column() {
      Swiper() {
        ForEach(this.swiperListData, (item: SwiperItem) => {
          Image('https://gzh.411426414.top' + item.coverimage)
            .borderRadius($r('app.float.swiper_radius'))
            .height(200)
            .width('100%')
        }, (item) => item.id)
      }
      .displayCount(this.currentDeviceSize === CommonConstants.SM ? StyleConstants.SWIPER_COUNT_ONE : (this.currentDeviceSize === CommonConstants.MD ? StyleConstants.SWIPER_COUNT_TWO : StyleConstants.SWIPER_COUNT_THREE))
      .itemSpace(this.currentDeviceSize === CommonConstants.SM ? 0 : StyleConstants.ITEM_SPACE)
      .margin($r('app.float.common_margin'))
      .width(StyleConstants.COMMON_WIDTH)
      .autoPlay(true)
    }
  }
}

@Component
struct CenterGridView {
  @Link centerGridData: Array<CenterGridItem>
  build() {
    Column() {
      Grid() {
        ForEach(this.centerGridData, (item: CenterGridItem) => {
          GridItem() {
            GridItemView({ item: item })
          }
        }, (item: CenterGridItem) => item.id)
      }   .columnsTemplate(StyleConstants.GRID_COLUMNS)   .rowsTemplate(StyleConstants.GRID_ROWS)   .columnsGap($r('app.float.grid_column_gap')) .rowsGap($r('app.float.grid_row_gap'))  .height(StyleConstants.HOME_GRID_HEIGHT)  .backgroundColor(Color.White)   .borderRadius($r('app.float.home_grid_radius'))   .padding({ top: $r('app.float.home_grid_padding'), bottom: $r('app.float.home_grid_padding') })  .width(StyleConstants.COMMON_WIDTH).margin($r('app.float.common_margin'))
    }
  }
}

@Component
struct GridItemView {
  private item?: CenterGridItem;
  private gridItemImg?: Resource;
  private name?: string;
  private gridItemPrompt?: Resource;

  aboutToAppear() {
    if (this.item !== undefined) {
      this.gridItemImg = this.item.img;
      this.name = this.item.name;
      this.gridItemPrompt = this.item.name;
    }
  }

  build() {
    Column() {
      if (this.gridItemImg) {
        Image(this.gridItemImg)
          .width($r('app.float.home_cell_size'))
          .height($r('app.float.home_cell_size'))
      }
      if (this.name) {
        Text(this.name)
          .fontSize($r('app.float.little_text_size'))
          .margin({ top: $r('app.float.home_cell_margin') })
      }
    }
    .onClick(() => {
      // 点击事件 文字为空的时候 return， 否则输出文字
      if (!this.gridItemPrompt) {
        return;
      }
      CommonUtils.showToastContent(this.gridItemPrompt);
    })
  }
}

@Preview
@Component
struct ListImageView {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;

  build() {
    Column() {
      Text($r('app.string.home_list'))
        .fontSize($r('app.float.normal_text_size'))
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({
          left: $r('app.float.common_margin'),
          top: $r('app.float.common_margin')
        })

      List({ space: StyleConstants.IMAGE_LIST_SPACE }) {
        ForEach(mainViewModel.getListImageData(), (secondItem: ItemData) => {
          ListItem() {
            ImageItemView({ secondItem: secondItem })
          }
          .margin({ right: $r('app.float.list_margin') })
          .borderRadius($r('app.float.image_list_radius'))
          .onClick(() => {
            if (!secondItem?.clickPrompt) {
              return;
            }
            CommonUtils.showToastContent(secondItem.clickPrompt);
          })
        }, (secondItem: ItemData) => JSON.stringify(secondItem.id))
      }
      .width(StyleConstants.COMMON_WIDTH)
      .margin($r('app.float.common_margin'))
      .lanes(this.currentDeviceSize === CommonConstants.SM ?
      StyleConstants.LIST_COLUMN_TWO :
        (this.currentDeviceSize === CommonConstants.MD ?
        StyleConstants.LIST_COLUMN_THREE : StyleConstants.LIST_COLUMN_FOUR))
    }
  }
}

@Component
struct ImageItemView {
  private secondItem?: ItemData;
  private listItemImage?: Resource;
  private listItemTitle?: Resource;
  private listItemOthers?: Resource;

  aboutToAppear() {
    if (this.secondItem !== undefined) {
      this.listItemImage = this.secondItem.img;
      this.listItemTitle = this.secondItem.title;
      this.listItemOthers = this.secondItem.others;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (this.listItemImage) {
        Image(this.listItemImage)
          .objectFit(ImageFit.Cover)
          .aspectRatio(StyleConstants.GRID_ASPECT_RATIO)
      }
      Column() {
        Text(this.listItemTitle)
          .fontSize($r('app.float.normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Start)
        Text(this.listItemOthers)
          .margin({ top: $r('app.float.home_list_margin') })
          .fontSize($r('app.float.little_text_size'))
          .fontColor($r('app.color.home_grid_fontColor'))
      }
      .margin({
        left: $r('app.float.item_text_margin'),
        top: $r('app.float.item_text_margin')
      })
    }
  }
}