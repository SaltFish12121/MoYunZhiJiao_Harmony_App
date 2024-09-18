import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import LoginService from '../../../service/LoginService'

@Entry
@Component
struct SocialRegister {
  @State userName: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @State phoneNumber: string = ''
  @State verify: string = ''
  @State email: string = ''
  @State allow:boolean = false
  @State register: boolean = false

  getPhoneVerify: string = ''

  @State title: string = '注册'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      //2注册内容
      Column(){
        //用户名
        Column(){
          Row(){
            Text('用户名')
              .margin({left: 10})
              .width(70)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)

            TextInput({placeholder: '请输入用户名'})
              .textAlign(TextAlign.End)
              .backgroundColor($r('app.color.start_window_background'))
              .width('75%')
              .onChange(v => {
                this.userName = v
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //密码
        Column(){
          Row(){
            Text('密码')
              .margin({left: 10})
              .width(70)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)

            TextInput({placeholder: '字母、数字或"_"组合，8-16位'})
              .textAlign(TextAlign.End)
              .backgroundColor($r('app.color.start_window_background'))
              .width('75%')
              .onChange(v => {
                this.password = v
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //确认密码
        Column(){
          Row(){
            Text('确认密码')
              .margin({left: 10})
              .width(79)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)


            TextInput({placeholder: '请再次输入密码'})
              .textAlign(TextAlign.End)
              .backgroundColor($r('app.color.start_window_background'))
              .width('75%')
              .onChange(v => {
                this.confirmPassword =v
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //手机号
        Column(){
          Row(){
            Text('手机号')
              .margin({left: 10})
              .width(70)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)

            TextInput({placeholder: '请输入手机号码'})
              .textAlign(TextAlign.End)
              .backgroundColor($r('app.color.start_window_background'))
              .width('75%')
              .onChange(v => {
                this.phoneNumber = v
                this.verify = ''
                this.getPhoneVerify = ''
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //验证码
        Column(){
          Row(){
            Text('验证码')
              .margin({left: 10})
              .width(70)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)

            Row(){
              TextInput({placeholder: '请输入验证码', text: this.verify})
                .textAlign(TextAlign.End)
                .backgroundColor($r('app.color.start_window_background'))
                .width('45%')
                .onChange(v => {
                  this.verify = v
                })

              Button('获取验证码')
                .backgroundColor($r('app.color.button1'))
                .margin({ top: -20, right: 20 })
                .onClick(() => {

                  //发送手机号获取验证码，进入重发倒计时
                  this.getVerify()
                })
            }

          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //电子邮箱
        Column(){
          Row(){
            Text('电子邮箱')
              .margin({left: 10})
              .width(79)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Start)

            TextInput({placeholder: '请输入电子邮箱号码'})
              .textAlign(TextAlign.End)
              .backgroundColor($r('app.color.start_window_background'))
              .width('75%')
              .onChange(v => {
                this.email = v
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)


          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)


      }
      .margin({top: 30})
      .width('100%')

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


      //4注册按钮
      Column({space: 30}){

        Button('注册')
          .width('85%')
          .backgroundColor($r('app.color.button1'))
          .fontColor($r('app.color.start_window_background'))
          .onClick(() => {

            //请求前提
            if (this.ifCan()) {
              this.ifCanRegister()
            }

          })
      }
      .margin({top: 40})

    }

  }

  ifCan(){
    let success: boolean = false
    let reason: string = ''
    if (this.allow) {
      if (this.userName != '') {
        if (this.password != '') {
          if (this.confirmPassword == this.password) {
            if (this.phoneNumber != '') {
              if (this.verify == this.getPhoneVerify && this.verify != '') {
                success = true
              } else {
                //验证码
                reason = '验证码输入错误'
              }
            } else {
              //手机号
              reason = '手机号输入不符合格式'
            }
          } else {
            //确认密码
            reason = '两次密码不相同'
          }
        } else {
          //密码
          reason = '密码输入不符合格式'
        }
      } else {
        //用户名
        reason = '用户名不能为空'
      }
    } else {
      //勾选协议
      reason = '未勾选同意隐私权限'
    }

    if (!success) {
      AlertDialog.show({
        message: reason,
        confirm: {
          value: '确定',
          action: ()=>{}
        }
      })
    }

    return success

  }

  //判断是否符合条件能够注册
  async ifCanRegister(){
    // const reason: string = ''
    //先注册尝试
    await this.canRegister()

    //得到能否注册的结果
    this.ifRegister()
  }

  //获取手机验证码
  getVerify(){
    LoginService.getPhoneVerify(this.phoneNumber)
      .then((verify: string) => {
        console.log('Tags', '获取验证码', verify)

        this.getPhoneVerify = verify

        console.log('Result', '验证码', this.getPhoneVerify)
      })
      .catch((error: string) => {
        console.log('Tags', '没有获得验证码')

      })
  }


  //注册
  async canRegister(){
    await LoginService.register(this.userName,this.password,this.phoneNumber,this.email)
      .then((success: boolean) => {
        if (success) {
          //注册成功
          console.log('注册成功')
        } else {
          //注册失败
          console.log('注册失败')
        }

        this.register = success

      })
      .catch(() => {
        //注册失败
        console.log('注册失败')

        this.register = false

      })
  }


  //是否注册
  ifRegister(){
    console.log('ifRegister',this.register)
    if (this.register) {
      router.pushUrl(
        {
          url: 'pages/login/socialEnter/SocialEnter'
        }
      )
    } else {
      AlertDialog.show({
        message: `账号已存在，注册失败`,
        confirm: {
          value: '确定',
          action: ()=>{}
        }
      })
    }
  }

}