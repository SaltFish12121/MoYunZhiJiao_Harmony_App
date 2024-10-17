import CollectInfo from '../../viewmodel/CollectInfo'
import { CollectType } from '../../viewmodel/CollectInfo'

//收藏练习列
@Component
export default struct ExerciseCollectItem {
  exercise: CollectInfo = new CollectInfo(0, CollectType.schoolExercise,'', '')

  build() {

    Row({space: 10}){
      Column({space: 20}){
        Text(this.exercise.title)
          .fontSize(20)

        Text(this.exercise.time)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .height('70%')

      Blank()

      Column(){

        if (this.exercise.type == CollectType.excellentSchoolExercise || this.exercise.type == CollectType.excellentCompetitionExercise){
          Text('优秀作品')
            .fontColor($r('app.color.tips_red'))
        } else {
          Text(this.exercise.type)
            .fontColor($r('app.color.tips_red'))
        }


      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('60%')
      .width(90)

      Column(){

        Text('详情')
          .fontColor($r('app.color.blue'))

      }
      .justifyContent(FlexAlign.Center)
      .height('60%')



    }
    .width('90%')
    .height(100)

  }

}