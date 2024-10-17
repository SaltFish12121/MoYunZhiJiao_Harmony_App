import KnowledgeInfo from '../../viewmodel/KnowledgeInfo'
import Calligraphy_Competition from './calligraphy_competition/Calligraphy_Competition'
import Calligraphy_Knowledge from './calligraphy_knowledge/Calligraphy_Knowledge'
import Calligraphy_Teaching from './calligraphy_teaching/Calligraphy_Teaching'
import VideoInfo from '../../viewmodel/VideoListInfo'
import CompetitionInformInfo from '../../viewmodel/CompetitionInformInfo'
import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
export default struct Tabs_HomePage {
  @Link knowledgeShow: KnowledgeInfo[]
  @Link videoShow: VideoInfo[]
  @Link CompetitionInformShow: CompetitionInformInfo[]

  build() {
    Column(){
      //1产品名称
      Row(){
        Text($r('app.string.app_name'))
          .fontSize(CommonConstants.DEFAULT_24)
      }
      .justifyContent(FlexAlign.Center)
      .align(Alignment.Center)
      .backgroundColor($r('app.color.start_window_background'))
      .width('100%')
      .height(50)

      Scroll(){
        Column(){
          //1 书法知识
          Calligraphy_Knowledge({ knowledgeShow: $knowledgeShow })
            .margin({top:10})

          //2 书法教学视频
          Calligraphy_Teaching({ video: $videoShow })
            .margin({top:30})

          //3 竞赛通知
          Calligraphy_Competition({ CompetitionInformShow: $CompetitionInformShow })
            .margin({top:30})

        }

      }
      .scrollBar(BarState.Off)
    }

  }

  aboutToAppear(): void {
    console.log('aboutToAppear', 'HomePage2')
  }
}