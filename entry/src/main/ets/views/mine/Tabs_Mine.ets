import router from '@ohos.router'
import userPreferences from '@ohos.data.preferences'
import { CommonConstants } from '../../common/constants/CommonConstants'
import LoginService from '../../service/LoginService'
import UserInfo from '../../viewmodel/user/UserInfo'
import RegionInfo from '../../viewmodel/user/RegionInfo'
import KlassInfo from '../../viewmodel/user/KlassInfo'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import UserService from '../../service/UserService'

@Extend(Column) function content_formant(){
  .padding({top: 30, bottom: 35})
  .borderRadius(CommonConstants.DEFAULT_10)
  .width(CommonConstants.THOUSANDTH_940)
  .backgroundColor(Color.White)
  .height(90)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}


@Component
export default struct Tabs_Mine {

  @Link userPersonal: UserInfo/* = new UserInfo( 0, '王小明', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com', '', true)*/


  build() {
    Column(){
      //1 首部(已登录/有账号）
      if (this.userPersonal!= null && this.userPersonal.id != 0 && this.userPersonal.id != undefined){
        Column(){
          Row(){
            //1 头像
            Row(){
              Image(/*$r('app.media.userhead_example2')*/this.userPersonal.otherName)
                .height(77)
                .width(77)
                .backgroundColor($r('app.color.light_gray'))
                .clip(true)
                .borderRadius(77)
            }

            //2 信息
            Column(){
              Row(){
                //姓名
                Text(this.userPersonal.name)
                  .fontSize(20)
              }
              .height(50)
              .width('100%')

              Row(){
                //学校
                if (this.userPersonal.ifBinding) {
                  Text(this.userPersonal.klass.school)
                } else {
                  Text('未认证学校')
                }


                Blank()

                //几年级
                Text(this.userPersonal.klass.grade)

                //班级
                // Text(this.userPersonal.klass.name+'班')

                Blank()
              }
              .height(50)
              .width('100%')
            }
            .justifyContent(FlexAlign.Center)
            .height('100%')
            .width(200)

            //3 进入
            Row(){
              Image($r('app.media.enter'))
                .width(20)
                .height(28)
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('90%')
          .height('100%')
        }
        .width('100%')
        .height(120)
        .backgroundColor($r('app.color.start_window_background'))
        .shadow({
          radius: 6,
          color: "#000000",
          offsetX: 0,
          offsetY: 2,
        })
        .onClick(() => {
          console.log('Tabs',`Mine user.gender = ${this.userPersonal.gender}`)

          router.pushUrl(
            {
              url: 'pages/mine/personal_information/PersonalnformationPage',
              params: {
                data: this.userPersonal,
                ifSuccess: 1
              }
            }
          )
        })

      } else {
        Column(){
          Row(){
            //1 头像
            Row(){
              Image($r('app.media.user')/*'http://192.168.43.250:8085/upload/images/avatar/e72c3366-7e84-4890-b331-39069638ab88-进步.jpg'*/)
                .height(77)
                .width(77)
                .backgroundColor($r('app.color.light_gray'))
                .clip(true)
                .borderRadius(77)
            }

            //2 信息
            Column(){

              Text('欢迎来到墨韵智教')

            }
            .justifyContent(FlexAlign.Center)
            .height('100%')
            .width(160)

            //3 登录/注册
            Row(){
              Button('登录/注册')
                .fontSize(14)
                .fontColor($r('app.color.blue'))
                .backgroundColor($r('app.color.mid_gray'))
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('90%')
          .height('100%')
        }
        .width('100%')
        .height(120)
        .backgroundColor($r('app.color.start_window_background'))
        .shadow({
          radius: 6,
          color: "#000000",
          offsetX: 0,
          offsetY: 2,
        })
        .onClick(() => {
          if (this.userPersonal != null) {
            console.log('Tabs',`Mine user.gender = ${this.userPersonal.gender}`)
          } else {
            console.log('Tag', 'Mine：aboutToAppear', 'user == null')
          }

          router.replaceUrl(
            {
              url: 'pages/login/LoginPage'
            }
          )
        })
      }


      //2 内容
      Column({space: CommonConstants.SPACE_12}){
        //1 我的收藏
        Column(){
          Row(){
            Row(){
              Image($r('app.media.mine_collect'))
                .width(24)
                .height(24)

              Text($r('app.string.mine_collect'))
            }
            .width(120)
            .justifyContent(FlexAlign.SpaceEvenly)

            Blank()

            Row(){
              Image($r('app.media.enter'))
                .width(20)
                .height(28)
                .margin({"top":"10.00vp","right":"0.00vp","bottom":"0.00vp","left":"0.00vp"})
            }
            .width(40)

          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
        }
        .content_formant()
        .onClick(() => {
          if (this.userPersonal.id != 0 && this.userPersonal.id != undefined) {
            router.pushUrl(
              {
                url: 'pages/mine/mine_collect/MineCollectPage'
              }
            )
          } else {
            router.pushUrl({
              url: 'pages/login/LoginPage'
            })
          }

        })


        //0 数据分析
        Column(){
          Row(){
            Row(){
              Image($r('app.media.dataAnalysis'))
                .width(24)
                .height(24)

              Text('练字分析')
            }
            .width(120)
            .justifyContent(FlexAlign.SpaceEvenly)

            Blank()

            Row(){
              Image($r('app.media.enter'))
                .width(20)
                .height(28)
                .margin({"top":"10.00vp","right":"0.00vp","bottom":"0.00vp","left":"0.00vp"})
            }
            .width(40)

          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
        }
        .content_formant()
        .onClick(() => {
          if (this.userPersonal.id != 0 && this.userPersonal.id != undefined) {
            router.pushUrl(
              {
                url: 'pages/mine/data_analysis/DataAnalysisPage'
              }
            )
          } else {
            router.pushUrl({
              url: 'pages/login/LoginPage'
            })
          }


        })

        //2 客服中心
        Column(){
          Row(){
            Row(){
              Image($r('app.media.customer_service_center'))
                .width(24)
                .height(24)

              Text($r('app.string.mine_customerServiceCenter'))
            }
            .width(120)
            .justifyContent(FlexAlign.SpaceEvenly)

            Blank()

            Row(){
              Image($r('app.media.enter'))
                .width(20)
                .height(28)
                .margin({"top":"10.00vp","right":"0.00vp","bottom":"0.00vp","left":"0.00vp"})
            }
            .width(40)

          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/service_center/ServiceCenterPage'
            }
          )
        })

        //3 我的设置
        Column(){
          Row(){
            Row(){
              Image($r('app.media.set'))
                .width(24)
                .height(24)

              Text($r('app.string.mine_set'))
            }
            .width(120)
            .justifyContent(FlexAlign.SpaceEvenly)

            Blank()

            Row(){
              Image($r('app.media.enter'))
                .width(20)
                .height(28)
                .margin({"top":"10.00vp","right":"0.00vp","bottom":"0.00vp","left":"0.00vp"})
            }
            .width(40)

          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/mine_set/MineSetPage',
              params: {
                phoneNumber: this.userPersonal.phoneNumber,
                email: this.userPersonal.email
              }
            }
          )
        })

        /*
        // 测试图片上传
        Column(){
          Text('测试图片上传')
        }
          .content_formant()
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/UploadImg'
              }
            )
          })
        */

      }
      .margin({top: 20})



    }
    .backgroundColor($r('app.color.light_gray'))
    .width('100%')
    .height('100%')



  }


  async aboutToAppear(){
    if (this.userPersonal != null) {
      console.log('Tag', 'Mine：aboutToAppear', this.userPersonal.id)
    } else {
      console.log('Tag', 'Mine：aboutToAppear', 'user == null')
    }


    if (this.userPersonal.id != 0 && this.userPersonal.id != undefined) {
      await this.getPersonalInformation()
    }
    // this.user1.name = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserName', '默认名') as string



    // console.log('Tag', this.user1.name)
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