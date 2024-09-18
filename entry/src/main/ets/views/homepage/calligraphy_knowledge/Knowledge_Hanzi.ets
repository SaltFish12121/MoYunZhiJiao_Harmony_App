import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import KnowledgeItem from '../../../viewitem/KnowledgeItem'
import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../../viewmodel/KnowledgeInfo'
import InformationService from  '../../../service/InformationService'

@Extend(ListItem) function exercise_List(){
  .width('95%')
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

@Component
export default struct Knowledge_Hanzi {
  @Link knowledge: KnowledgeInfo[]
  @Link search: string
  @Link pageNum: number
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){
      List({space: 10}){
        ListItem().height(5)

        ForEach(
          this.knowledge ,
          (knowledge: KnowledgeInfo) => {
            if (knowledge.type == KnowledgeType.Hanzi){
              ListItem() {
                KnowledgeItem({ knowledge: knowledge })
              }
              .exercise_List()
            }


          }
        )

        ListItem().height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getKnowledge()
        }
      })

    }
    .align(Alignment.Top)
    .height('100%')

  }

  //获取书法知识
  async getKnowledge(){
    await InformationService.getKnowledge(this.search, '汉字', this.pageNum++)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        //拼接
        this.knowledge = this.knowledge.concat(knowledge)
        this.isLoading = false
        if(!knowledge || knowledge.length === 0){
          this.isMore = false
        }

        console.log('test', this.knowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
      })
  }
}