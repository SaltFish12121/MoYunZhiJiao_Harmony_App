import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import SystemCopybookItem from '../../../viewitem/SystemCopybookItem'
import SystemTemplateInfo from '../../../viewmodel/SystemTemplateInfo'
import { TemplateType, TypefaceType } from '../../../viewmodel/SystemTemplateInfo'
import ExerciseService from '../../../service/ExerciseService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'
import Cant_Connect from '../../../views/Cant_Connect'

@Extend(ListItem) function exercise_List(){
  .width('95%')
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}


@Entry
@Component
struct NewHistoryPage {
  @State exercise: SystemTemplateInfo[] = [
    /*
    new SystemTemplateInfo(0,TemplateType.alreadyType,'基础笔画练习(2)', '2024-3-3',TypefaceType.KaiTi),
    new SystemTemplateInfo(0,TemplateType.alreadyType,'基础笔画练习(1)', '2024-3-2',TypefaceType.KaiTi)
    */
  ]
  @State title: string = '已有练习'
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  @State ifConnect: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      if (this.ifConnect) {
        List({space: 10}){
          ListItem().height(5)

          ForEach(this.exercise, (exercise: SystemTemplateInfo) => {
            ListItem() {
              SystemCopybookItem({ exercise: exercise })
            }
            .exercise_List()

          })

          ListItem().height(100)
        }
        .alignListItem(ListItemAlign.Center)
        .onReachStart(() => {
          console.log('触顶')
          this.pageNum = 1
          this.getHistoryExercise()
        })
        .onReachEnd(() => {
          console.log('触底了！')

          if(!this.isLoading && this.isMore){
            this.isLoading = true
            // 翻页
            this.pageNum++
            // page = ShopModel.pageNo
            this.getHistoryExercise2()
          }
        })
      } else {
        Cant_Connect()
      }


    }
    .align(Alignment.Top)
    .height('100%')

  }

  onPageShow(){
    //获取已有练习
    this.getHistoryExercise()
  }

  //获取已有练习
  async getHistoryExercise(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await ExerciseService.getExistExercise(this.pageNum)
      .then((exercise: SystemTemplateInfo[]) => {
        console.log('Tags', '获取系统字帖成功')

        this.exercise = exercise

        console.log('Result', '系统模板', this.exercise[0].title, this.exercise[0].type)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取系统字帖失败', error)
        this.ifConnect = false
      })
  }

  //获取已有练习
  async getHistoryExercise2(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await ExerciseService.getExistExercise(this.pageNum)
      .then((exercise: SystemTemplateInfo[]) => {
        console.log('Tags', '获取系统字帖成功')

        //拼接
        this.exercise = this.exercise.concat(exercise)
        this.isLoading = false
        if(!exercise || exercise.length === 0){
          this.isMore = false
        }

        console.log('Result', '系统模板', this.exercise[0].title, this.exercise[0].type)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取系统字帖失败', error)
        this.ifConnect = false
      })
  }
}