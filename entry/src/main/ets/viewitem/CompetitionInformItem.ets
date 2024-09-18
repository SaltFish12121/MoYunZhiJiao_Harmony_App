import router from '@ohos.router'
import CompetitionInformInfo from '../viewmodel/CompetitionInformInfo'

@Component
export default struct CompetitionInformItem {
  competition: CompetitionInformInfo = new CompetitionInformInfo(0)

  build() {
    Row({space: 10}){
      Column(){
        Image(this.competition.cover)
          .width(170)
          .height(100)
          .borderRadius({ topLeft: 10, bottomLeft: 10 })
      }

      Column(){
        Text(this.competition.title)
          .fontSize(18)

        Text(this.competition.time)
          .fontSize(12)
          .fontColor($r('app.color.light_black'))
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceBetween)
      .height('60%')
    }
    .width('100%')
    .height(100)


  }
}