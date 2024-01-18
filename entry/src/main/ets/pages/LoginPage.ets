import TextPlus from '../components/TextPlus'
import TextPro from '../components/TextPro'
import StyleConstants from '../constants/StyleConstants'
import { userLogin } from '../api/user'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'

class Login {
  account: string
  password: string
}

@Entry
@Component
export default struct LoginPage {
  @State account: string = 'zhengjie'
  @State password: string = '123456'
  @State userInfo: Login = { account: 'zhengjie', password: '123456' }
  private imgWh = 120
  private isChecked: boolean = true

  // 父组件传递事件函数
  onItemChange(data, params) {
    this.userInfo[params] = data
    // 业务的跳转查询
  }

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
    }) {
      Image($r('app.media.img'))
        .width(this.imgWh)
        .height(this.imgWh)
        .borderRadius(this.imgWh / 2)
        .margin({ bottom: 40 })
      TextPro({
        inputImage: $r('app.media.ic_account'),
        textContent: $account,
        hintText: '请输入账号',
        onItemChange: (data) => this.onItemChange(data, 'account')
      })
      TextPro({
        inputImage: $r('app.media.ic_privacy'),
        textContent: $password,
        hintText: '请输入密码',
        isPass: true,
        onItemChange: (data) => this.onItemChange(data, 'password')
      })
      Row() {
        Checkbox({ name: 'checkbox2' })
          .select(this.isChecked)
          .onChange(() => {
          })
        Text('记住密码')
      }
      .justifyContent(FlexAlign.Start)
      .width(StyleConstants.BUTTON_WIDTH)
      .margin({ top: 10 })

      Button('登录', {
        type: ButtonType.Capsule,
        stateEffect: true
      })
        .margin({ top: 100 })
        .backgroundColor(0x317aff)
        .width(StyleConstants.LOGIN_BOTTOM_HEIGHT)
        .onClick(() => {
          console.log(this.userInfo.account)
          console.log(this.userInfo.password)
          if (this.userInfo.account === '' || this.userInfo.password === '') {
            // 提示用户输入账号和密码
            promptAction.showToast({
              message: '请输入账号和密码',
              duration: 2000,
            });
            return
          }
          userLogin(this.userInfo)
            .then((res) => {
              console.log('res', JSON.stringify(res))
              if (res.code === 1) {
                let token = res.data.userinfo.token
                AppStorage.SetAndProp('token', token)
                AppStorage.SetAndLink('userInfo', res.data)
                router.pushUrl({ url: 'pages/Index' })

              } else {
                promptAction.showToast({ message: res.msg })
              }
            })
        })
    }
    .width(StyleConstants.FULL_PARENT)
    .height(StyleConstants.FULL_PARENT)
    .backgroundColor('#ffbcbcbc')
  }
}