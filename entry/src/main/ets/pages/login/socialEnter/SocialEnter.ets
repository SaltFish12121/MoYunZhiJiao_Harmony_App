import { Header_close } from '../../../common/components/CommonComponents'
import MobilePhoneLogin from '../../../views/login/MobilePhoneLogin'
import PasswordLogin from '../../../views/login/PasswordLogin'

//社会登录
@Entry
@Component
struct SocialEnter {
  @State login_type: string[] = ['验证码登录','账号密码登录']
  @State index: number = 0

  build() {
    Column(){

      //1 头部
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
        //2 登录输入
        PasswordLogin()
      }
      else {
        //3 验证码登录
        MobilePhoneLogin()
      }


    }

  }
}