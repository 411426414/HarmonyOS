import util from '@ohos.util';
import data from '@ohos.telephony.data';
import http from '@ohos.net.http';
import httpGet from '../common/utils/HttpUtil';
import promptAction from '@ohos.promptAction';
import Logger from '../common/utils/Logger';
import router from '@ohos.router';
import { getLccStationList, subscribeList4 } from '../api/tram'
import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';

class Tram {
  key: string = util.generateRandomUUID(true);
  stationId: string;
  stationName: string;
  status: string;
  otherId: string;
  lineId: string;
  isFirstEnd: boolean;
  dataList: Array<DataList>;
  flag: boolean;

  constructor(stationId: string, stationName: string, status: string, otherId: string, lineId: string, isFirstEnd: boolean, dataList: Array<DataList>, flag: boolean,) {
    this.stationId = stationId;
    this.stationName = stationName;
    this.status = status;
    this.otherId = otherId;
    this.lineId = lineId;
    this.isFirstEnd = isFirstEnd;
    this.flag = flag;
    this.dataList = dataList;
  }
}

class DataList {
  distance: string
  downRunTime: string
  endStation: string
  isFirstEnd: boolean
  lineId: string
  lineName: string
  location: string
  minute: string
  nextArriveTime: string
  orderNum: string
  otherId: string
  startStation: string
  stationId: string
  stationName: string
  status: string
  ticketPrice: number
  twoLine: number
  upRunTime: string
  createTime: string

  constructor(distance: string, downRunTime: string, endStation: string, isFirstEnd: boolean, lineId: string, lineName: string, location: string, minute: string, nextArriveTime: string, orderNum: string, otherId: string, startStation: string, stationId: string, stationName: string, status: string, ticketPrice: number, twoLine: number, upRunTime: string, createTime: string) {
    this.distance = distance
    this.downRunTime = downRunTime
    this.endStation = endStation
    this.isFirstEnd = isFirstEnd
    this.lineId = lineId
    this.lineName = lineName
    this.location = location
    this.minute = minute
    this.nextArriveTime = nextArriveTime
    this.orderNum = orderNum
    this.otherId = otherId
    this.startStation = startStation
    this.stationId = stationId
    this.stationName = stationName
    this.status = status
    this.ticketPrice = ticketPrice
    this.twoLine = twoLine
    this.upRunTime = upRunTime
    this.createTime = createTime
  }
}


@Component
export default struct TramPage {
  // 我的关注
  @State tramList: Array<object> = [] /*[
    {
      "stationId": "75",
      "stationName": "111111111",
      "status": "1",
      "otherId": "76",
      "lineId": "2",
      "isFirstEnd": false,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:30 末21:00",
        "endStation": "111111E11",
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
      }],
      "flag": true
    },
    {
      "stationId": "2",
      "stationName": "222222222222",
      "status": "2",
      "otherId": "2",
      "lineId": "3",
      "isFirstEnd": true,
      "dataList": [
        {
          "distance": "",
          "downRunTime": "首06:00 末21:30",
          "endStation": "222222222222",
          "isFirstEnd": true,
          "lineId": "3",
          "lineName": "L3",
          "location": "114.411903,30.507426",
          "minute": "---",
          "nextArriveTime": "---",
          "orderNum": "1",
          "otherId": "2",
          "startStation": "华中大",
          "stationId": "2",
          "stationName": "华中大",
          "status": "2",
          "ticketPrice": 2,
          "twoLine": 1,
          "upRunTime": "首06:00 末21:30",
          "createTime": "1702274442951"
        }, {
        "distance": "",
        "downRunTime": "首06:04 末21:30",
        "endStation": "3333333333",
        "isFirstEnd": true,
        "lineId": "1",
        "lineName": "L1",
        "location": "114.411903,30.507426",
        "minute": "---",
        "nextArriveTime": "---",
        "orderNum": "1",
        "otherId": "2",
        "startStation": "华中大",
        "stationId": "2",
        "stationName": "华中大",
        "status": "2",
        "ticketPrice": 2,
        "twoLine": 1,
        "upRunTime": "首06:00 末22:12",
        "createTime": "1702274442954"
      }],
      "flag": true
    }]*/
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
        Text('最近列表').fontSize(20).fontWeight('bold')
          .onClick(() => {
            this.getLccStationListFun();
          })
        Text('我的关注').fontSize(20).fontWeight('bold')
          .onClick(() => {
            this.subscribeList4();
          })
        Text('跳转高德').fontSize(20).fontWeight('bold')
          .onClick(() => {
            this.jumpGaode()
          })
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
                    (dataItem: DataList) => {
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
                              Text(dataItem.ticketPrice + '').fontSize(10)
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

  aboutToAppear() {
    this.getLccStationListFun();
  }

  // 我的关注列表
  subscribeList4() {
    subscribeList4(1233666)
      .then(res => {
        if (res.code === 1) {
          this.tramList = res.data
          promptAction.showToast({ message: res.msg })
        } else {
          promptAction.showToast({ message: res.msg })
        }
      })
  }

  getLccStationListFun() {
    getLccStationList({
      longitude: 114.3216781616211,
      latitude: 30.37558937072754,
      status: 1,
      userId: 1233666
    })
      .then(res => {
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

  // 换向操作
  reversing(obj) {
    Logger.info('obj', JSON.stringify(obj))
  }
}