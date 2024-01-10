//导入定义好的用户对象
import User from '../model/User'
//导入api下的User模块：请求方法
import { userLogin } from '../api/user'
import Logger from '../common/utils/Logger'
import notification from '@ohos.notificationManager';
import image from '@ohos.multimedia.image';
import TextPlus from './components/TextPlus'
import TextPro from './components/TextPro'

//导入toast包
import promptAction from '@ohos.promptAction'
import Constant from '../common/constants/Constant';

@Component
struct LoginPage {
  @State user: User = {
    account: 'zhengjie',
    password: '123456'
  }
  @State sex: string[] = ['保密', '男', '女']
  @State msg: string = ''
  @State token: string = ''

  //组件展示前进行数据的一个请求
  aboutToAppear() {

  }
  /*
   * 发布普通文本类型通知，需要设置contentType类型为
   * ContentType.NOTIFICATION_CONTENT_BASIC_TEXT
   * */
  publishNotification() {
    let notificationRequest: notification.NotificationRequest = { // 描述通知的请求
      id: 1, // 通知ID
      slotType: notification.SlotType.SERVICE_INFORMATION,
      content: { // 通知内容
        contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
        normal: { // 基本类型通知内容
          title: '通知内容标题',
          text: '通知内容详情:发布普通文本类型通知',
          additionalText: '通知附加内容', // 通知附加内容，是对通知内容的补充。
        }
      }
    }
    notification.publish(notificationRequest)
      .then(() => { // 发布通知
        console.info('publish success');
        promptAction.showToast({ message: '发布普通文本类型通知成功' })
      })
      .catch((err) => {
        promptAction.showToast({ message: '发布普通文本类型通知失败:' + JSON.stringify(err) })
        console.error(`publish failed, dcode:${err.code}, message:${err.message}`);
      });
  }

  /*
   * 发布图片类型通知，需要设置contentType类型为
   * ContentType.NOTIFICATION_CONTENT_PICTURE。
   * */
  async publishPictureNotification() {
    // 将资源图片转化为PixelMap对象
    let resourceManager = getContext(this).resourceManager;
    let imageArray = await resourceManager.getMediaContent($r('app.media.img'));
    let imageResource = image.createImageSource(imageArray.buffer);
    let pixelMap = await imageResource.createPixelMap();

    let notificationRequest: notification.NotificationRequest = { // 描述通知的请求
      id: 1,
      content: {
        contentType: notification.ContentType.NOTIFICATION_CONTENT_PICTURE,
        picture: {
          title: '好物热销中', // 通知内容标题
          text: '展开查看详情:发布图片类型通知成功', // 通知内容
          expandedTitle: '今日热门推荐', // 通知展开时的内容标题
          briefText: '这里一定有您喜欢的', // 通知概要内容，是对通知内容的总结
          picture: pixelMap // 通知的图片内容
        }
      }
    }

    // 发布通知
    notification.publish(notificationRequest)
      .then(() => {
        promptAction.showToast({ message: '发布图片类型通知成功' })
        console.info('发布通知 success');
      })
      .catch((err) => {
        promptAction.showToast({ message: '发布图片类型通知成功失败:' + JSON.stringify(err) })
        console.error(`publish failed, dcode:${err.code}, message:${err.message}`);
      });
  }

  build() {
    Row() {
      Column() {

        Image($r('app.media.img'))
          .width(110)
          .height(110)
          .margin({ bottom: 50 })
          .borderRadius(15)

        // Divider()
        TextInput({ placeholder: "输入用户名", text: this.user.account })
          .type(InputType.Normal)
          .margin({ top: 20 })
          .onChange((value: string) => {
            this.user.account = value
          })
        TextInput({ placeholder: "输入密码", text: this.user.password })
          .type(InputType.Password)
          .margin({ top: 20 })
          .onChange((value: string) => {
            this.user.password = value
          })

        /*Image($r('app.media.avatar'))
          .width(Constant.AVATAR_SIZE)
          .height(Constant.AVATAR_SIZE)
          .alignSelf(ItemAlign.Center)
        Text('个人信息')
          .fontColor(Constant.LOGIN_COLOR)
          .fontSize(16)
          .margin({ top: 10 })
          .alignSelf(ItemAlign.Center)
        TextPro({
          inputImage: $r('app.media.nickname'),
          hintText: '昵称'
        })
        TextPro({
          inputImage: $r('app.media.ic_search'),
          hintText: '昵称',
        })
        TextPro({
          inputImage: $r('app.media.signature'),
          hintText: '个性签名'
        })
        TextPlus({
          textImage: $r('app.media.ic_search'),
          title: '性别',
          content: $msg,
          onItemClick: () => {
            TextPickerDialog.show({
              range: this.sex,
              onAccept: (value: TextPickerResult) => {
                // 设置select为按下确定按钮时候的选中项index,这样当弹框在吃弹出时显示选中的还是上一次确定的选项
                this.msg = value.value
              },
              onCancel: () => {
                console.log('取消')
              },
              onChange: (value: TextPickerResult) => {
                console.log('改变', value)
              }
            })
          }
        })*/
        Button('登录')
          .width(250)
          .margin({ top: 20 })
          .onClick(() => {
            // console.log("发送成功")
            userLogin(this.user)
              .then(res => {
                console.log("res: ", JSON.stringify(res))
                if (res.code === 1) {
                  this.user = res.data
                  this.token = res.data.userinfo.token
                } else {
                  promptAction.showToast({ message: res.msg })
                }
              })
          })
        Row() {
          Text('Token:').fontSize(24).margin({ right: 10 })
          Text(this.token).fontSize(16)
        }
        .width('100%')
        .margin({ top: 10 })
        .justifyContent(FlexAlign.Start)

        Row() {
          Button('发送通知').onClick(() => {
            this.publishNotification()
          })
          Button('发送大图通知').onClick(() => {
            this.publishPictureNotification()
          })
        }
        .width('80%')
        .margin({ top: 100 })
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .width('100%')
      .height('100%')
      .padding({ top: 150, left: 25, right: 25 })
      // .alignItems(HorizontalAlign.Start)

    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}