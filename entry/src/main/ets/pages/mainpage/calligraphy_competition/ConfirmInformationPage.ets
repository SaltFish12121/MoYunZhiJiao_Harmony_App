import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import UserService from '../../../service/UserService'
import UserInfo from '../../../viewmodel/user/UserInfo'
import RegionInfo from '../../../viewmodel/user/RegionInfo'
import KlassInfo from '../../../viewmodel/user/KlassInfo'
import CompetitionInformInfo from '../../../viewmodel/CompetitionInformInfo'
import CompetitionService from '../../../service/CompetitionService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Entry
@Component
struct ConfirmInformationPage {

  @State userPersonal: UserInfo = new UserInfo( 0, '用户2', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com', '', false)
  @State competitionId: number = 0
  @State competitionTitle: string = ''

  arr: number[] = [0,1,2,3,4,5,6,7,8]
  arr1: string[] = ['报名项目', '姓名', '性别','证件号', '学校', '班级', '教师', '手机号', '邮箱号']
  @State arr2: string[] = ['项目名称', '王小明', '男', '202293290123', '盘龙小学', '二年级（1）班', '李梅', '18912234567', '2612345678@qq.com']

  @State title: string = '信息确认'
  @State success: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title})

      //2信息
      Column(){
        ForEach(
          this.arr,
          (arr: number) => {
            Row(){
              Text(this.arr1[arr])
                .fontSize(20)
                .textAlign(TextAlign.Start)
                .width('30%')

              Text(this.arr2[arr])
                .fontSize(20)
                .textAlign(TextAlign.Center)
                .width('70%')
            }
            .height(50)
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Start)
          }
        )

      }
      .width('80%')
      .margin({top: 50, bottom: 50})

      //3是否报名
      Row(){
        Column(){
          Text('取消报名')
            .fontSize(16)
            .fontColor($r('app.color.black'))
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .border({ width: 1, color: $r('app.color.button2'), radius: 20, style: BorderStyle.Solid })
        .backgroundColor($r('app.color.button2'))
        .width('45%')
        .height(65)
        .onClick(() => {
          router.back()
        })

        Column(){
          Text('确认报名')
            .fontSize(16)
            .fontColor($r('app.color.start_window_background'))
        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .border({ width: 1, color: $r('app.color.button1'), radius: 20, style: BorderStyle.Solid })
        .backgroundColor($r('app.color.button1'))
        .width('45%')
        .height(65)
        .onClick(async () => {
          await this.signUpCompetition()

          if (this.success) {
            AlertDialog.show({
              message: '信息提交成功',
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
              message: '不符合报名条件，报名失败',
              confirm: {
                value: '确定',
                action: ()=>{
                }
              }
            })
          }


        })

      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')

    }

  }

  onPageShow(){
    const competition = router.getParams() as PARAMS

    this.competitionId = competition.id
    this.competitionTitle = competition.title

    this.getPersonalInformation()
  }

  //获取个人信息
  async getPersonalInformation(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await UserService.getPersonal()
      .then((user) => {
        console.log('Tags', '获取个人信息成功')

        this.userPersonal = user
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人信息失败')

      })

    /*  @State arr2: string[] = ['项目名称', '王小明', '男', '202293290123', '盘龙小学', '二年级（1）班', '李梅', '18912234567', '2612345678@qq.com']*/
    this.arr2[0] = this.competitionTitle
    this.arr2[1] = this.userPersonal.name
    this.arr2[2] = this.userPersonal.gender
    this.arr2[3] = this.userPersonal.studentNumber
    this.arr2[4] = this.userPersonal.klass.school
    this.arr2[5] = `${this.userPersonal.klass.grade}${this.userPersonal.klass.name}`
    this.arr2[6] = this.userPersonal.klass.teacher
    this.arr2[7] = this.userPersonal.phoneNumber
    this.arr2[8] = this.userPersonal.email
  }

  //竞赛报名
  async signUpCompetition(){
    await CompetitionService.signUpCompetition(this.userPersonal.id, this.competitionId)
      .then((success) => {
        console.log('Tags', '竞赛报名成功')

        this.success = success
      })
      .catch((error: string) => {
        console.log('Tags', '竞赛报名失败')

      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  id: number
  title: string
}