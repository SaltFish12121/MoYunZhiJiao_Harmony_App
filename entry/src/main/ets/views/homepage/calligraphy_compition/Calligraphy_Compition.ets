import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import CompetitionInformInfo from '../../../viewmodel/CompetitionInformInfo'

@Component
export default struct Calligraphy_Compition {
  @Link CompetitionInformShow: CompetitionInformInfo[]

  build() {
    Column(){
      //1 上方提示语
      Row(){
        Text($r('app.string.homework_competitionNotice'))
          .fontSize(CommonConstants.DEFAULT_20)

        Text('更多')
          .fontSize(CommonConstants.DEFAULT_20)
      }
      .width(CommonConstants.THOUSANDTH_900)
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mainpage/calligraphy_competition/CalligrahyCompetitionPage'
          }
        )
      })

      //2 竞赛消息展示（少量）
      Column(){
        ForEach(
          this.CompetitionInformShow,
          (CompetitionInformShow: CompetitionInformInfo) => {
            Row(){
              Text(CompetitionInformShow.title)

              Text(CompetitionInformShow.time)
            }
            .width('95%')
            .height(50)
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
          }
        )

      }
      .width('90%')
      .margin({top: 10})
      .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

      Column(){

      }
      .height(50)


    }
  }
}