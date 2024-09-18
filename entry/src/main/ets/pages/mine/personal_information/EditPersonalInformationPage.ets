import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import UserInfo from '../../../viewmodel/user/UserInfo'
import KlassInfo from '../../../viewmodel/user/KlassInfo'
import RegionInfo from '../../../viewmodel/user/RegionInfo'

@Extend(Row) function edit_row() {
  .height(64)
  .width('95%')
  .alignItems(VerticalAlign.Center)
}

@Extend(Column) function edit_colum() {
  .margin({right: 10})
}

@Entry
@Component
struct EditPersonalInformationPage {
  private enter:number = 5
  @State userPersonal: UserInfo = new UserInfo( 0, '用户3', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com')


  build() {
    Column(){
      //1标题
      // HeaderTitle()
      Row(){
        Column(){
          Image($r('app.media.return'))
        }
        .height(34)
        .width(34)

        Column(){
          Text('编辑资料')
            .fontSize(20)
        }

        Column(){

        }
        .width(34)

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(59)
      .backgroundColor($r('app.color.start_window_background'))
      .onClick(() => {
        router.back({
          url: 'pages/mine/personal_information/PersonalnformationPage',/*
          params: {
            gender: this.userPersonal.gender,
            data: this.userPersonal,
            ifSuccess: 1
          }*/
        })
      })


      Divider()

      //2内容
      Column(){

        //2.1头像
        Row(){
          Text('头像')
            .fontSize(20)

          Blank()

          Column(){
            Image($r('app.media.userhead_example2'))
              .clip(new Circle({ width: '55', height: '55' }))
              .width(55)
          }
          .edit_colum()

          Image($r('app.media.enter'))
            .width('24')
            .margin({top: this.enter})
        }
        .edit_row()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/personal_information/edit_detail/AvatarPage',
              params: {
                avatar: this.userPersonal.otherName
              }
            }
          )
        })

        Divider()


        //2.2名称/姓名
        if (this.userPersonal.ifBinding ){
          Row(){
            Text('名称/姓名')
              .fontSize(20)

            Blank()

            Column(){
              Text(this.userPersonal.name)
                .fontSize(20)
                .fontColor($r('app.color.blue'))
            }
            .edit_colum()

            Image($r('app.media.enter'))
              .width('24')
              .margin({top: this.enter})
          }
          .edit_row()
          .onClick(() => {

          })
        } else {
          Row(){
            Text('名称/姓名')
              .fontSize(20)

            Blank()

            Column(){
              Text(this.userPersonal.name)
                .fontSize(20)
            }
            .edit_colum()

            Image($r('app.media.enter'))
              .width('24')
              .margin({top: this.enter})
          }
          .edit_row()
          .onClick(() => {

            router.pushUrl(
              {
                url: 'pages/mine/personal_information/edit_detail/UserNamePage',
                params:{
                  userName: this.userPersonal.name
                }
              }
            )

          })
        }


        Divider()


        //2.3性别
        Row(){
          Text('性别')
            .fontSize(20)

          Blank()

          Column(){
            Text(this.userPersonal.gender)
              .fontSize(20)
          }
          .edit_colum()

          Image($r('app.media.enter'))
            .width('24')
            .margin({top: this.enter})
        }
        .edit_row()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/personal_information/edit_detail/GenderPage',
              params: {
                gender: this.userPersonal.gender
              }
            }
          )
        })

        Divider()


        //2.4绑定单位
        if (this.userPersonal.ifBinding ){
          Row(){
            Text('绑定单位')
              .fontSize(20)

            Blank()

            Column(){
              Text('已绑定')
                .fontSize(20)
            }
            .edit_colum()

            Image($r('app.media.enter'))
              .width('24')
              .margin({top: this.enter})
          }
          .edit_row()
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/personal_information/edit_detail/UnitPage',
                params: {
                  klass: this.userPersonal.klass,
                  studentNumber: this.userPersonal.studentNumber
                }
              }
            )
          })

        } else {
          Row(){
            Text('学校')
              .fontSize(20)

            Blank()

            Column(){
              Text('未绑定')
                .fontSize(20)
            }
            .edit_colum()

            Image($r('app.media.enter'))
              .width('24')
              .margin({top: this.enter})
          }
          .edit_row()
          .onClick(() => {

          })

        }


        Divider()


        //2.5IP属地
        Row(){
          Text('IP属地')
            .fontSize(20)

          Blank()

          Column(){
            Text(this.userPersonal.region.name)
              .fontSize(20)
          }
          .edit_colum()

          Image($r('app.media.enter'))
            .width('24')
            .margin({top: this.enter})
        }
        .edit_row()
        .onClick(() => {

        })

        Divider()


        //2.6账号管理
        Row(){
          Text('账号管理')
            .fontSize(20)

          Blank()

          Column(){

          }
          .edit_colum()

          Image($r('app.media.enter'))
            .width('24')
            .margin({top: this.enter})
        }
        .edit_row()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/mine/mine_set/account_management/AccountManagementPage',
              params: {
                phoneNumber: this.userPersonal.phoneNumber,
                email: this.userPersonal.email
              }
            }
          )
        })

        Divider()

      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))


    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))

  }


  onPageShow(){
    const user = router.getParams() as PARAMS

    if (user != undefined) {
      console.log(`user = ${user.data}`)


      if (user.gender != null) {
        console.log(`gender = ${user.gender}`)
        this.userPersonal.gender = user.gender
        console.log(this.userPersonal.gender)
      }

      if (user.userName != null) {
        this.userPersonal.name = user.userName
        console.log(this.userPersonal.name)
      }

      if (user.data != null) {
        this.userPersonal = user.data
      }

    }

  }
}

// 声明接受参数的类型
interface PARAMS {
  gender: string
  userName: string
  data: UserInfo
}