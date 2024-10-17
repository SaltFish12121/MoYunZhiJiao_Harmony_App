import ExerciseAnalysisInfo from '../viewmodel/analysis/ExerciseAnalysisInfo'

//练习分析列
@Component
export default struct ExerciseAnalysisItem {
  exerciseAnalysis: ExerciseAnalysisInfo = new ExerciseAnalysisInfo(0, false, '', '', 0)

  build() {
    Row(){
      Column({space: 10}){
        Text(this.exerciseAnalysis.name)

        Text(this.exerciseAnalysis.time)
          .fontSize(12)
      }
      .alignItems(HorizontalAlign.Start)


      Text(''+this.exerciseAnalysis.score+'分')
        .fontColor($r('app.color.tips_red'))
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('90%')
    .height(75)

  }
}