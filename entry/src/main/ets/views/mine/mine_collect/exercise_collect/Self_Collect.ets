import router from '@ohos.router'
import { CommonConstants } from '../../../../common/constants/CommonConstants'
import ExerciseItem from '../../../../viewitem/ExerciseItem'
import ExerciseInfo from '../../../../viewmodel/ExerciseInfo'
import { ExerciseType } from '../../../../viewmodel/ExerciseInfo'

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
export default struct Self_Collect {
  @Link exercise: ExerciseInfo[]/* = [
    new ExerciseInfo(ExerciseType.selfExercise,false ,'基础笔画练习(2)', '2024-3-3', 90, true),
    new ExerciseInfo(ExerciseType.selfExercise,false ,'基础笔画练习(1)', '2024-3-2', 91, true)
  ]*/

  build() {
    Scroll(){
      Column(){
        //作业列表
        List({space: 10}){
          ListItem(){

          }
          .height(5)

          ForEach(this.exercise, (exercise: ExerciseInfo) => {

            if (exercise.type == ExerciseType.selfExercise ) {
              ListItem() {
                ExerciseItem({ exercise: exercise })
              }
              .exercise_List()
              .onClick(() => {
                if (exercise.type == ExerciseType.selfExercise && exercise.finish) {
                  router.pushUrl(
                    {
                      url: 'pages/exercise/exercise_self/SelfFinishPage'
                    }
                  )
                }


              })
            }


          })

          ListItem(){

          }
          .height(100)
        }
        .alignListItem(ListItemAlign.Center)
        .listDirection(Axis.Vertical) // 排列方向
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
        .onScrollIndex((firstIndex: number, lastIndex: number) => {
          console.info('first' + firstIndex)
          console.info('last' + lastIndex)
        })
        .width('100%')
        .height('100%')

      }
    }
  }
}