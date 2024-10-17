import router from '@ohos.router'
import { HeaderCollect } from '../../../common/components/CommonComponents'

//知识详情
@Entry
@Component
struct KnowledgeDetailPage {
  @State title: string = '知识详情标题'

  @State content: string = ''

  @State ifCollect: boolean = false
  @State collectId: number = 0

  build(){
    Column(){
      //1 头部
      HeaderCollect({ ifCollect: $ifCollect, collectId: $collectId, type: 'Knowledge' })

      Scroll(){
        Column(){


          //2 知识内容
          Column({space: 10}){

            Text(this.title)
              .fontSize(25)

            Column(){
              RichText(this.content)
                .onStart(() => {
                  console.info('RichText onStart');
                })
                .onComplete(() => {
                  console.info('RichText onComplete');
                })
            }

          }
          .alignItems(HorizontalAlign.Center)
          .width('95%')

          Column()
          .height(100)

        }
      }
      .scrollBar(BarState.Off)
    }
    .align(Alignment.Top)


  }

  onPageShow(){
    const knowledge = router.getParams() as PARAMS

    if (knowledge.id != undefined) {
      this.collectId = knowledge.id
      this.ifCollect = knowledge.ifCollect
      this.content = knowledge.content
      this.title = knowledge.title
      console.log('collectId', this.collectId)
    }
  }
}

// 声明接受参数的类型
interface PARAMS {
  id: number
  content: string
  ifCollect: boolean
  title: string
}