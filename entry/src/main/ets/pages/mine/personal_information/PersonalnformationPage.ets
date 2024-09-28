import { Header } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import Detail_Information from '../../../views/mine/personal_information/Detail_Information'
import UserInfo from '../../../viewmodel/user/UserInfo'
import RegionInfo from '../../../viewmodel/user/RegionInfo'
import KlassInfo from '../../../viewmodel/user/KlassInfo'
import router from '@ohos.router'
import UserService from '../../../service/UserService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Extend(Column) function content_formant(){
  .borderRadius(CommonConstants.DEFAULT_20)
  .backgroundColor($r('app.color.start_window_background'))
  .width('100%')
  .height('100%')
}

@Entry
@Component
struct PersonalnformationPage {
  @State userPersonal: UserInfo = new UserInfo( 0, '用户2', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com', '', false)
  @State number: number = 0
  @State grade: string = '未设置'


  build() {
    Column(){
      //1头部
      Header({ isOutControl: true})
        .width('100%')
        .onClick(() => {
          router.back(
            {
              url: 'pages/mainpage/HomePage',
              params: {
                user: this.userPersonal,
                ifSuccess: 1
              }
            }
          )
        })

      //2信息
      Stack({ alignContent: Alignment.TopStart }) {

        Column(){
          Column(){
            // Text(`${this.number}`)
          }
          .width('100%')
          .height(50)


          Column(){
            //详细信息
            Detail_Information({ user: $userPersonal, grade: $grade })
          }
          .content_formant()

        }
        .height('100%')



        Image(/*$r('app.media.userhead_example2')*/this.userPersonal.otherName)
          .clip(new Circle({ width: '100', height: '100' }))
          .margin({left: 30})
          .width(100)
          .onClick(() => {
            console.log('PerInfomation'+this.userPersonal.klass.grade)
          })

      }.width('100%').height('100%').margin({ top: 5 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))
  }


  onPageShow(){
    /*
    const user = router.getParams()
    console.log(`user = ${user['data']}`)
    if (user['ifSuccess'] == 1) {
      this.userPersonal = user['data']
    }

    console.log(`user.gender = ${user['gender']}`)
    if (user['gender'] != null) {
      this.userPersonal.gender = user['gender']
    }
    */

    this.getPersonalInformation()
  }

  //获取个人信息
  async getPersonalInformation(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getPersonal()
      .then((user) => {
        console.log('Tags', '获取个人信息成功')

        this.userPersonal = user
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人信息失败')

      })
  }
}