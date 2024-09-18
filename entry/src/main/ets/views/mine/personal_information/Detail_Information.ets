import router from '@ohos.router'
import UserInfo from '../../../viewmodel/user/UserInfo'
import UserGradeDialog from '../../../views/mine/personal_information/UserGradeDialog'


@Component
export default struct Detail_Information {
  @Link user: UserInfo

  @Link grade: string
  // @Link number: number

  controller: CustomDialogController = new CustomDialogController({
    builder: UserGradeDialog({
      confirm: (e: string) => {
        this.user.klass.grade = e
        this.grade = e
      }

    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: 0 },
    // autoCancel: false,
    //完全依靠外部样式控制,否则会有宽度限制和默认圆角, 这里需要的就是要自己控制样式
    customStyle: true
  })

  build() {
    Column({space: 15}){

      //编辑资料
      Column(){
        Text('编辑资料')
          .fontSize(14)
          .height(29)
          .width(70)
          .textAlign(TextAlign.Center)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
      }
      .margin({top: 10})
      .width('90%')
      .height(40)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.End)
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mine/personal_information/EditPersonalInformationPage',
            params: {
              data: this.user,
              ifSuccess: 1
            }
          }
        )
      })


      //姓名
      Row(){
        Text(this.user.name)
          .fontSize(36)

        //性别
        if (this.user.gender == '女') {
          Image($r('app.media.gender_woman'))
            .width(28)
        } else {
          Image($r('app.media.gender_man'))
            .width(28)
        }

      }
      .margin({top: 5})
      .width('85%')


      //是否认证
      Row(){
        if (this.user.ifBinding){
          Row({space: 5}){

            Image($r('app.media.authenticated'))
              .margin({left: 10})
              .width(24)

            Text('已认证')
              .margin({right: 10})
              .fontSize(14)
          }
          .backgroundColor($r('app.color.mid_gray'))
          .height(30)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 20, style: BorderStyle.Solid })

        } else {
          Row({space: 5}){

            Image($r('app.media.unverified'))
              .margin({left: 10})
              .width(24)

            Text('未认证')
              .margin({right: 10})
              .fontSize(14)
          }
          .backgroundColor($r('app.color.mid_gray'))
          .height(30)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 20, style: BorderStyle.Solid })

        }



      }
      .width('85%')

      //IP属地
      Row(){
        Text('IP属地：')
          .fontSize(16)

        Text(this.user.region.name)
          .fontSize(16)
      }
      .width('85%')
      .margin({bottom: 30})

      //学校班级
      Row({space: 10}){
        Image($r('app.media.school'))
          .width(24)

        if (this.user.ifBinding) {
          Text(this.user.klass.school)

          Blank()

          Text(this.user.klass.grade)

          Text(this.user.klass.name+'班')

          Blank()

        } else {

          Text(this.grade)
            .onClick(() => {
              console.log('grade'+this.user.klass.grade)
              // this.number++
              this.controller.open()
            })
        }

      }
      .width('85%')

      //学号
      Row({space: 10}){
        Image($r('app.media.student_number'))
          .width(24)

        Text(this.user.studentNumber)
      }
      .width('85%')

      //教师
      Row({space: 10}){
        Image($r('app.media.teacher'))
          .width(24)

        if (this.user.klass.teacher != ''){
          Text(this.user.klass.teacher+'（教师）')
        }

      }
      .width('85%')

      //电话
      Row({space: 10}){
        Image($r('app.media.phone'))
          .width(24)

        Text(this.user.phoneNumber)
      }
      .width('85%')

      //邮箱
      Row({space: 10}){
        Image($r('app.media.email'))
          .width(24)

        Text(this.user.email)
      }
      .width('85%')


      // Text(`${this.number}`)
      //   .onClick(() => {
      //     this.number++
      //   })

    }

  }
}