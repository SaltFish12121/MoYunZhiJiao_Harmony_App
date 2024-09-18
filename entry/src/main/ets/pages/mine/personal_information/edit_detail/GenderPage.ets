import router from '@ohos.router'
import { Header } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct GenderPage {
  userId: number = 0
  @State select: boolean = true
  @State gender: string = '男'
  @State success: boolean = false

  build() {
    Column(){
      //1头部
      Column(){
        Stack({alignContent: Alignment.TopEnd}){
          Header()
            .width('95%')

          Row(){
            Text('确定')
              .fontSize(20)
              .fontColor($r('app.color.blue'))
          }
          .height(59)
          .onClick(async () => {
            //保存信息
            await this.alterGender()

            //返回页面
            console.log( 'success' ,this.success)
            if (this.success) {
              UserDBService.updateUserColumnById(this.userId, 'gender', this.gender)
              console.log('DB', 'update', this.userId, 'gender', this.gender)

              router.back({
                url: 'pages/mine/personal_information/EditPersonalInformationPage',
                params: {
                  gender: this.gender
                }
              })
            } else {
              AlertDialog.show({
                message: '更改性别失败',
                confirm: {
                  value: '确定',
                  action: ()=>{
                  }
                }
              })
            }


          })


        }

      }
      .backgroundColor($r('app.color.start_window_background'))
      .width('100%')


      Divider()


      //2内容
      Column(){
        Row(){
          Text('男')
            .fontSize(20)

          Blank()

          if (this.select==true) {
            Column(){
              Image($r('app.media.single_check'))
                .width(26)
            }
          }


        }
        .height(64)
        .width('90%')
        .onClick(() => {
          this.select = true
          this.gender = '男'
        })

        Divider()

        Row(){
          Text('女')
            .fontSize(20)

          Blank()

          if (this.select==false) {
            Column(){
              Image($r('app.media.single_check'))
                .width(26)
            }
          }

        }
        .height(64)
        .width('90%')
        .onClick(() => {
          this.select = false
          this.gender = '女'
        })

      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))

      Divider()

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))

  }


  async onPageShow(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number
    this.userId = 32

    const gender = router.getParams() as PARAMS

    this.gender = gender.gender

    if (this.gender == '女') {
      this.select = false
    } else {
      this.select = true
    }
  }


  //修改性别
  async alterGender(){
    await UserService.alterGender(this.userId, this.gender)
      .then((success) => {
        console.log('Tags', '修改性别成功')

        this.success = success

        console.log('Result', 'ifsuccess', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '修改性别失败')

      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  gender: string
}