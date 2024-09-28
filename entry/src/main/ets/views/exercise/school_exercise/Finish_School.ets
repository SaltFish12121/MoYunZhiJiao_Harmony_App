import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import ExerciseItem from '../../../viewitem/ExerciseItem'
import ExerciseInfo from '../../../viewmodel/ExerciseInfo'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'
import ExerciseService from  '../../../service/ExerciseService'

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


@Component
export default struct Finish_School {
  @Link exercise: ExerciseInfo[]
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){
      List({space: 10}){
        ListItem().height(5)

        ForEach(
          this.exercise ,
          (exercise: ExerciseInfo) => {

            if (exercise.finish == true){
              ListItem() {
                ExerciseItem({ exercise: exercise })
              }
              .exercise_List()
              .onClick(() => {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_school/SchoolFinishPage',
                    params: {
                      ifSuccess: 1,
                      id: exercise.id,
                      title: exercise.title
                    }
                  }
                )

              })
            }


          }
        )

        ListItem().height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getSchoolExercise2()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getSchoolExercise()
        }
      })

    }
    .align(Alignment.Top)
    .height('100%')

  }

  //获取学校作业
  async getSchoolExercise(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    ExerciseService.getSchoolExercise('finish', this.pageNum)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取学校作业成功')

        //拼接
        this.exercise = this.exercise.concat(exercise)
        this.isLoading = false
        if(!exercise || exercise.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        console.log('Tags', '获取学校作业失败')
      })
  }

  //获取学校作业
  async getSchoolExercise2(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    ExerciseService.getSchoolExercise('finish', this.pageNum)
      .then((exercise: ExerciseInfo[]) => {
        console.log('Tags', '获取学校作业成功')

        this.exercise = exercise

      })
      .catch((error: string) => {
        console.log('Tags', '获取学校作业失败')
      })
  }
}

