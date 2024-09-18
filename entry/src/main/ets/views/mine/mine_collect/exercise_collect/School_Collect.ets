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
export default struct School_Collect {
  @Link exercise: ExerciseInfo[]/* = [
    new ExerciseInfo(ExerciseType.schoolExercise,false ,'笔画练习（一）', '2024-3-3', 0, true),
    new ExerciseInfo(ExerciseType.schoolExercise,true ,'将进酒', '2024-3-2', 0, true)
  ]*/

  build() {
    Scroll(){
      Column(){
        //作业列表
        List({space: 10}){
          ListItem(){

          }
          .height(5)

          ForEach(
            this.exercise,
            (exercise: ExerciseInfo) => {

              if (exercise.type == ExerciseType.schoolExercise) {
                ListItem() {
                  ExerciseItem({ exercise: exercise })
                }
                .exercise_List()
                .onClick(() => {
                  if (exercise.type == ExerciseType.schoolExercise && exercise.finish) {
                    router.pushUrl(
                      {
                        url: 'pages/exercise/exercise_school/SchoolFinishPage'
                      }
                    )
                  }


                })
              }

            }
          )

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