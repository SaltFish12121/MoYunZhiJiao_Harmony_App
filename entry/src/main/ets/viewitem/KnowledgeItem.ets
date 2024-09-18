import router from '@ohos.router'
import KnowledgeInfo from '../viewmodel/KnowledgeInfo'

@Component
export default struct KnowledgeItem {
  knowledge: KnowledgeInfo = new KnowledgeInfo(0)

  build() {
    Row({space: 10}){
      Column({space: 20}){
        Text(this.knowledge.title)
          .fontSize(19)

        Row({space: 10}){
          if (this.knowledge.viewNumber != null) {
            Text(this.knowledge.viewNumber+'阅读')
              .fontSize(12)
          }

          Text(this.knowledge.time)
            .fontSize(12)
        }

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .height('70%')

      Blank()

      Column(){
        Image(this.knowledge.cover)
          .width(70)
          .height(70)

      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('60%')
      .width(90)


    }
    .width('95%')
    .height(100)
    .onClick(() => {
      router.pushUrl(
        {
          url: 'pages/mainpage/calligraphy_knowledge/KnowledgeDetialPage',
          params: {
            id: this.knowledge.id,
            content: this.knowledge.content,
            ifCollect: this.knowledge.ifCollect,
            title: this.knowledge.title
          }
        }
      )

    })

  }
}