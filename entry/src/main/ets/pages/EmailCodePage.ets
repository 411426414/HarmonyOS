import common from '@ohos.app.ability.common'
import agconnect from '@hw-agconnect/api-ohos';
import "@hw-agconnect/core-ohos";
import "@hw-agconnect/auth-ohos";

import { EmailAuthProvider, VerifyCodeAction, VerifyCodeSettingBuilder, } from '@hw-agconnect/auth-ohos'

@Entry
@Component
export default struct EmailCodePage {
  @State message: string = '^_^'
  @State emailNumber: string = ''
  @State verifyCode: string = ''
  countryCode: string = '+86'
  private context = getContext(this) as common.UIAbilityContext

  onPageShow() {
    agconnect.instance().init(this.context.getApplicationContext());
    agconnect.auth().getCurrentUser().then(user => {
      if (user) {
        //业务逻辑
        console.log('get user success ' + JSON.stringify(user))
        this.message = 'uuid: ' + user.getUid()
      } else {
        console.log('xx not login')
        this.message = '暂无登陆信息'
      }
    }).catch(error => {
      console.log('get user failed' + JSON.stringify((error)))
    });
  }

  build() {
    Column({ space: 20 }) {
      TextInput({ placeholder: "请输入邮箱账号" })
        .width(320)
        .height(40)
        .type(InputType.Email)
        .onChange((v) => {
          this.emailNumber = v
        })

      Row({ space: 20 }) {
        TextInput({ placeholder: "请输入验证码" })
          .width(200)
          .height(40)
          .type(InputType.Number)
          .onChange((v) => {
            this.verifyCode = v
          })

        Button("发送验证码")
          .width(100)
          .height(40)
          .onClick(() => {
            //此处正则判断邮箱正确性
            if (this.BooleanregexEmail(this.emailNumber)) {
              this.handleSendVerifyCode()
            } else {
              //弹窗显示提示
              AlertDialog.show({
                message: '请输入正确的邮箱账号',
                confirm: {
                  value: '确定',
                  action: () => {
                  }
                }
              })
            }
          })
      }

      Button("登陆")
        .width(320)
        .height(40)
        .margin({ top: 40 })
        .onClick(() => {
          if (this.verifyCode.length >= 4) {
            this.handleCheckVerifyCode()
          } else {
            AlertDialog.show({
              message: '请输入正确的验证码',
              confirm: {
                value: '确定',
                action: () => {
                }
              }
            })
          }
        })

      Text(this.message)
        .margin({ top: 40 })
    }
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 100 })
    .width('100%')
  }

  private handleSendVerifyCode = () => {
    let verifyCodeSettings = new VerifyCodeSettingBuilder()
      .setAction(VerifyCodeAction.REGISTER_LOGIN)
      .setLang('zh_CN')
      .setSendInterval(60)
      .build();
    agconnect.auth().requestEmailVerifyCode(this.emailNumber, verifyCodeSettings)
      .then(verifyCodeResult => {
        console.log('xx verify code success ' + JSON.stringify(verifyCodeResult))
        //验证码申请成功
        this.message = '发送验证码成功'
      }).catch(error => {
      //验证码申请失败
      console.log('verify code fail ' + JSON.stringify(error))
    });
  }
  private handleCheckVerifyCode = () => {
    let credential = EmailAuthProvider.credentialWithVerifyCode(this.emailNumber, this.verifyCode);
    agconnect.auth().signIn(credential)
      .then(user => {
        //登录成功
        console.log('user is ' + JSON.stringify(user))
        console.log('user.getDisplayName is ' + JSON.stringify(user.getUser().getDisplayName()))
        console.log('user.getUid is ' + JSON.stringify(user.getUser().getUid()))
        console.log('user.getEmail is ' + JSON.stringify(user.getUser().getEmail()))
        console.log('user.getPhone is ' + JSON.stringify(user.getUser().getPhone()))
        console.log('user.getPhotoUrl is ' + JSON.stringify(user.getUser().getPhotoUrl()))
        this.message = ('uuid: ' + user.getUser().getUid()) + "\n" + ("username" + user.getUser().getDisplayName())
      }).catch(error => {
      //登录失败
      console.log('xx login code fail ' + JSON.stringify(error))
    });
  }

  //正则判断邮箱
  private BooleanregexEmail(email: string): boolean {
    let b: boolean;
    const reg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+$/;
    reg.test(email)
    if (email.length === 0) {
      b = false;
    } else {
      if (!reg.test(email)) {
        b = false;
      } else {
        b = true;
      }
    }
    return b;
  }
}
