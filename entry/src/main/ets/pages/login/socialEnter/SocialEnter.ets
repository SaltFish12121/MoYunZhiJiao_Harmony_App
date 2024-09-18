import router from '@ohos.router'
import { Header_close } from '../../../common/components/CommonComponents'
import MobilePhoneLogin from '../../../views/login/MobilePhoneLogin'
import PasswordLogin from '../../../views/login/PasswordLogin'

@Entry
@Component
struct SocialEnter {
  @State login_type: string[] = ['验证码登录','账号密码登录']
  @State index: number = 0

  build() {
    Column(){

      //1头部
      Stack({alignContent: Alignment.TopEnd}){
        Header_close()
          .width('95%')

        Row(){
          Text(`${this.login_type[this.index]}`)
        }
        .height(59)
        .onClick(() => {
          this.index+=1
          this.index%=2
        })

      }



      if (this.index==0){
        //2登录输入
        PasswordLogin()
      }
      else {
        //3验证码登录
        MobilePhoneLogin()
      }


    }

  }
}