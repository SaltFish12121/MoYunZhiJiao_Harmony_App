import { CommonConstants } from '../../common/constants/CommonConstants'
import Excellent_Works from '../exercise/excellent_work/Excellent_Works'
import Competition_Finished from './Competition_Finished'
import Compition_Unfinished from './Competition_Unfinished'
import CompetitionInfo from '../../viewmodel/CompetitonInfo'
import { CompetitionType, IfSignUpType } from '../../viewmodel/CompetitonInfo'
import CompetitionService from '../../service/CompetitionService'
import ExcellentWorkInfo from '../../viewmodel/ExcellentWorkInfo'
import { WorkType } from '../../viewmodel/ExcellentWorkInfo'
import ExerciseService from  '../../service/ExerciseService'
import PreferencesUtil from '../../common/utils/PreferencesUtil'

@Component
export default struct Tabs_Comptition {
  @State currentIndex: number = 0

  @State userId: number = 0
  //接收的数据
  /*@State competition: CompetitionInfo[] = [
    new CompetitionInfo(0,IfSignUpType.unSignUp, CompetitionType.cutOff, '第三次书法竞赛', '2024-6-20 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.unSignUp, CompetitionType.unCutOff, '第三次书法竞赛', '2024-6-20 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.submit, '第四次竞赛', '2024-6-22 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.unSubmit, '全国大赛(2)', '2024-6-24 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.cutOff, '全国大赛(1)', '2024-6-4 13:30', '2024-6-25 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.finish, '第二次书法竞赛', '2024-3-3', '30', 91),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.finish, '第一次书法竞赛', '2024-3-2', '30', 90)
  ]*/
  @State finishCompetition: CompetitionInfo[] = [
    new CompetitionInfo(0,IfSignUpType.unSignUp, CompetitionType.cutOff, '第三次书法竞赛', '2024-6-20 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.unSignUp, CompetitionType.unCutOff, '第三次书法竞赛', '2024-6-20 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.submit, '第四次竞赛', '2024-6-22 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.unSubmit, '全国大赛(2)', '2024-6-24 13:30', '2024-6-29 13:30'),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.cutOff, '全国大赛(1)', '2024-6-4 13:30', '2024-6-25 13:30'),
  ]
  @State unfinishCompetition: CompetitionInfo[] = [
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.finish, '第二次书法竞赛', '2024-3-3', '30', 91),
    new CompetitionInfo(0,IfSignUpType.SignUp, CompetitionType.finish, '第一次书法竞赛', '2024-3-2', '30', 90)
  ]

  @State excellentExercise: ExcellentWorkInfo[] = [
    new ExcellentWorkInfo(0,WorkType.schoolWork, '','横折练习', '2024-3-3'),
    new ExcellentWorkInfo(0,WorkType.competitionWork, '','第一次书法竞赛', '2024-3-2')
  ]

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(14)
        .fontColor($r('app.color.black'))
    }
    .width('100%')
    .height(40)
    .backgroundColor(this.selectColor(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor(index: number){
    return this.currentIndex === index ? $r('app.color.button1') : $r('app.color.gray')
  }

  build() {
    Column(){
      //1. 顶部标题
      Column(){
        Text('书法竞赛')
          .fontSize(CommonConstants.DEFAULT_24)
      }
      .justifyContent(FlexAlign.Center)
      .height(60)

      //2.导航栏：未开始/进行中，历史竞赛，优秀作业
      Tabs({barPosition: BarPosition.Start}){
        //1.未开始/进行中
        TabContent(){
          // Text('未开始/进行中')
          Compition_Unfinished({ competition: $unfinishCompetition })
        }
        .tabBar(this.TabBarBuilder($r('app.string.competition_unfinished'), 0))

        //2.历史竞赛
        TabContent(){
          // Text('历史竞赛')
          Competition_Finished({ competition: $finishCompetition })
        }
        .tabBar(this.TabBarBuilder($r('app.string.competition_finished'), 1))

        //3.优秀作业
        TabContent(){
          // Text('优秀作业')
          Excellent_Works({ excellentWork: $excellentExercise })
        }
        .tabBar(this.TabBarBuilder($r('app.string.competition_excellentWorks'), 2))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
  }

  async aboutToAppear(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    console.log('Tags', 'competition', 'Appear')

    //获取竞赛
    await this.getUnfinishCompetition()
    await this.getFinishCompetition()

    //获取优秀作品
    this.getExcellentExercise()

  }


  //获取竞赛
  async getUnfinishCompetition(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    CompetitionService.getCompetition(this.userId, 'unfinish')
      .then((competition: CompetitionInfo[]) => {
        console.log('Tags', '获取竞赛成功')

        this.unfinishCompetition = competition
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛失败')
      })
  }

  //获取竞赛
  async getFinishCompetition(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    CompetitionService.getCompetition(this.userId, 'finish')
      .then((competition: CompetitionInfo[]) => {
        console.log('Tags', '获取竞赛成功')

        this.finishCompetition = competition
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛失败')
      })
  }

  //获取优秀作品
  async getExcellentExercise(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    ExerciseService.getExcellentExercise(this.userId, 1)
      .then((exercise: ExcellentWorkInfo[]) => {
        console.log('Tags', '获取优秀作品成功')

        this.excellentExercise = exercise
      })
      .catch((error: string) => {
        console.log('Tags', '获取优秀作品失败')
      })
  }

}