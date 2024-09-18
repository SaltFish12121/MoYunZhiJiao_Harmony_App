import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import LoginService from '../../../../service/LoginService'
import UserService from '../../../../service/UserService'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct ModifyMobilePhonePage {
  userId: number = 0
  @State title: string = '手机号'

  @State newPhoneNumber: string = ''
  @State getPhoneVerify: string = ''
  @State success: boolean = false
  @State verify : string = ''

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      Divider()

      //2输入
      Column(){
        Column(){
          TextInput({placeholder: '请输入新手机号'})
            .backgroundColor($r('app.color.start_window_background'))
            .onChange((v) => {
              this.newPhoneNumber = v
            })

          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)



        Column() {
          Row() {
            TextInput({ placeholder: '请输入验证码' })
              .width('75%')
              .backgroundColor($r('app.color.start_window_background'))
              .onChange(v => {
                this.verify = v
              })

            Text('获取验证码')
              .width('25%')
              .fontColor($r('app.color.blue'))
              .onClick(async () => {

                //发送手机号获取验证码，进入重发倒计时
                if (this.newPhoneNumber != '') {
                  await this.getVerify()

                } else {
                  AlertDialog.show({
                    message: '手机号格式不正确',
                    confirm: {
                      value: '确定',
                      action: ()=>{}
                    }
                  })
                }


              })

          }



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

          if (this.getPhoneVerify == this.verify && this.verify != ''){
            //1修改手机号
            await this.alterPhoneNumber()

            //2是否修改成功
            console.log('success',this.success)
            if (this.success) {
              UserDBService.updateUserColumnById(this.userId, 'phoneNumber', this.newPhoneNumber)
              console.log('DB', 'update', this.userId, 'phoneNumber', this.newPhoneNumber)

              router.back(
                {
                  url: 'pages/mine/mine_set/account_management/AccountManagementPage',
                  params: {
                    phoneNumber: this.newPhoneNumber,
                  }
                }
              )
              /*
              AlertDialog.show({
                message: '手机号更改成功',
                confirm: {
                  value: '确定',
                  action: ()=>{
                    router.back()
                  }
                }
              })
              */
            } else {
              AlertDialog.show({
                message: '手机号更改失败',
                confirm: {
                  value: '确定',
                  action: ()=>{}
                }
              })
            }
          } else {
            AlertDialog.show({
              message: '验证码错误',
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
  }

  //获取手机验证码
  getVerify(){
    LoginService.getPhoneVerify(this.newPhoneNumber)
      .then((verify: string) => {
        console.log('Tags', '获取验证码', verify)

        this.getPhoneVerify = verify
      })
      .catch((error: string) => {
        console.log('Tags', '没有获得验证码')

      })
  }

  //修改电话号
  async alterPhoneNumber(){
    await UserService.alterPhoneNumber(this.userId, this.newPhoneNumber)
      .then((success) => {
        console.log('Tags', '修改电话号成功')

        this.success = success

        console.log('Result', 'ifsuccess', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '修改电话号失败')

      })
  }
}