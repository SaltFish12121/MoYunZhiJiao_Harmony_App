import router from '@ohos.router'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import { Http } from '../../common/constants/Http'

import InformationService from  '../../service/InformationService'
import UserService from '../../service/UserService'
import ExerciseService from '../../service/ExerciseService'
import CompetitionService from '../../service/CompetitionService'
import LoginService from '../../service/LoginService'

@Component
export default struct MobilePhoneLogin {
  @State userId: number = 0
  @State phoneNumber: string = ''
  @State verify: string = ''
  getPhoneVerify: string = ''
  @State allow:boolean = false

  build() {
    Column(){
      Text('验证码登录')
        .width('90%')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .margin({bottom: 50})

      Column(){
        TextInput({placeholder: '请输入手机号码'})
          .backgroundColor($r('app.color.start_window_background'))
          .onChange(v => {
            this.phoneNumber = v
            this.getPhoneVerify = ''
            this.verify = ''
          })

        Divider()
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('95%')
      .height(70)

      Column() {
        Row() {
          TextInput({ placeholder: '请输入验证码', text: this.verify })
            .width('70%')
            .backgroundColor($r('app.color.start_window_background'))
            .onChange(v => {
              this.verify = v
            })

          Button('获取验证码')
            .backgroundColor($r('app.color.button1'))
            .margin({ top: -20, right: 20 })
            .onClick(() => {

              //发送手机号获取验证码，进入重发倒计时
              if (this.phoneNumber != '') {
                this.getVerify()
              } else {
                AlertDialog.show({
                  message: '手机号格式错误',
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


      //3隐私同意
      Row(){
        Checkbox({name: 'checkbox1',  group: 'checkboxGroup'})
          .select(false)
          .selectedColor($r('app.color.blue'))
          .onChange((value: boolean) => {
            console.info('Checkbox1 change is'+ value)
            this.allow = value
          })

        Text('我已阅读并同意')
          .fontSize(14)

        Text('《隐私政策》')
          .fontColor($r('app.color.blue'))
          .fontSize(14)
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/mine_set/agreement/PrivacyAgreementPage'
              }
            )
          })

        Text('和')
          .fontSize(14)

        Text('《用户协议》')
          .fontColor($r('app.color.blue'))
          .fontSize(14)
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/mine_set/agreement/UserAgreementPage'
              }
            )
          })

      }
      .width('90%')



      //4登录
      Column({space: 30}){
        Button('登录')
          .width('85%')
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {

            //尝试登录
            this.loginUser()

          })

      }
      .margin({top: 40})



    }
    .margin({top: 40})
    .width('100%')
  }


  //获取手机验证码
  getVerify(){
    LoginService.getPhoneVerify(this.phoneNumber)
      .then(verify => {
        console.log('Tags', '获取验证码', verify)

        this.getPhoneVerify = verify
      })
      .catch((error: string) => {
        console.log('Tags', '没有获得验证码')

      })
  }


  //用户登录
  async loginUser(){
    //是否同意隐私条款
    if (this.allow) {
      //勾选
      if (this.verify == this.getPhoneVerify && this.verify != '') {

        await LoginService.login(this.phoneNumber)
          .then((login: loginObject) => {
            console.log('Tags','Enter获取user数据')

            this.userId = login.id

            console.log('Result', 'userId', this.userId)

            //用户数据持久化
            this.preferenceUser(login.id, login.token)

            if (this.userId != 0 && this.userId != undefined ) {
              console.log('Tags', '验证码登录成功')
              router.replaceUrl(
                {
                  url: 'pages/mainpage/HomePage',
                  params: {
                    ifLogin: 1,
                    login: false
                  }
                }
              )
            } else {
              AlertDialog.show({
                message: '登录失败',
                confirm: {
                  value: '确定',
                  action: ()=>{
                  }
                }
              })
            }

          })
          .catch((error: string) => {
            AlertDialog.show({
              message: '登录失败',
              confirm: {
                value: '确定',
                action: ()=>{
                }
              }
            })

            console.log('Tags', '没有在Enter获取user数据')
          })



      } else {
        //验证失败
        console.log(`1: ${this.verify} 2: ${this.getPhoneVerify}`)
        AlertDialog.show({
          message: '验证失败',
          confirm: {
            value: '确定',
            action: ()=>{}
          }
        })

      }



    } else {
      //未勾选
      AlertDialog.show({
        message: '请勾选隐私同意',
        confirm: {
          value: '确定',
          action: ()=>{}
        }
      })
    }
  }

  //用户持久化
  preferenceUser(userId: number, token: string) {
    console.log('MyPreferences', 'UserId', userId)
    // user.name = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserName', '默认名') as string
    PreferencesUtil.putPreferenceValue('MyPreferences', 'UserId', userId)

    //token持久化
    console.log('MyPreferences', 'Token', token)
    PreferencesUtil.putPreferenceValue('MyPreferences', 'Token', token)

    //修改token？是否出现顺序问题
    this.getToken()
  }

  //初始化/修改所有服务的token
  async getToken(){
    await Promise.all([
      CompetitionService.getUserToken(),
      ExerciseService.getUserToken(),
      InformationService.getUserToken(),
      LoginService.getUserToken(),
      UserService.getUserToken()
    ])
  }
}

interface loginObject{
  id: number
  token: string
}