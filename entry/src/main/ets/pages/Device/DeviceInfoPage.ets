import deviceInfo from '@ohos.deviceInfo'
import batteryInfo from '@ohos.batteryInfo';
import LocationUtil from '../../utils/LocationUtil';
import geoLocationManager from '@ohos.geoLocationManager';
import Logger from '../../utils/Logger1';
import Intl from '@ohos.intl';
import router from '@ohos.router';

const TAG: string = 'HomePage';

@Entry
@Component
export default struct DeviceInfoPage {
  @State latitude: number = 0;
  @State longitude: number = 0;
  @State currentLocation: string = '';
  @State locale: string = new Intl.Locale().language;
  @State deviceInfo: any = '';
  @State batteryInfo: any = '';

  onPageShow() {
    LocationUtil.geolocationOn((location: geoLocationManager.Location) => {
      if (this.latitude === location.latitude && this.longitude === location.longitude) {
        return;
      }
      this.latitude = location.latitude;
      this.longitude = location.longitude;
      let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
        'locale': this.locale.toString().includes('zh') ? 'zh' : 'en',
        'latitude': this.latitude,
        'longitude': this.longitude
      };
      geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then(data => {
        if (data[0].placeName) {
          this.currentLocation = data[0].placeName;
        }
      }).catch((err: Error) => {
        Logger.error(TAG, 'GetAddressesFromLocation err ' + JSON.stringify(err));
      });
    });
  }

  build() {
    Row() {
      Column() {
        Text(`deviceInfo：${this.deviceInfo}`)
        Row() {
          Button('获取设备信息')
            .width('40%')
            .height(40)
            .onClick(() => {
              this.deviceInfo = JSON.stringify(deviceInfo)
              console.log('DeviceInfoPage deviceInfo', JSON.stringify(deviceInfo))
              Logger.info(TAG, 'DeviceInfoPage deviceInfo ' + JSON.stringify(deviceInfo));
            })
          Button('获取电池信息')
            .width('40%')
            .height(40)
            .onClick(() => {
              this.deviceInfo = JSON.stringify(batteryInfo)
              console.log('DeviceInfoPage batteryInfo', JSON.stringify(batteryInfo))
              Logger.info(TAG, 'DeviceInfoPage deviceInfo ' + JSON.stringify(batteryInfo));
            })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 25, bottom: 25 })
        .width('100%')

        Flex({
          wrap: FlexWrap.Wrap,
          justifyContent: FlexAlign.SpaceBetween,
          alignContent: FlexAlign.Center,
        }) {
          Button('定位').onClick(() => {
            router.pushUrl({ url: 'pages/Device/AddressPage' })
          }).width('40%').margin(15)

          Button('蓝牙管理').onClick(() => {
            router.pushUrl({ url: 'pages/Device/BluetoothPage' })
          }).width('40%').margin(15)

          Button('打电话').onClick(() => {
            router.pushUrl({ url: 'pages/Device/CallPage' })
          }).width('40%').margin(15)
        }
        .margin({ top: 15 })
        .width('100%')
      }
      .width('90%')
      .margin('5%')
    }
    .height('100%')
  }
}