import router from '@ohos.router'
import { CommonConstants } from '../../../../common/constants/CommonConstants'
import ExpertCopywritingItem from '../../../../viewitem/ExpertCopywritingItem'
import CopybookInfo from  '../../../../viewmodel/CopybookInfo'
import { TypefaceType } from  '../../../../viewmodel/SystemTemplateInfo'
import ExerciseService from '../../../../service/ExerciseService'

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

//废弃
@Component
export default struct ExpertCopywriting {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
  @State exercise: CopybookInfo[] = []
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Scroll(){
      //专家字帖列表
      List({space: 10}){
        ListItem(){

        }
        .height(5)

        ForEach(this.exercise, (exercise: CopybookInfo) => {
          ListItem() {
            ExpertCopywritingItem({ exercise: exercise})
          }
          .exercise_List()


        })

        ListItem(){

        }
        .height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
      })
      .width('100%')
      .height('100%')
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getExpertCopybook()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          this.getExpertCopybook2()
        }
      })

    }

  }

  async onPageShow(){
  }

  //获取专家字帖
  async getExpertCopybook(){
    // await ExerciseService.getExpertCopybook(this.pageNum)
    //   .then((expertCopybook: CopybookInfo[]) => {
    //     console.log('Tags', '获取专家字帖成功')
    //
    //     // this.exercise = expertCopybook
    //   })
    //   .catch(() => {
    //     console.log('Tags', '获取专家字帖失败')
    //   })
  }

  //获取专家字帖
  getExpertCopybook2(){
    // ExerciseService.getExpertCopybook(this.pageNum)
    //   .then((expertCopybook: CopybookInfo[]) => {
    //     console.log('Tags', '获取专家字帖成功')
    //
    //     // //拼接
    //     // this.exercise = this.exercise.concat(expertCopybook)
    //     // this.isLoading = false
    //     // if(!expertCopybook || expertCopybook.length === 0){
    //     //   this.isMore = false
    //     // }
    //   })
    //   .catch(() => {
    //     console.log('Tags', '获取专家字帖失败')
    //   })
  }
}