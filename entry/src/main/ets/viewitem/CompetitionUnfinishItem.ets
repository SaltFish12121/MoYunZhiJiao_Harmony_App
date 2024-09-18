import CompetitionInfo from '../viewmodel/CompetitonInfo'
import { CompetitionType,IfSignUpType } from '../viewmodel/CompetitonInfo'

@Component
export default struct CompetitionItem {
  competition: CompetitionInfo = new CompetitionInfo(0)
  type: string = ''
  color: ResourceColor = ''

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
        if (this.competition.ifSignUp == IfSignUpType.unSignUp){
          Text(this.competition.ifSignUp)
            .fontColor($r('app.color.tips_red'))
            .fontSize(14)
        } else {
          Text(this.competition.ifSignUp)
            .fontColor(Color.Green)
            .fontSize(14)
        }

      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
      .width(60)

      Column(){
        if (this.competition.type == CompetitionType.unSubmit || this.competition.type == CompetitionType.unCutOff) {
          Text(this.competition.type)
            .fontColor($r('app.color.tips'))
        } else if (this.competition.type == CompetitionType.submit ){
          Text(this.competition.type)
            .fontColor($r('app.color.tips_red'))
        } else {
          Text(this.competition.type)
            .fontColor($r('app.color.tips_red'))
        }

      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
      .width(60)

    }
    .width('90%')
    .height(100)

  }
}