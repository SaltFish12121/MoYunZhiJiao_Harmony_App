import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct ChangePasswordPage {
  userId: number = 0
  @State oldPassword: string = ''
  @State newPassword: string = ''

  @State success: boolean = false
  @State message: string = ''

  @State title: string = '修改密码'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      //2提示
      Row(){
        Text('未设置或忘记旧密码')
          .fontSize(16)
          .fontColor($r('app.color.text_gray'))

        Text('请点击此处')
          .fontSize(16)
          .fontColor($r('app.color.blue'))
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/login/socialEnter/SocialForgetPassword'
              }
            )
          })

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(37)
      .backgroundColor($r('app.color.mid_gray'))

      //3密码修改
      Column(){
        Column({space: 5}){
          TextInput({ placeholder: '旧密码'})
            .fontSize(20)
            .placeholderFont({ size: 20, weight: 400 })
            .backgroundColor($r('app.color.start_window_background'))
            .onChange((v) => {
              this.oldPassword = v
            })

          Divider()
            .width('90%')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .height(61)

        Column({space: 5}){
          TextInput({ placeholder: '新密码'})
            .fontSize(20)
            .placeholderFont({ size: 20, weight: 400 })
            .backgroundColor($r('app.color.start_window_background'))
            .onChange((v) => {
              this.newPassword = v
            })

          Divider()
            .width('90%')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .height(61)

        //密码要求
        Text('密码为8-16位，至少包含字母、数字或"_"两种组合')
          .fontSize(12)
          .fontColor($r('app.color.text_gray'))


      }

      //确定
      Button('确定')
        .margin({top: 40})
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button1'))
        .width('90%')
        .borderRadius(10)
        .onClick(async () => {
          //1链接后台修改密码
          await this.alterPassword()

          //2是否修改成功
          console.log('success',this.success)
          if (this.success) {
            UserDBService.updateUserColumnById(this.userId, 'userPassword', this.newPassword)
            console.log('DB', 'update', this.userId, 'userPassword', this.newPassword)

            router.back()

          } else {
            AlertDialog.show({
              message: '修改密码失败:'+this.message,
              confirm: {
                value: '确定',
                action: ()=>{}
              }
            })
          }
        })



    }
    .width('100%')
    .height('100%')

  }

  async onPageShow(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number
    this.userId = 32
  }

  //修改密码
  async alterPassword(){

    await UserService.alterPassword(this.userId, this.oldPassword ,this.newPassword)
      .then((result: ReturnResult) => {
        console.log('Tags', '修改密码成功')

        this.success = result.success

        this.message = result.message

        console.log('Result', 'ifsuccess', this.success, this.message)

      })
      .catch((error: string) => {
        console.log('Tags', '修改密码成功')
      })

  }

}

class ReturnResult{
  success: boolean
  message: string

  constructor(success: boolean, message: string) {
    this.success = success
    this.message = message
  }
}