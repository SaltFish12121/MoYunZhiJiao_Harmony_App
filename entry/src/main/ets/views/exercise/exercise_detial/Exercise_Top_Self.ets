import SelfFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SelfFinishExerciseDetailInfo'

@Component
export default struct Exercise_Top_Self {
  @Link selfExercise: SelfFinishExerciseDetailInfo

  build() {
    Column(){

      //1样例
      Column(){

        Row(){
          Text('样例')

          Text(/*'楷体'*/this.selfExercise.typeface)

        }
        .width('95%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)


        Image(/*$r('app.media.exercise_test1')*/this.selfExercise.example)
          .width('90%')
          .margin({top: 10, bottom: 10})

      }
      .width('90%')

    }
  }
}