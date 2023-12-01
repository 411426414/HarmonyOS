import util from '@ohos.util';
import data from '@ohos.telephony.data';
import http from '@ohos.net.http';
import httpGet from '../common/utils/HttpUtil';
import promptAction from '@ohos.promptAction';
import Logger from '../common/utils/Logger';

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

  constructor(lindId: number, lineName: string, endStation: string, minute: string,
              nextArriveTime: string, upRunTime: string, ticketPrice: string) {
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
struct Index {
  @State tramList: Array<Object> = [
    {
      "stationId": "77",
      "stationName": "大吕路",
      "status": "1",
      "otherId": "78",
      "lindId": "2",
      "isFirstEnd": false,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:30 末21:00",
        "endStation": "城铁汤逊湖",
        "isFirstEnd": false,
        "lineId": "2",
        "lineName": "L2",
        "location": "114.486687,30.471962",
        "minute": "预计16分钟",
        "nextArriveTime": "预计30分钟",
        "orderNum": "13",
        "otherId": "78",
        "startStation": "光谷植物园",
        "stationId": "77",
        "stationName": "大吕路",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 1,
        "upRunTime": "首06:30 末22:00",
        "createTime": "1701415601254"
      }],
      "flag": true
    },
    {
      "stationId": "19",
      "stationName": "当代国际花园",
      "status": "1",
      "otherId": "20",
      "lindId": "2",
      "isFirstEnd": false,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:30 末21:00",
        "endStation": "城铁汤逊湖",
        "isFirstEnd": false,
        "lineId": "2",
        "lineName": "L2",
        "location": "114.412571,30.463855",
        "minute": "预计1分钟",
        "nextArriveTime": "预计6分钟",
        "orderNum": "20",
        "otherId": "20",
        "startStation": "光谷植物园",
        "stationId": "19",
        "stationName": "当代国际花园",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 2,
        "upRunTime": "首06:30 末22:00",
        "createTime": "1701415600033"
      }, {
        "distance": "",
        "downRunTime": "首06:00 末22:12",
        "endStation": "华中大",
        "isFirstEnd": false,
        "lineId": "1",
        "lineName": "L1",
        "location": "114.412571,30.463855",
        "minute": "预计6分钟",
        "nextArriveTime": "预计15分钟",
        "orderNum": "7",
        "otherId": "20",
        "startStation": "佛祖岭",
        "stationId": "19",
        "stationName": "当代国际花园",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 2,
        "upRunTime": "首06:04 末21:30",
        "createTime": "1701415600035"
      }],
      "flag": true
    },
    {
      "stationId": "65",
      "stationName": "武大园",
      "status": "1",
      "otherId": "66",
      "lindId": "3",
      "isFirstEnd": false,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:00 末21:30",
        "endStation": "华中大",
        "isFirstEnd": false,
        "lineId": "3",
        "lineName": "L3",
        "location": "114.402036,30.455526",
        "minute": "已到站",
        "nextArriveTime": "预计6分钟",
        "orderNum": "4",
        "otherId": "66",
        "startStation": "城铁汤逊湖",
        "stationId": "65",
        "stationName": "武大园",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 2,
        "upRunTime": "首06:09 末22:05",
        "createTime": "1701415600787"
      }],
      "flag": true
    },
    {
      "stationId": "75",
      "stationName": "奥风路",
      "status": "1",
      "otherId": "76",
      "lindId": "2",
      "isFirstEnd": false,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:30 末21:00",
        "endStation": "城铁汤逊湖",
        "isFirstEnd": false,
        "lineId": "2",
        "lineName": "L2",
        "location": "114.477158,30.471281",
        "minute": "预计1分钟",
        "nextArriveTime": "预计18分钟",
        "orderNum": "14",
        "otherId": "76",
        "startStation": "光谷植物园",
        "stationId": "75",
        "stationName": "奥风路",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 1,
        "upRunTime": "首06:30 末22:00",
        "createTime": "1701415601177"
      }],
      "flag": true
    },
    {
      "stationId": "59",
      "stationName": "城铁汤逊湖",
      "status": "1",
      "otherId": "60",
      "lindId": "2",
      "isFirstEnd": true,
      "dataList": [{
        "distance": "",
        "downRunTime": "首06:30 末21:00",
        "endStation": "城铁汤逊湖",
        "isFirstEnd": true,
        "lineId": "2",
        "lineName": "L2",
        "location": "114.386333,30.444559",
        "minute": "预计6分钟",
        "nextArriveTime": "预计14分钟",
        "orderNum": "25",
        "otherId": "60",
        "startStation": "光谷植物园",
        "stationId": "59",
        "stationName": "城铁汤逊湖",
        "status": "1",
        "ticketPrice": 2,
        "twoLine": 1,
        "upRunTime": "首06:30 末22:00",
        "createTime": "1701415600545"
      }],
      "flag": false
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

                            Text('换向').fontSize(10)
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
}