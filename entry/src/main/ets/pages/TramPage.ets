import util from '@ohos.util';
import data from '@ohos.telephony.data';
import http from '@ohos.net.http';
import httpGet from '../common/utils/HttpUtil';
import promptAction from '@ohos.promptAction';
import Logger from '../common/utils/Logger';
import router from '@ohos.router';
import { getLccStationList, subscribeList4 } from '../api/tram'

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

@Component
export default struct TramPage {
  // 我的关注
  @State tramList: Array<Object> = [
    {
      "stationId": "66",
      "stationName": "武大园",
      "status": "2",
      "otherId": "65",
      "lineId": "3",
      "isFirstEnd": false,
      "dataList": [
        {
          "distance": "",
          "downRunTime": "首06:00 末21:30",
          "endStation": "城铁汤逊湖",
          "isFirstEnd": false,
          "lineId": "3",
          "lineName": "L3",
          "location": "114.402036,30.455526",
          "minute": "---",
          "nextArriveTime": "---",
          "orderNum": "12",
          "otherId": "65",
          "startStation": "华中大",
          "stationId": "66",
          "stationName": "武大园",
          "status": "2",
          "ticketPrice": 2,
          "twoLine": 2,
          "upRunTime": "首06:00 末21:30",
          "createTime": "1702274443204"
        },
        {
          "distance": "",
          "downRunTime": "首06:30 末21:00",
          "endStation": "光谷植物园",
          "isFirstEnd": false,
          "lineId": "2",
          "lineName": "L2",
          "location": "114.402036,30.455526",
          "minute": "---",
          "nextArriveTime": "---",
          "orderNum": "4",
          "otherId": "65",
          "startStation": "城铁汤逊湖",
          "stationId": "66",
          "stationName": "武大园",
          "status": "2",
          "ticketPrice": 2,
          "twoLine": 1,
          "upRunTime": "首06:30 末22:00",
          "createTime": "1702274443206"
        }
      ],
      "flag": true
    },
    {
      "stationId": "77",
      "stationName": "大吕路",
      "status": "1",
      "otherId": "78",
      "lineId": "2",
      "isFirstEnd": false,
      "dataList": [
        {
          "distance": "",
          "downRunTime": "首06:30 末21:00",
          "endStation": "城铁汤逊湖",
          "isFirstEnd": false,
          "lineId": "2",
          "lineName": "L2",
          "location": "114.486687,30.471962",
          "minute": "---",
          "nextArriveTime": "---",
          "orderNum": "13",
          "otherId": "78",
          "startStation": "光谷植物园",
          "stationId": "77",
          "stationName": "大吕路",
          "status": "1",
          "ticketPrice": 2,
          "twoLine": 1,
          "upRunTime": "首06:30 末22:00",
          "createTime": "1702274436959"
        }
      ],
      "flag": true
    },
    {
      "stationId": "75",
      "stationName": "奥风路",
      "status": "1",
      "otherId": "76",
      "lineId": "2",
      "isFirstEnd": false,
      "dataList": [
        {
          "distance": "",
          "downRunTime": "首06:30 末21:00",
          "endStation": "城铁汤逊湖",
          "isFirstEnd": false,
          "lineId": "2",
          "lineName": "L2",
          "location": "114.477158,30.471281",
          "minute": "---",
          "nextArriveTime": "---",
          "orderNum": "14",
          "otherId": "76",
          "startStation": "光谷植物园",
          "stationId": "75",
          "stationName": "奥风路",
          "status": "1",
          "ticketPrice": 2,
          "twoLine": 1,
          "upRunTime": "首06:30 末22:00",
          "createTime": "1702274443254"
        }
      ],
      "flag": true
    }
  ]
  @State message: string = 'Hello World!'
  private controller: TabsController = new TabsController()

  @Builder itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text).fontSize(20).backgroundColor('#fff1f3f5').width('100%').padding(5)
  }

  build() {
    Column({ space: 8 }) {
      Row() {
        Text('列表').fontSize(20).fontWeight('bold')
          .onClick(() => {
            this.getLccStationListFun();
          })
        Text(' ')
        Text(' ')
        Text('我的关注').fontSize(20).fontWeight('bold')
          .onClick(() => {
            this.subscribeList4();
          })
        Text(' ')
        Text(' ')
        Text('登录').fontSize(20).fontWeight('bold')
          .onClick(() => {
            return router.push({
              url: 'pages/User'
            });
          })
        Text(' ')
      }.width('100%').margin({ bottom: 20 })

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

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    console.info('Index onPageShow');
    this.getLccStationListFun()
  }
  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    console.info('Index onPageHide');
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

  // 我的关注列表
  subscribeList4() {
    // let webSrc = 'https://whyouguidianche.siisoo.com/realBus/subscribeList4?userId=1233666'
    // httpGet(webSrc).then((res: http.HttpResponse) => {
    //   this.tramList = JSON.parse(res['result'] + '')['data']
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
}