import router from '@ohos.router'
import { CommonConstants } from '../../../../common/constants/CommonConstants'
import ExcellentWorkItem from '../../../../viewitem/ExcellentWorkItem'
import ExcellentWorkInfo from '../../../../viewmodel/ExcellentWorkInfo'

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

enum WorkType{
  schoolWork = '学校作品',
  competitionWork = '竞赛作品'
}

@Component
export default struct Excellent_Collect {

  @Link excellentWork: ExcellentWorkInfo[]/* = [
    new ExcellentWorkInfo(WorkType.schoolWork, '','横折练习', '2024-3-3'),
    new ExcellentWorkInfo(WorkType.competitionWork, '','第一次书法竞赛', '2024-3-2')
  ]*/

  build() {
    Scroll(){
      Column(){
        //作业列表
        List({space: 10}){
          ListItem(){

          }
          .height(5)

          ForEach(
            this.excellentWork,
            (excellentWork: ExcellentWorkInfo) => {
            ListItem() {
              ExcellentWorkItem({ excellentWork: excellentWork })
            }
            .exercise_List()
            .onClick(() => {

              if ( excellentWork.type == WorkType.schoolWork ) {

                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentHomeworkPage'
                  }
                )

              } else {

                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentCompetitionWorksPage'
                  }
                )
              }


            })
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
          console.info('first' + firstIndex)
          console.info('last' + lastIndex)
        })
        .width('100%')
        .height('100%')

      }
    }
  }
}