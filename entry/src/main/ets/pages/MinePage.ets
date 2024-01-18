import router from '@ohos.router';
import { userIndex } from '../api/user';
import CommonConstants from '../constants/CommonConstants';
import StyleConstants from '../constants/StyleConstants';
import CommonUtils from '../utils/CommonUtils';
import Logger from '../utils/Logger';

class UserInfoModel {
  id?: number
  username?: string
  nickname?: string
  mobile?: number
  avatar?: string
  score?: number
  token?: string
  user_id?: number
  createtime?: number
  expiretime?: number
  expires_in?: number
}

@Entry
@Component
export default struct MinePage {
  @State token: string = '5d9f56c2-b235-4452-9be6-c7e01f42af56';
  @State UserInfo: UserInfoModel = {}

  aboutToAppear() {
    AppStorage.SetAndProp('token', this.token)
    // this.token = AppStorage.Get('token')
    // Logger.info(CommonConstants.TAG_MINE_PAGE, this.token);
    userIndex()
      .then(res => {
        console.log('res', JSON.stringify(res))
        this.UserInfo = res.data
      })
  }

  build() {
    Column() {
      MineTitleView({ userInfo: $UserInfo })
      Text('token:' + this.token)

      Button('登录')
        .margin({ top: 220 })
        .onClick(() => {

        })
      Button('退出登录')
        .margin({ top: 220 })
        .onClick(() => {
          this.logout();
          Logger.info(CommonConstants.TAG_MINE_PAGE, 'Logout');
        })
    }
    .width(StyleConstants.BIG_PARENT)
    .height(StyleConstants.FULL_PARENT)
  }

  /**
   * 退出登录
   */
  logout() {
    Logger.info(CommonConstants.TAG_MINE_PAGE, 'Logout');
    CommonUtils.routerPage(CommonConstants.LOGIN_PAGE_URL);
  }
}

// 我的顶部个人信息

@Component
struct MineTitleView {
  @Link userInfo: UserInfoModel

  build() {
    Column() {
      Row() {
        Image(this.userInfo.avatar ? $r('app.media.ic_account') : this.userInfo.avatar)
          .width($r('app.float.mine_title_size'))
          .height($r('app.float.mine_title_size'))
        Column() {
          Text(this.userInfo.username ? this.userInfo.username : '请登录')
            .fontSize($r('app.float.title_font_size'))
            .onClick(() => router.pushUrl({ url: 'pages/LoginPage' }))
          Text(`${this.userInfo.mobile ? this.userInfo.mobile : ''}`)
            .fontSize($r('app.float.little_text_size'))
            .margin({ top: $r('app.float.mine_name_margin') })
        }
        .margin({ left: $r('app.float.mine_title_margin') })
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)
      .width(StyleConstants.FULL_PARENT)
      .height($r('app.float.mine_title_height'))
      .padding({ left: $r('app.float.mine_title_padding') })
      .margin({ top: $r('app.float.account_margin_top'), bottom: $r('app.float.account_margin_bottom') })
      .borderRadius($r('app.float.title_component_radius'))
      .backgroundColor(Color.White)
    }
  }
}