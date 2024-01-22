import bluetoothManager from '@ohos.bluetoothManager';

@Entry
@Component
struct BluetoothPage {
  @State name: string = ''
  @State value: string = ''

  build() {
    Row() {
      Column() {
        List({ space: 8 }) {

          ListItem() {
            Button('获取蓝牙开关状态').onClick(() => {
              try {
                let state = bluetoothManager.getState();
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('开启蓝牙').onClick(() => {
              try {
                bluetoothManager.enableBluetooth();
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('关闭蓝牙').onClick(() => {
              try {
                bluetoothManager.disableBluetooth();
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('获取蓝牙本地设备名称').onClick(() => {
              try {
                let localName = bluetoothManager.getLocalName();
                this.name = '获取蓝牙本地设备名称。'
                this.value = localName
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('获取蓝牙设备的Profile连接状态').onClick(() => {
              try {
                let connectionState = bluetoothManager.getBtConnectionState();
                this.name = '表示蓝牙设备的Profile连接状态。'
                this.value = JSON.stringify(connectionState)
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('设置蓝牙本地设备名称').onClick(() => {
              try {
                bluetoothManager.setLocalName('device_name');
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)

          ListItem() {
            Button('发起蓝牙配对').onClick(() => {
              try {
                // 实际的地址可由扫描流程获取
                bluetoothManager.pairDevice("XX:XX:XX:XX:XX:XX");
              } catch (err) {
                console.error("errCode:" + err.code + ",errMessage:" + err.message);
              }
            }).width('100%')
          }.padding(5)
        }
        .lanes(2)
        .margin(10)

        // Button('').onClick(() => {})
      }
      .width('100%')
    }
    .height('100%')
  }
}