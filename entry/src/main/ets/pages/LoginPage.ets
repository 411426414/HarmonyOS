import TitleComponent from '../components/TitleComponent';
import Input from '../components/Input';
import {
  AGConnectAuth,
  AGConnectAuthCredentialProvider,
  EmailAuthProvider,
  EmailUserBuilder,
  PhoneAuthProvider,
  PhoneUserBuilder,
  VerifyCodeAction,
  VerifyCodeSettingBuilder
} from '@hw-agconnect/auth-ohos'
import agconnect from '@hw-agconnect/api-ohos';
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct LoginPage {
  num: number = 60
  @State isRegister: boolean = false
  @State countDown: number = 60
  timer: number
  @State email: string = '411426414@qq.com'
  @State password: string = '123456'
  @State verifyCode: string = ''
  chang = (val: string) => {
  }
  // 发送验证码
  sendCode() {
    this.startSendCode()

    // 发送验证码
    const verifyCodeSettings = new VerifyCodeSettingBuilder()
      .setAction(VerifyCodeAction.REGISTER_LOGIN) // 验证码类型
      .setLang('zh_CN')
      .setSendInterval(60)
      .build()
    console.log('this.email', this.email)
    // 接收两个参数，第一个是发送邮件的url地址，第二个是当前的配置
    agconnect.auth().requestEmailVerifyCode(this.email, verifyCodeSettings)
      .then((VerifyCodeResult) => {
        console.log(JSON.stringify(VerifyCodeResult), '成功')
      })
      .catch((err) => {
        console.log(JSON.stringify(err), '失败')
      })
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

  register() {
    // 通过code + 密码 + 邮箱 登录

    const emailUser = new EmailUserBuilder()
      .setEmail(this.email)
      .setPassword(this.password)
      .setVerifyCode(this.verifyCode)
      .build()

    // 创建用户华为认证层面
    agconnect.auth().createEmailUser(emailUser)
      .then((result) => {
        promptAction.showToast({ message: '注册成功！' })
        clearInterval(this.timer)
        router.replaceUrl({
          url: 'pages/MinePage',
        })
      })
      .catch(err => {
        console.log(JSON.stringify(err), '失败')
        promptAction.showToast({ message: '请重新输入密码！' })
        clearInterval(this.timer)
      })


  }

  doLogin() {
    router.replaceUrl({
      url: 'pages/Index`',
    })
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
          defaultValue: $email,
          change: (val) => {
            this.email = val
          }
        })

        Input({
          title: '密码',
          icon: $r('app.media.ic_about'),
          placeholder: '请输入您的密码',
          inputType: InputType.Password,
          defaultValue: $password,
          change: (val) => {
            this.password = val
          }
        }).margin({ top: 20 })

        if (this.isRegister) {
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
                .onChange((val: string) => {
                  this.verifyCode = val
                })

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
          Text(this.isRegister ? '注册' : '登录')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
        }
        .width(228)
        .height(50)
        .backgroundColor('#38BFDA')
        .borderRadius(50)
        .margin({ top: 100 })
        .onClick(() => {
          this.isRegister ? this.register() : this.doLogin()
        })

        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.isRegister ? '去登录' : '去注册')
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