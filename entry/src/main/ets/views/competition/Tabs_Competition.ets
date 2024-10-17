import { CommonConstants } from '../../common/constants/CommonConstants'
import Excellent_Works from '../exercise/excellent_work/Excellent_Works'
import Competition_Finished from './Competition_Finished'
import Competition_Unfinished from './Competition_Unfinished'
import CompetitionInfo from '../../viewmodel/CompetitonInfo'
import CompetitionService from '../../service/CompetitionService'
import ExcellentWorkInfo from '../../viewmodel/ExcellentWorkInfo'
import ExerciseService from  '../../service/ExerciseService'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import Cant_Connect from '../Cant_Connect'

@Component
export default struct Tabs_Competition {
  @State currentIndex: number = 0

  @State userId: number = 0
  //接收的数据
  @State finishCompetition: CompetitionInfo[] = []
  @State unfinishCompetition: CompetitionInfo[] = []

  @State excellentExercise: ExcellentWorkInfo[] = []

  @State ifConnect1: boolean = false
  @State ifConnect2: boolean = false
  @State ifConnect3: boolean = false

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
          if (this.ifConnect1) {
            Competition_Unfinished({ competition: $unfinishCompetition })
          } else {
            Cant_Connect()
          }

        }
        .tabBar(this.TabBarBuilder($r('app.string.competition_unfinished'), 0))

        //2.历史竞赛
        TabContent(){
          if (this.ifConnect2) {
            Competition_Finished({ competition: $finishCompetition })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder($r('app.string.competition_finished'), 1))

        //3.优秀作业
        TabContent(){
          if (this.ifConnect3) {
            Excellent_Works({ excellentWork: $excellentExercise })
          } else {
            Cant_Connect()
          }
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

    CompetitionService.getCompetition('unfinish')
      .then((competition: CompetitionInfo[]) => {
        console.log('Tags', '获取竞赛成功')

        this.unfinishCompetition = competition
        this.ifConnect1 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛失败')
        this.ifConnect1 = false
      })
  }

  //获取竞赛
  async getFinishCompetition(){

    CompetitionService.getCompetition('finish')
      .then((competition: CompetitionInfo[]) => {
        console.log('Tags', '获取竞赛成功')

        this.finishCompetition = competition
        this.ifConnect2 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛失败')
        this.ifConnect2 = false
      })
  }

  //获取优秀作品
  async getExcellentExercise(){

    ExerciseService.getExcellentExercise(1)
      .then((exercise: ExcellentWorkInfo[]) => {
        console.log('Tags', '获取优秀作品成功')

        this.excellentExercise = exercise
        this.ifConnect3 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取优秀作品失败')
        this.ifConnect3 = false
      })
  }

}