import router from '@ohos.router'
import { Header_close } from '../../../common/components/CommonComponents'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'
import UserInfo from '../../../viewmodel/user/UserInfo'
import { Http } from '../../../common/constants/Http'

import InformationService from  '../../../service/InformationService'
import UserService from '../../../service/UserService'
import ExerciseService from '../../../service/ExerciseService'
import CompetitionService from '../../../service/CompetitionService'
import LoginService from '../../../service/LoginService'

@Entry
@Component
struct StudentEnter {
  @State userId: number = 0
  @State userName: string = ''
  @State userPassword: string = ''
  @State allow:boolean = false

  @State nameColor: ResourceColor = $r('app.color.text_gray')
  @State passwordColor: ResourceColor = $r('app.color.text_gray')
  @State placeholderName: string = '账号'
  @State placeholderPassword: string = '请输入密码'

  build() {
    Column(){
      //1头部
      Header_close()
        .width('95%')

      //2登录输入
      Column(){
        Text('学校账号登录')
          .width('90%')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .margin({bottom: 50})

        Column(){
          TextInput({placeholder: this.placeholderName})
            .backgroundColor($r('app.color.start_window_background'))
            .placeholderColor(this.nameColor)
            .onChange((v) => {
              this.userName = v
            })

          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        Column(){
          Row(){
            TextInput({placeholder: this.placeholderPassword})
              .width('75%')
              .backgroundColor($r('app.color.start_window_background'))
              .placeholderColor(this.passwordColor)
              .onChange((v) => {
                this.userPassword = v
              })

            Text('忘记密码？')
              .fontColor($r('app.color.text_gray'))
              .onClick(() => {
                router.pushUrl(
                  {
                    url: 'pages/mine/service_center/ServiceCenterPage'
                  }
                )
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
        Column(){
          Button('登录')
            .width('85%')
            .backgroundColor($r('app.color.button1'))
            .onClick(async () => {

              if (this.userName == '') {
                this.placeholderName = '账号不能为空'
                this.nameColor = Color.Red
              } else {
                if (this.userPassword == '') {
                  this.placeholderPassword = '密码不能为空'
                  this.passwordColor = Color.Red
                } else {
                  //1.判断用户登录
                  await this.loginUser()
                }
              }


            })
        }
        .margin({top: 40})



      }
      .margin({top: 40})
      .width('100%')
    }

  }


  async loginUser(){
    if (this.allow) {
      console.log(`userName = ${this.userName} : userPassword = ${this.userPassword}`)

      await LoginService.login(this.userName, this.userPassword)
        .then((login: loginObject) => {
          console.log('Tags','Enter获取user数据')

          this.userId = login.id

          console.log('Result', 'userId', this.userId, login.token)

          //用户数据持久化
          this.preferenceUser(login.id, login.token)

          if (this.userId != 0 && this.userId != undefined ) {
            router.replaceUrl(
              {
                url: 'pages/mainpage/HomePage',
                params:{
                  ifLogin: 1,
                  login: true
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
        .catch(async (error: string) => {
          console.log('Tags', '没有在Enter获取user数据')

          AlertDialog.show({
            message: '登录失败',
            confirm: {
              value: '确定',
              action: ()=>{
              }
            }
          })

          // //测试用
          // if (this.userName == '666' && this.userPassword == '666') {
          //   await this.preferenceUser(666, '0')
          //
          //   router.replaceUrl(
          //     {
          //       url: 'pages/mainpage/HomePage',
          //       params:{
          //         ifLogin: 1,
          //         login: true
          //       }
          //     }
          //   )
          // } else {
          //   AlertDialog.show({
          //     message: '登录失败',
          //     confirm: {
          //       value: '确定',
          //       action: ()=>{
          //       }
          //     }
          //   })
          // }

        })

    } else {
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