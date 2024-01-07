import util from '@ohos.util';
import http from '@ohos.net.http';
import httpGet from '../common/utils/HttpUtil';
import promptAction from '@ohos.promptAction';
import Logger from '../common/utils/Logger';
import { getLccStationList, subscribeList4 } from '../api/tram'
import common from '@ohos.app.ability.common';

class Tram {
  key: string = util.generateRandomUUID(true);
  stationName: string;
  dataList: Array<dataList>;

  constructor(stationName: string, dataList: Array<dataList>) {
    this.stationName = stationName;
    this.dataList = dataList;
  }
}

class dataList {
  lindId: number;
  lineName: string;
  endStation: string;
  minute: string;
  nextArriveTime: string;
  upRunTime: string;
  ticketPrice: string;

  constructor(lindId: number, lineName: string, endStation: string, minute: string, nextArriveTime: string, upRunTime: string, ticketPrice: string) {
    this.lindId = lindId;
    this.lineName = lineName;
    this.endStation = endStation;
    this.minute = minute;
    this.nextArriveTime = nextArriveTime;
    this.upRunTime = upRunTime;
    this.ticketPrice = ticketPrice;
  }
}

@Entry
@Component
export default struct TramPage {
  // 我的关注
  @State tramList: Array<Object> = []
  @State message: string = 'Hello World!'
  private controller: TabsController = new TabsController()

  @Builder itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text).fontSize(20).backgroundColor('#fff1f3f5').width('100%').padding(5)
  }

  @State latitude: string = "30.481104"
  @State longitude: string = "114.48482"

  build() {
    Column({ space: 8 }) {
      Row() {
        Text('列表').fontSize(20).fontWeight('bold')
          .onClick(() => {this.subscribeList4();})
        Text('我的关注').fontSize(20).fontWeight('bold')
          .onClick(() => {this.subscribeList4();})
        Text('跳转高德').fontSize(20).fontWeight('bold')
          .onClick(() => {this.jumpGaode()})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)

      List({ space: 8 }) {
        ForEach(this.tramList,
          (item: Tram) => {
            ListItem() {
              Flex({ direction: FlexDirection.Column }) {
                Row() {
                  Text(item.stationName).fontSize(20).fontWeight('bold')
                }
                .justifyContent(FlexAlign.Start)
                .width('100%')
                .height(30)
                .padding({ left: 5, top: 5 })

                List({ space: 8 }) {
                  ForEach(item.dataList,
                    (dataItem: dataList) => {
                      ListItem() {
                        Column() {
                          Row() {
                            Row() {
                              Text(dataItem.lineName).fontSize(14).fontWeight('bold').fontColor('#666666')
                              Text('开往').fontSize(14).fontWeight('bold').fontColor('#666666')
                              Text(dataItem.endStation).fontSize(14).fontWeight('bold').fontColor('#666666')
                            }
                            .justifyContent(FlexAlign.SpaceAround)
                            .alignItems(VerticalAlign.Center).width('33%')

                            Text('换向').fontSize(10).onClick(() => {
                              this.reversing(dataItem)
                            })
                            Text(dataItem.minute).fontSize(10).fontSize(14).fontWeight('bold').fontColor('#47C4FD')
                          }
                          .justifyContent(FlexAlign.SpaceBetween)
                          .alignItems(VerticalAlign.Center)
                          .width('100%')
                          .padding({ left: 5, top: 5 })

                          Row() {
                            Row() {
                              Text(dataItem.upRunTime).fontSize(10)
                              Text('|').fontSize(10).padding({ left: 5, right: 5 })
                              Text('票价').fontSize(10)
                              Text(dataItem.ticketPrice).fontSize(10)
                              Text('元').fontSize(10)
                            }

                            Text(dataItem.nextArriveTime).fontSize(10)
                          }
                          .justifyContent(FlexAlign.SpaceBetween)
                          .alignItems(VerticalAlign.Center)
                          .width('100%')
                          .padding({ left: 5, top: 5 })
                        }
                      }
                    })
                }
                .width('100%')
                .layoutWeight(1)
              }
              .width('100%')
              .backgroundColor('#FFF')
              .borderRadius(20)
              .height(140)
              .padding(10)
            }
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EFEFEF')
    .padding(20)
  }

  // 只有被@ Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    console.info('Index onPageShow');
    this.subscribeList4()
  }
  // 只有被@ Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    console.info('Index onPageHide');
  }

  // 我的关注列表
  subscribeList4() {
    // let webSrc = 'https://whyouguidianche.siisoo.com/realBus/subscribeList4?userId=1233666'
    // httpGet(webSrc).then((res: http.HttpResponse) => {
    //   this.tramList = JSON.parse(`${ res.result }`).data
    //   Logger.info('this.subscribeList4', JSON.stringify(this.tramList))
    // });
     subscribeList4({ userId: 1233666 })
      .then(res => {
        console.log("res: ", JSON.stringify(res))
        if (res.code === 1) {
          this.tramList = res.data
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
  }


  jumpGaode() {
    let context = getContext(this) as common.UIAbilityContext
    context.startAbility({
      uri: "androidamap://navi?sourceApplication=appname&lat=" + this.latitude + "&lon=" + this.longitude + "&dev=1",
      action: "android.intent.action.VIEW"
    })
  }

  getLccStationListFun() {
    // let webSrc = 'https://whyouguidianche.siisoo.com//realBus/getLccStationList?longitude=114.3216781616211&latitude=30.37558937072754&status=1&userId=1233666'
    // httpGet(webSrc).then((res: http.HttpResponse) => {
    //   this.tramList = JSON.parse(res['result'] + '')['data']
    //   Logger.info('this.getLccStationList', JSON.stringify(this.tramList))
    // });

    getLccStationList({
      longitude: 114.3216781616211,
      latitude: 30.37558937072754,
      status: 1,
      userId: 1233666
    })
      .then(res => {
        console.log("res: ", JSON.stringify(res))
        if (res.code === 1) {
          this.tramList = res.data
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
  }
  // 换向操作
  reversing(obj) {
    Logger.info('obj', JSON.stringify(obj))
  }
}