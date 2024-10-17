import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import LoginService from '../../../service/LoginService'

const TOTAL_COUNT = 30

//忘记密码
@Entry
@Component
struct SocialForgetPassword {
  @State count: number = TOTAL_COUNT
  timerId: number = -1
  isPaused: boolean = false
  isBack: boolean = false
  @State buttonText: string = '获取验证码'

  @State phoneNumber: string = ''
  @State verify: string = ''
  getPhoneVerify: string = ''

  @State title: string = '忘记密码'

  build() {
    Column() {
      //1 头部
      Stack({ alignContent: Alignment.TopEnd }) {
        HeaderTitle({ title: $title })
          .width('95%')

        Row() {
          Text('客服')
            .fontSize(16)
        }
        .height(59)
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/service_center/ServiceCenterPage'
            }
          )
        })
      }

      //2 输入
      Column() {
        Column() {
          TextInput({ placeholder: '请输入手机号码' })
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

            Button(this.buttonText)
              .enabled(this.count === TOTAL_COUNT)
              .backgroundColor($r('app.color.button1'))
              .fontColor($r('app.color.start_window_background'))
              .margin({ top: -20, right: 20 })
              .onClick(async() => {

                //发送手机号获取验证码，进入重发倒计时
                if (this.phoneNumber != '' && this.phoneNumber.length === 11 ) {
                  this.startTimer()
                  await this.getVerify()
                  AlertDialog.show({
                    message: '验证码已发送'
                  })
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

        }
        .margin({ top: 40 })

      //3 按钮
      Column(){
        Button('下一步')
          .width('90%')
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {

            //判断验证码是否正确
            this.ifVerity()


          })
      }
      .width('100%')
      .margin({top: 20})



    }
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

  //判断验证码是否正确
  ifVerity(){
    if (this.verify == this.getPhoneVerify && this.verify != '') {
      //验证成功
      router.pushUrl(
        {
          url: 'pages/login/socialEnter/SocialResetPasswordPage',
          params: {
            data1: this.phoneNumber
          }
        }
      )
    } else {
      //验证失败
      AlertDialog.show({
        message: '验证码错误',
        confirm: {
          value: '确定',
          action: ()=>{}
        }
      })

    }
  }

  async onPageShow(){
    !this.isBack && this.resumeTimer()
  }

  onPageHide(): void {
    this.pauseTimer()
  }

  aboutToDisappear(): void {
    clearInterval(this.timerId)
    this.buttonText = '获取验证码'
  }

  startTimer() {
    this.timerId = setInterval(() => {
      this.count--
      this.buttonText = `${this.count}s`
      this.isBack = false
      if (this.count < 0) {
        clearInterval(this.timerId)
        this.buttonText = '获取验证码'
        this.count = TOTAL_COUNT
      }
    }, 1000)
  }

  pauseTimer() {
    if (!this.isPaused) {
      this.isPaused = true;
      clearInterval(this.timerId)
      this.buttonText = '获取验证码'
    }
  }

  resumeTimer() {
    if (this.isPaused) {
      this.isPaused = false
      this.startTimer()
    }
  }
}