import KnowledgeInfo from '../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../viewmodel/KnowledgeInfo'
import Calligraphy_Compition from './calligraphy_compition/Calligraphy_Compition'
import Calligraphy_Knowledge from './calligraphy_knowledge/Calligraphy_Knowledge'
import Calligraphy_Teaching from './calligraphy_teaching/Calligraphy_Teaching'
import VideoInfo from '../../viewmodel/VideoListInfo'
import CompetitionInformInfo from '../../viewmodel/CompetitionInformInfo'

@Component
export default struct Tabs_HomePage {
  @Link knowledgeShow: KnowledgeInfo[]
  @Link videoShow: VideoInfo[]
  @Link CompetitionInformShow: CompetitionInformInfo[]

  build() {
    Scroll(){
      Column(){
        //1 书法知识
        Calligraphy_Knowledge({ knowledgeShow: $knowledgeShow })
          .margin({top:30})

        //2 书法教学视频
        Calligraphy_Teaching({ video: $videoShow })
          .margin({top:30})

        //3 竞赛通知
        Calligraphy_Compition({ CompetitionInformShow: $CompetitionInformShow })
          .margin({top:30})

      }

    }
    .scrollBar(BarState.Off)

  }

  aboutToAppear(): void {
    console.log('aboutToAppear', 'HomePage2')
  }
}