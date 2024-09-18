import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../../viewmodel/KnowledgeInfo'

import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
@Component
export default struct Calligraphy_Knowledge {
  @Link knowledgeShow: KnowledgeInfo[]

  build() {
    Column(){
      //1 上方提示语
      Row(){
        Text($r('app.string.homepage_calligraphyKnowledge'))
          .fontSize(CommonConstants.DEFAULT_20)

        Text('更多')
          .fontSize(CommonConstants.DEFAULT_20)
      }
      .width(CommonConstants.THOUSANDTH_900)
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mainpage/calligraphy_knowledge/CalligraphyKnowledgePage'
          }
        )
      })

      //2 轮播图

      Swiper() {
        //2.1 图片
        ForEach(
          this.knowledgeShow,
          (knowledgeShow: KnowledgeInfo) => {
            Image(knowledgeShow.cover)
              .onClick(() => {
                console.log('Result', 'knowledge', knowledgeShow.title, knowledgeShow.cover)

                router.pushUrl(
                  {
                    url: 'pages/mainpage/calligraphy_knowledge/KnowledgeDetialPage',
                    params: {
                      id: knowledgeShow.id,
                      content: knowledgeShow.content,
                      ifCollect: knowledgeShow.ifCollect,
                      title: knowledgeShow.title
                    }
                  }
                )
              })

          }
        )

      }
      .margin({top: 10})
      .width('90%')
      .height(220)
      .backgroundColor(Color.White)
      .borderRadius(CommonConstants.DEFAULT_18)

    }
  }

  aboutToAppear(): void {
    console.log('aboutToAppear', 'HomePage3')
  }
}