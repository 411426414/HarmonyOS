import mainViewModel from '../viewmodel/MainViewModel';
import CommonConstants from '../common/constants/CommonConstants';
import StyleConstants from '../common/constants/StyleConstants';
import CommonUtils from '../common/utils/CommonUtils';
import ItemData from '../viewmodel/ItemData';
import { BannerList } from '../api/graduation';
import promptAction from '@ohos.promptAction';

class SwiperItem {
  id: number = 0;
  title: string = '';
  coverimage: string = '';
  type: string = '';
  briefcontent: string = '';
  exhibits_id: number = 0;
  status: string = '';
  weigh: number = 0;
  createtime: number = 0;
  updatetime: number = 0;
  status_text: string = '';
}

@Component
export default struct HomePage {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  // private SwiperViewCon: SwiperView = new SwiperView()
  //
  // aboutToAppear() {
  //   this.SwiperViewCon.getBannerList()
  // }

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
        SwiperView()
        // 中间Grid组件
        CenterGridView()
        // 底部图片列表组件
        ListImageView()
      }
      .width(StyleConstants.FULL_PARENT)
      .backgroundColor($r('app.color.background'))
    }
    .scrollBar(BarState.Off)
  }
}


@Preview
@Component
struct SwiperView {
  @StorageProp('currentDeviceSize') currentDeviceSize: string = CommonConstants.SM;
  @State SwiperListData: Array<SwiperItem> = [
  /*{
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
  },
  {
    "id": 2,
    "title": "",
    "coverimage": "/uploads/20230318/4758b708b13d28f13b76437a2084d085.jpg",
    "type": "1",
    "briefcontent": "",
    "exhibits_id": null,
    "status": "1",
    "weigh": 2,
    "createtime": 1679128160,
    "updatetime": 1679128160,
    "status_text": "显示"
  },
  {
    "id": 3,
    "title": "宜昌园",
    "coverimage": "/assets/img/qrcode.png",
    "type": "2",
    "briefcontent": null,
    "exhibits_id": 2,
    "status": "1",
    "weigh": 3,
    "createtime": 1680234926,
    "updatetime": 1687854462,
    "status_text": "显示"
  },
  {
    "id": 4,
    "title": "",
    "coverimage": "/uploads/20230318/fb1ee56c220c47ceb84f00f929450c9f.jpg",
    "type": "2",
    "briefcontent": null,
    "exhibits_id": 2,
    "status": "1",
    "weigh": 4,
    "createtime": 1683984891,
    "updatetime": 1683984891,
    "status_text": "显示"
  }*/
  ];

  aboutToAppear() {
    this.getBannerList()
  }

  build() {
    Column() {
      Swiper() {
        ForEach(this.SwiperListData, (item: SwiperItem) => {
          Image('https://gzh.411426414.top' + item.coverimage).borderRadius($r('app.float.swiper_radius')).height(200)
        }, (item) => item.id)
      }
      .displayCount(this.currentDeviceSize === CommonConstants.SM ? StyleConstants.SWIPER_COUNT_ONE : (this.currentDeviceSize === CommonConstants.MD ? StyleConstants.SWIPER_COUNT_TWO : StyleConstants.SWIPER_COUNT_THREE))
      .itemSpace(this.currentDeviceSize === CommonConstants.SM ? 0 : StyleConstants.ITEM_SPACE)
      .displayCount(CommonConstants.SWIPER_CACHE_COUNT)
      .margin($r('app.float.common_margin'))
      .width(StyleConstants.COMMON_WIDTH)
      .autoPlay(true)
    }
  }

  // 我的关注列表
  getBannerList() {
    BannerList()
      .then(res => {
        if (res.code === 1) {
          this.SwiperListData = res.data
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
  }
}

@Preview
@Component
struct CenterGridView {
  build() {
    Column() {
      Grid() {
        ForEach(mainViewModel.getCenterGridData(), (item: ItemData) => {
          GridItem() {
            GridItemView({ item: item })
          }
        }, (item: ItemData) => JSON.stringify(item))
      }
      .columnsTemplate(StyleConstants.GRID_COLUMNS)
      .rowsTemplate(StyleConstants.GRID_ROWS)
      .columnsGap($r('app.float.grid_column_gap'))
      .rowsGap($r('app.float.grid_row_gap'))
      .height(StyleConstants.HOME_GRID_HEIGHT)
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.home_grid_radius'))
      .padding({
        top: $r('app.float.home_grid_padding'),
        bottom: $r('app.float.home_grid_padding')
      })
      .width(StyleConstants.COMMON_WIDTH)
      .margin($r('app.float.common_margin'))
    }
  }
}

@Component
struct GridItemView {
  private item?: ItemData;
  private gridItemImg?: Resource;
  private gridItemTitle?: Resource;
  private gridItemPrompt?: Resource;

  aboutToAppear() {
    if (this.item !== undefined) {
      this.gridItemImg = this.item.img;
      this.gridItemTitle = this.item.title;
      this.gridItemPrompt = this.item.clickPrompt;
    }
  }

  build() {
    Column() {
      if (this.gridItemImg) {
        Image(this.gridItemImg)
          .width($r('app.float.home_cell_size'))
          .height($r('app.float.home_cell_size'))
      }
      if (this.gridItemTitle) {
        Text(this.gridItemTitle)
          .fontSize($r('app.float.little_text_size'))
          .margin({ top: $r('app.float.home_cell_margin') })
      }
    }
    .onClick(() => {
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