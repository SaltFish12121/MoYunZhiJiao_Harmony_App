import CompetitionInfo from '../viewmodel/CompetitonInfo'

@Component
export default struct CompetitionFinisheItem {
  competition: CompetitionInfo = new CompetitionInfo(0)

  build() {

    Row({space: 10}){
      Column({space: 20}){
        Text(this.competition.title)
          .fontSize(20)


        Text(this.competition.startTime)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .height('70%')

      Blank()

      Column(){
        Text('得分：'+this.competition.score)
          .fontColor($r('app.color.tips_red'))
          .fontSize(14)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
      .width(90)

    }
    .width('90%')
    .height(100)

  }
}