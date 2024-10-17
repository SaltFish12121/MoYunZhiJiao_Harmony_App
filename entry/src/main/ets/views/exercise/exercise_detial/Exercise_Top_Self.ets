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

          Text(this.selfExercise.typeface)

        }
        .width('95%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)


        Column(){
          Scroll(){
            Row(){
              ForEach(this.selfExercise.example,
                (example: string) => {
                  Image(example)
                    .width('90%')
                }
              )

            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('90%')
        }
        .constraintSize({ minHeight: 300})
        .margin({top: 10, bottom: 10})

      }
      .width('90%')

    }
  }
}