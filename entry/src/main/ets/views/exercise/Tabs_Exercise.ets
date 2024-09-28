import { CommonConstants } from '../../common/constants/CommonConstants'
import Excellent_Works from './excellent_work/Excellent_Works'
import School_Exercise from './school_exercise/School_Exercise'
import Self_Exercise from './self_exercise/Self_Exercise'
import ExerciseService from  '../../service/ExerciseService'
import ExerciseInfo from '../../viewmodel/ExerciseInfo'
import { ExerciseType } from '../../viewmodel/ExerciseInfo'
import ExcellentWorkInfo from '../../viewmodel/ExcellentWorkInfo'
import { WorkType } from '../../viewmodel/ExcellentWorkInfo'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import Cant_Connect from '../Cant_Connect'

@Component
export default struct Tabs_Exercise {
  @State currentIndex: number = 0

  userId: number = 0
  //接收的数据
  @State schoolFinishExercise: ExerciseInfo[] = [
    /*
    new ExerciseInfo(0,ExerciseType.schoolExercise, false, '笔画练习（一）', '2024-3-3', '', 0, true),
    new ExerciseInfo(0,ExerciseType.schoolExercise, true, '将进酒', '2024-3-2', '', 0, true)
    */
  ]
  @State schoolUnfinishExercise: ExerciseInfo[] = [
    /*
    new ExerciseInfo(0,ExerciseType.schoolExercise,false ,'笔画练习（一）', '2024-3-3', '', 0, false),
    new ExerciseInfo(0,ExerciseType.schoolExercise,false ,'横折练习', '2024-3-2', '', 0, false)
    */
  ]
  @State selfFinishExercise: ExerciseInfo[] = [
    /*
    new ExerciseInfo(0,ExerciseType.selfExercise,false ,'基础笔画练习(2)', '2024-3-3', '', 90, true),
    new ExerciseInfo(0,ExerciseType.selfExercise,false ,'基础笔画练习(1)', '2024-3-2', '', 91, true)
    */
  ]
  @State selfUnfinishExercise: ExerciseInfo[] = [
    /*
    new ExerciseInfo(0,ExerciseType.selfExercise,false ,'基础笔画练习(2)', '2024-3-3', '', 90, false),
    new ExerciseInfo(0,ExerciseType.selfExercise,false ,'基础笔画练习(1)', '2024-3-2', '', 91, false)
    */
  ]
  @State excellentExercise: ExcellentWorkInfo[] = [
    /*
    new ExcellentWorkInfo(0,WorkType.schoolWork, '','横折练习', '2024-3-3'),
    new ExcellentWorkInfo(0,WorkType.competitionWork, '','第一次书法竞赛', '2024-3-2')
    */
  ]

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
        Text('书法练习')
          .fontSize(CommonConstants.DEFAULT_24)
      }
      .justifyContent(FlexAlign.Center)
      .height(60)

      //2.导航栏：学校作业，自我练习，优秀作业
      Tabs({barPosition: BarPosition.Start}){
        //1.学校作业
        TabContent(){
          // Text('学校作业')
          if (this.ifConnect1) {
            School_Exercise({ schoolFinishExercise: $schoolFinishExercise, schoolUnfinishExercise: $schoolUnfinishExercise  })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder($r('app.string.exercise_homework'), 0))

        //2.自我练习
        TabContent(){
          // Text('自我练习')
          if (this.ifConnect2) {
            Self_Exercise({ selfFinishExercise: $selfFinishExercise, selfUnfinishExercise: $selfUnfinishExercise })
          }
          else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder($r('app.string.exercise_selfExercise'), 1))

        //3.优秀作业
        TabContent(){
          // Text('优秀作业')
          if (this.ifConnect3) {
            Excellent_Works({ excellentWork: $excellentExercise })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder($r('app.string.exercise_excellentWorks'), 2))

      }
      .width('100%')
      .height('100%')
      .onChange(async (index) => {
        this.currentIndex = index

        /*
        if (this.currentIndex == 0) {
          await Promise.all([
            //获取学校练习
            this.getSchoolFinishExercise(),
            this.getSchoolUnfinishExercise(),
            //获取自我练习
            this.getSelfFinishExercise(),
            this.getSelfUnfinishExercise(),
            //获取优秀作品
            this.getExcellentExercise()
          ]);
        }
        */
      })
    }
    .width('100%')
    .height('100%')
  }

  async aboutToAppear(){
    console.log('pageShow')
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    this.userId = 1 //测试

    await Promise.all([
      //获取学校练习
      this.getSchoolFinishExercise(),
      this.getSchoolUnfinishExercise(),
      //获取自我练习
      this.getSelfFinishExercise(),
      this.getSelfUnfinishExercise(),
      //获取优秀作品
      this.getExcellentExercise()
    ]);
    console.log('pageshowed')
  }

  //获取学校作业
  async getSchoolFinishExercise(){
    await ExerciseService.getSchoolExercise('finish', 1)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取学校作业成功')

        this.schoolFinishExercise = exercise
        this.ifConnect1 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取学校作业失败')
        this.ifConnect1 = false
      })
  }
  async getSchoolUnfinishExercise(){
    await ExerciseService.getSchoolExercise('unfinish', 1)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取学校作业成功')

        this.schoolUnfinishExercise = exercise
        this.ifConnect1 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取学校作业失败')
        this.ifConnect1 = false
      })
  }

  //获取自我练习
  async getSelfFinishExercise(){
    await ExerciseService.getMineExercise('finish', 1)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取自我练习成功')

        this.selfFinishExercise = exercise
        this.ifConnect2 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取自我练习失败')
        this.ifConnect2 = false
      })
  }
  async getSelfUnfinishExercise(){
    await ExerciseService.getMineExercise('unfinish', 1)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取自我练习成功')

        this.selfUnfinishExercise = exercise
        this.ifConnect2 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取自我练习失败')
        this.ifConnect2 = false
      })
  }

  //获取优秀作品
  async getExcellentExercise(){
    await ExerciseService.getExcellentExercise(1)
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