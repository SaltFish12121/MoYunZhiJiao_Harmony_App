import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct UserNamePage {
  controller: TextInputController = new TextInputController()

  @State userId: number = 0
  @State title: string = '姓名修改'
  @State userName: string = '小李'
  @State success: boolean = false

  build() {
    Column(){
      Column(){
        //1头部
        Stack({ alignContent: Alignment.TopEnd }){
          HeaderTitle({ title: $title })

          Row(){

            Text('保存')
              .fontSize(16)
              .fontColor($r('app.color.button1'))
              .onClick(async () => {
                console.log('保存')

                //保存信息
                await this.alterUserName()

                console.log( 'success' ,this.success)
                if (this.success) {
                  UserDBService.updateUserColumnById(this.userId, 'name', this.userName)
                  console.log('DB', 'update', this.userId, 'name', this.userName)
                  //返回页面
                  router.back({
                    url: 'pages/mine/personal_information/EditPersonalInformationPage',
                    params: {
                      userName: this.userName
                    }
                  })

                } else {
                  AlertDialog.show({
                    message: '更改姓名失败',
                    confirm: {
                      value: '确定',
                      action: ()=>{
                      }
                    }
                  })
                }


              })
          }
          .height(59)
          .width('10%')
        }
        .width('100%')


        Divider()

        Column(){
          TextInput({ text: this.userName, placeholder: '请输入用户名', controller: this.controller })
            .placeholderColor(Color.White)
            .fontColor(Color.Gray)
            .backgroundColor(Color.White)
            .onChange((v) => {
              this.userName = v
            })

        }
        .padding(10)

        Divider()
      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))
  }

  async onPageShow(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number
    this.userId = 32//测试使用

    const user = router.getParams() as PARAMS
    if (user.userName != null) {
      this.userName = user.userName
    }

  }

  //修改用户名
  async alterUserName(){
    await UserService.alterUserName(this.userId, this.userName)
      .then((success) => {
        console.log('Tags', '修改用户名成功')

        this.success = success

        console.log('Result', 'ifsuccess', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '修改用户名失败')

      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  userName: string
}