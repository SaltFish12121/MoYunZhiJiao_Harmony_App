import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct ModifyEmailPage {
  userId: number = 0
  @State title: string = '邮箱'

  @State oldEmail: string = ''
  @State email: string = ''
  @State newEmail: string = ''
  @State success: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      Divider()

      //2输入
      Column(){
        Column(){
          Row({space: 10}){
            Text('当前邮箱:')
              .fontSize(20)
              .backgroundColor($r('app.color.start_window_background'))

            Text(/*'邮箱号'*/this.oldEmail)
              .fontSize(18)
          }
          .width('90%')
          .margin({bottom: 5})


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        Column(){
          TextInput({placeholder: '请输入新邮箱'})
            .backgroundColor($r('app.color.start_window_background'))
            .onChange((v) => {
              this.email = v
            })

          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)



      }
      .margin({top: 40})


      //3完成按钮
      Button('完成')
        .margin({top: 40})
        .type(ButtonType.Normal)
        .backgroundColor($r('app.color.button1'))
        .width('90%')
        .borderRadius(10)
        .onClick(async () => {

          //1修改邮箱
          await this.alterEmail()

          //2是否修改成功
          console.log('success',this.success)
          if (this.success) {
            UserDBService.updateUserColumnById(this.userId, 'email', this.email)
            console.log('DB', 'update', this.userId, 'email', this.email)

            router.back(
              {
                url: 'pages/mine/mine_set/account_management/AccountManagementPage',
                params: {
                  email: this.email,
                }
              }
            )

          } else {
            AlertDialog.show({
              message: '邮箱更改失败',
              confirm: {
                value: '确定',
                action: ()=>{}
              }
            })
          }
        })

    }


  }

  async onPageShow(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number
    this.userId = 32

    const email = router.getParams() as PARAMS
    this.oldEmail = email.email
  }

  //修改邮箱
  async alterEmail(){
    await UserService.alterEmail(this.userId, this.email)
      .then((success: boolean ) => {
        console.log('Tags', '修改邮箱成功')

        this.success = success

        console.log('Result', 'ifsuccess', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '修改邮箱失败')

      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  email: string
}