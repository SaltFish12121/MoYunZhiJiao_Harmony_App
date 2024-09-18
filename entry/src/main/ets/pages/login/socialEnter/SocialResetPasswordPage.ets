import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import LoginService from '../../../service/LoginService'

@Entry
@Component
struct SocialResetPasswordPage {
  phoneNumber: string = ''
  @State newPassword: string = ''
  @State format: boolean = false
  @State success: boolean = false

  @State title: string = '重置密码'

  build() {
    Column(){
      //1头部
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

      //2输入
      Column() {
        Column() {
          TextInput({ placeholder: '新密码' })
            .backgroundColor($r('app.color.start_window_background'))
            .onChange(v => {
              this.newPassword = v

              this.ifFormat()

            })

          Divider()
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width('95%')
        .height(70)

        //提示
        Column(){
          Text('密码要求8-16位，至少包含数字、字母、"_"两种元素')
            .fontSize(14)
            .fontColor($r('app.color.text_gray'))
        }

      }
      .margin({ top: 40 })

      //3按钮
      Column(){
        Button('确认')
          .width('90%')
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {

            this.updatePassword()

          })
      }
      .width('100%')
      .margin({top: 50})


    }
  }

  //格式是否正确
  ifFormat(){
    if (this.newPassword != '') {
      this.format = true
    }
  }


  //更新密码
  async updatePassword(){
    if (this.format){
      //格式正确

      await LoginService.forgetPassword(this.phoneNumber,this.newPassword)
        .then(success => {

          if (success) {
            console.log('Tags', '成功修改密码')
          } else {
            console.log('Tags', '没有成功修改密码2')
          }

          this.success = success

        })
        .catch((error: string) => {
          this.success = false

          console.log('Tags', '没有成功修改密码1')
        })

      if (this.success) {
        AlertDialog.show({
          message: '密码修改成功',
          confirm: {
            value: '确定',
            action: ()=>{
              router.back()
              router.back()
            }
          }
        })
      } else {
        AlertDialog.show({
          message: '密码修改失败',
          confirm: {
            value: '确定',
            action: ()=>{
            }
          }
        })
      }



    } else {
      //格式错误
      AlertDialog.show({
        message: '新密码格式错误',
        confirm: {
          value: '确定',
          action: ()=>{}
        }
      })

    }


  }



  onPageShow(){
    const params = router.getParams() as PARAMS

    this.phoneNumber = params.data1
    console.log(`phoneNumber = ${this.phoneNumber}`)
  }
}

// 声明接受参数的类型
interface PARAMS {
  data1: string
}