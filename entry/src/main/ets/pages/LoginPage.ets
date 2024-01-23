import TitleComponent from '../components/TitleComponent';
import Input from '../components/Input';

@Entry
@Component
struct LoginPage {
  num: number = 60
  @State isRegister: boolean = false
  @State countDown: number = 60
  timer: number
  // 发送验证码
  sendCode() {
    this.startSendCode()
  }
  // 开始倒计时
  startSendCode() {
    this.timer = setInterval(() => {
      this.countDown--
      if (this.countDown === 0) {
        this.countDown = 60
        clearInterval(this.timer)
      }
    }, 1000)
  }

  build() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center, }) {
      // 标题
      TitleComponent({ title: '登录' })

      // 登录表单
      Column() {
        Stack() {
          Image($r('app.media.img'))
            .width(88)
            .height(88)
            .offset({ y: -44 })
        }

        Input({
          title: '电子邮箱',
          icon: $r('app.media.avatar'),
          placeholder: '请输入您的电子邮箱',
        })

        Input({
          title: '密码',
          icon: $r('app.media.ic_about'),
          placeholder: '请输入您的密码',
          inputType: InputType.Password,
        }).margin({ top: 20 })

        if (!this.isRegister) {
          Column() {
            Text('验证码')
              .width('100%')
              .textAlign(TextAlign.Start)
              .fontSize(16)
              .fontWeight(500)
              .fontColor('#001648')
              .margin({ bottom: 14 })
            Flex({
              alignItems: ItemAlign.Center,
            }) {
              TextInput()
                .height(50)
                .margin({ right: 10 })
                  // .backgroundColor('#FBFBFD')
                .backgroundColor('#EEE')

              Button(this.countDown == 60 ? '获取验证码' : `${this.countDown}`)
                .fontSize(14)
                .width(this.countDown == 60 ? 175 : 60)
                .onClick(() => {
                  if (this.countDown === 60) {
                    this.sendCode()
                  }
                })
            }
          }
          .margin({ top: 20 })
        }

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.isRegister ? '登录' : '注册')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
        }
        .width(228)
        .height(50)
        .backgroundColor('#38BFDA')
        .borderRadius(50)
        .margin({ top: 100 })

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.isRegister ? '去注册' : '去登录')
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
            .onClick(() => {
              this.isRegister = !this.isRegister
            })
        }
        .width(228)
        .height(50)
        .backgroundColor('#F3F9FF')
        .borderRadius(50)
        .margin({ top: 20 })
      }
      .width('90%')
      .height('100%')
      .borderRadius(44)
      .margin({ top: 44 })
      .padding({ left: 14, right: 14 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F3F9FF')
  }
}