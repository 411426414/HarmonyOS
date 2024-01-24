import router from '@ohos.router'
import StyleConstants from '../constants/StyleConstants'
import deviceinfo from '@ohos.deviceInfo'
import batteryInfo from '@ohos.batteryInfo';

@Entry
@Component
export default struct HuaweiPage {
  @State message: string = 'Hello World'
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Text('电量信息：' + JSON.stringify(batteryInfo)).width('90%')
      Text('表示当前设备剩余电池电量百分比：' + batteryInfo.batterySOC).width('90%')
      Text('表示当前设备电池的充电状态：' + batteryInfo.chargingStatus).width('90%')
      Text('表示当前设备电池的健康状态：' + batteryInfo.healthStatus).width('90%')
      Text('表示当前设备电池的技术型号：' + batteryInfo.technology).width('90%')
      Text('表示当前设备电池的温度，单位0.1摄氏度：' + batteryInfo.batteryTemperature).width('90%')
      Text('表示当前设备是否支持电池或者电池是否在位：' + batteryInfo.isBatteryPresent).width('90%')
      Text('表示当前设备电池电量的等级：' + batteryInfo.batteryCapacityLevel).width('90%')


      Text('设备信息：' + JSON.stringify(deviceinfo)).width('90%')
      Text('设备类型：' + deviceinfo.deviceType).width('90%')
      Text('设备厂家名称：' + deviceinfo.manufacture).width('90%')
      Text('设备品牌名称：' + deviceinfo.brand).width('90%')
      Text('外部产品系列：' + deviceinfo.marketName).width('90%')
      Text('产品系列：' + deviceinfo.productSeries).width('90%')
      Text('内部软件子型号：' + deviceinfo.softwareModel).width('90%')
      Text('硬件版本号：' + deviceinfo.hardwareModel).width('90%')
      Text('硬件Profile：' + deviceinfo.hardwareProfile).width('90%')
      // Text('设备序列号：' + deviceinfo.serial).width('90%')
      Text('Bootloader版本号：' + deviceinfo.bootloaderVersion).width('90%')
      Text('应用二进制接口（Abi）列表：' + deviceinfo.abiList).width('90%')
      Text('安全补丁级别：' + deviceinfo.securityPatchTag).width('90%')
      Text('产品版本：' + deviceinfo.displayVersion).width('90%')
      Text('差异版本号：' + deviceinfo.incrementalVersion).width('90%')
      Text('系统的发布类型：' + deviceinfo.osReleaseType).width('90%')

      Text('Canary：特定开发者发布的早期预览版本').width('90%')
      Text('Beta：开发者公开发布的Beta版本').width('90%')
      Text('Release：开发者公开发布的正式版本').width('90%')


      Text('系统版本：' + deviceinfo.osFullName).width('90%')
      Text('Major版本号，随主版本更新增加：' + deviceinfo.majorVersion).width('90%')
      Text('Senior版本号，随局部架构、重大特性增加：' + deviceinfo.seniorVersion).width('90%')
      Text('Feature版本号，标识规划的新特性版本：' + deviceinfo.featureVersion).width('90%')
      Text('Build版本号，标识编译构建的版本号：' + deviceinfo.buildVersion).width('90%')
      Text('系统软件API版本：' + deviceinfo.sdkApiVersion).width('90%')
      Text('首个版本系统软件API版本：' + deviceinfo.firstApiVersion).width('90%')
      Text('版本ID：' + deviceinfo.versionId).width('90%')
      Text('构建类型：' + deviceinfo.buildType).width('90%')
      Text('构建用户：' + deviceinfo.buildUser).width('90%')
      Text('构建主机：' + deviceinfo.buildHost).width('90%')
      Text('构建时间：' + deviceinfo.buildTime).width('90%')
      Text('构建版本Hash：' + deviceinfo.buildRootHash).width('90%')
      // Text('设备Udid：' + deviceinfo.udid).width('90%')

      Button('Huawei 登陆').width(StyleConstants.BUTTON_WIDTH).height(40).margin({ top: 20 })
        .onClick(() => {
          router.pushUrl({ url: 'pages/LoginPage' })
        })
    }
    .width('95%')
    .margin({ top: 20, left: 20, right: 20, bottom: 20 })
    .height('auto')
  }
}