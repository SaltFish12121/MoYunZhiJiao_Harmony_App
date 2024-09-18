import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'


@Extend(Row) function set_List(){
  .height(64)
  .width('90%')
  .backgroundColor($r('app.color.start_window_background'))
  .justifyContent(FlexAlign.SpaceBetween)
}


@Entry
@Component
struct AccountManagementPage {
  @State phoneNumber: string = ''
  @State email: string = ''

  @State title: string = '账号管理'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })
        .backgroundColor($r('app.color.start_window_background'))

      //2手机号
      Divider()

      Row(){
        Row(){
          Text('手机号')
            .fontSize(20)

          Row(){
            Text(this.phoneNumber)
              .fontSize(16)

            Image($r('app.media.enter'))
              .height(24)
          }
        }
        .set_List()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.start_window_background'))
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mine/mine_set/account_management/ModifyMobilePhonePage'
          }
        )
      })


      //3邮箱

      Divider()

      Row(){
        Row(){
          Text('邮箱')
            .fontSize(20)

          Row(){
            Text(this.email)
              .fontSize(16)

            Image($r('app.media.enter'))
              .height(24)
          }
        }
        .set_List()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.start_window_background'))
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mine/mine_set/account_management/ModifyEmailPage',
            params: {
              email: this.email
            }
          }
        )
      })


      //4修改密码
      Divider()

      Row(){
        Row(){
          Text('修改密码')
            .fontSize(20)

          Row(){
            Text('')
              .fontSize(16)

            Image($r('app.media.enter'))
              .height(24)
          }
        }
        .set_List()
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor($r('app.color.start_window_background'))
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mine/mine_set/account_management/ChangePasswordPage'
          }
        )
      })


    }
    .backgroundColor($r('app.color.mid_gray'))
    .width('100%')
    .height('100%')

  }

  onPageShow(){
    const account = router.getParams() as PARAMS
    if (account != undefined) {
      console.log(`account = ${account.phoneNumber}`)
      console.log(`account = ${account.email}`)
      console.log(`account = ${account.password}`)

      if (account.phoneNumber != null) {
        this.phoneNumber = account.phoneNumber
      }

      if (account.email != null) {
        this.email = account.email
      }
    }

  }
}

// 声明接受参数的类型
interface PARAMS {
  phoneNumber: string
  email: string
  password: string
}