import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import ExcellentWorkItem from '../../../viewitem/ExcellentWorkItem'
import ExcellentWorkInfo from '../../../viewmodel/ExcellentWorkInfo'
import { WorkType } from '../../../viewmodel/ExcellentWorkInfo'
import ExerciseService from  '../../../service/ExerciseService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

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
export default struct Excellent_Works {
  @Link excellentWork: ExcellentWorkInfo[]
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){
      List({space: 10}){
        ListItem().height(5)

        ForEach(
          this.excellentWork ,
          (excellentWork : ExcellentWorkInfo) => {
            ListItem() {
              ExcellentWorkItem({ excellentWork: excellentWork })
            }
            .exercise_List()
            .onClick(() => {

              if ( excellentWork.type == WorkType.schoolWork ) {

                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentHomeworkPage',
                    params: {
                      ifSuccess: 1,
                      id: excellentWork.id,
                      title: excellentWork.title
                    }
                  }
                )

              } else {

                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentCompetitionWorksPage',
                    params: {
                      ifSuccess: 1,
                      id: excellentWork.id,
                      title: excellentWork.title
                    }
                  }
                )
              }

            })
          }
        )

        ListItem().height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getExcellentExercise2()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getExcellentExercise()
        }
      })

    }
    .align(Alignment.Top)
    .height('100%')

  }


  //获取优秀作品
  async getExcellentExercise(){
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await ExerciseService.getExcellentExercise(this.pageNum)
      .then((exercise: ExcellentWorkInfo[]) => {
        console.log('Tags', '获取优秀作品成功')

        //拼接
        this.excellentWork = this.excellentWork.concat(exercise)
        this.isLoading = false
        if(!exercise || exercise.length === 0){
          this.isMore = false
        }

      })
      .catch((error: string) => {
        console.log('Tags', '获取优秀作品失败')
      })
  }

  //获取优秀作品
  async getExcellentExercise2(){
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await ExerciseService.getExcellentExercise(this.pageNum)
      .then((exercise: ExcellentWorkInfo[]) => {
        console.log('Tags', '获取优秀作品成功')

        this.excellentWork = exercise

      })
      .catch((error: string) => {
        console.log('Tags', '获取优秀作品失败')
      })
  }
}