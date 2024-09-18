import ExerciseInfo from '../viewmodel/ExerciseInfo'
import { ExerciseType } from '../viewmodel/ExerciseInfo'

@Component
export default struct ExerciseItem {
  exercise: ExerciseInfo = new ExerciseInfo(0, ExerciseType.schoolExercise, false, '', '')
  // @State color: any = $r('app.color.button1')

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

        Column(){
          if (this.exercise.type == ExerciseType.selfExercise){
            Text(this.exercise.type)
              .fontColor($r('app.color.tips'))
              .padding(5)

          } else {
            Text(this.exercise.type)
              .fontColor($r('app.color.tips_red'))
              .padding(5)

          }
        }
        // .backgroundColor(Color.Pink)
        // .border({ width: 1, color: $r('app.color.tips_red'), radius: 10, style: BorderStyle.Solid })



      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('60%')
      .width(80)


      if (this.exercise.type == ExerciseType.selfExercise){
        Column(){
          if (this.exercise.finish) {
            Text(this.exercise.score+'分')
              .fontColor($r('app.color.tips_red'))
          } else {
            Text('未作')
              .fontColor($r('app.color.tips_red'))
          }


        }

      } else {
        Column(){

          Column(){
            if (this.exercise.cutoff){
              Text('已截止')
                .fontColor($r('app.color.text_red'))

            } else {
              Text('未截止')
                .fontColor($r('app.color.tips'))

            }
          }
          // .backgroundColor(this.color)
          // .border({ width: 1, color: $r('app.color.tips'), radius: 10, style: BorderStyle.Solid })



        }

      }


    }
    .width('90%')
    .height(100)

  }

}