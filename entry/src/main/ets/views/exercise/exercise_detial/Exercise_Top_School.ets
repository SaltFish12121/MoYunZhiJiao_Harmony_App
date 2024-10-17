import SchoolFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolFinishExerciseDetailInfo'

@Component
export default struct Exercise_Top_School {
  @State rating: number = 3.5

  @Link exercise: SchoolFinishExerciseDetailInfo

  build() {
    Column(){
      //2
      Column({space: 15}){
        //1信息
        Row(){

          Row(){
            Text('难度')

            Rating({ rating: this.exercise.difficulty, indicator: true })
              .stars(5)
              .stepSize(0.5)

          }
          .width('30%')


          Row({space: 5}){
            Text('字数')
              .fontSize(14)

            Text(`${this.exercise.wordNumber}`)
              .fontSize(14)
          }
          .width('15%')

          Row(){
            Text(this.exercise.typeface)
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width('35%')


          Row(){
            Text(this.exercise.type)
              .fontSize(14)
          }
          .margin({right: -10})
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width('25%')

        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        //2要求
        Column({space: 10}){
          Text('要求')
            .width('100%')
            .textAlign(TextAlign.Start)

          Column(){
            Text(`${this.exercise.require}`)
              .fontSize(12)
              .width('95%')
              .margin({top: 15, bottom: 15})
          }
          .width('90%')
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

        }
        .width('90%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        //3样例
        Column({space: 10}){
          Text('样例')
            .width('100%')


          Scroll(){
            Row(){
              ForEach(this.exercise.example,
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
        .width('90%')
        .margin({bottom: 10})
      }


    }

  }

  aboutToAppear(): void {
    console.log('appear')

    console.log('example', this.exercise.example)
  }
}