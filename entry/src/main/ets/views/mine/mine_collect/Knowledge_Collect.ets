import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import KnowledgeItem from '../../../viewitem/KnowledgeItem'
import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../../viewmodel/KnowledgeInfo'
import UserService from '../../../service/UserService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

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
export default struct Knowledge_Collect {
  @Link knowledgeCollect: KnowledgeInfo[]
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {

    Column(){
      //作业列表
      List({space: 10}){
        ListItem(){

        }
        .height(5)

        ForEach(this.knowledgeCollect,
          (knowledge: KnowledgeInfo) => {

            ListItem() {

              KnowledgeItem({ knowledge: knowledge })

            }
            .exercise_List()
            .onClick(() => {
              router.pushUrl(
                {
                  url: 'pages/mainpage/calligraphy_knowledge/KnowledgeDetialPage',
                  params: {
                    id: knowledge.id,
                    content: knowledge.content,
                    ifCollect: knowledge.ifCollect,
                    title: knowledge.title
                  }
                }
              )
            })
          }
        )

        ListItem(){

        }
        .height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        // console.info('first' + firstIndex)
        // console.info('last' + lastIndex)
      })
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getKnowledgeCollect2()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getKnowledgeCollect()
        }
      })

    }
    .align(Alignment.Top)
    .height('100%')
    .width('100%')

  }


  //获取知识收藏
  async getKnowledgeCollect(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await UserService.getKnowledgeCollect(userId, this.pageNum)
      .then((collect: KnowledgeInfo[]) => {
        console.log('Tags', '获取知识收藏成功')

        //拼接
        this.knowledgeCollect = this.knowledgeCollect.concat(collect)
        this.isLoading = false
        if(!collect || collect.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        console.log('Tags', '获取知识收藏失败')
      })

    // this.change(this.knowledgeCollect)
  }

  //获取知识收藏
  async getKnowledgeCollect2(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await UserService.getKnowledgeCollect(userId, this.pageNum)
      .then((collect: KnowledgeInfo[]) => {
        console.log('Tags', '获取知识收藏成功')

        this.knowledgeCollect = collect

      })
      .catch((error: string) => {
        console.log('Tags', '获取知识收藏失败')
      })

    // this.change(this.knowledgeCollect)
  }

}