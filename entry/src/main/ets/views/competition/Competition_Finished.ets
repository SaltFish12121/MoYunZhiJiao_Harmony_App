import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import CompetitionItem from '../../viewitem/CompetitionFinisheItem'
import CompetitionInfo from '../../viewmodel/CompetitonInfo'
import { CompetitionType } from '../../viewmodel/CompetitonInfo'

@Extend(ListItem) function exercise_List(){
  // .margin({left: 10, bottom: 5})
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
export default struct Competition_Finished {
  @Link competition: CompetitionInfo[]

  build() {
    Column(){
      List({space: 10}){
        ListItem().height(5)

        ForEach(
          this.competition,
          (competition: CompetitionInfo) => {

            if (competition.type == CompetitionType.finish ){
              ListItem() {
                CompetitionItem({competition: competition})
              }
              .exercise_List()
              .onClick(() => {
                console.log('exerciseId', competition.id)

                router.pushUrl(
                  {
                    url: 'pages/competition/CompetitionFinishedPage',
                    params:{
                      exerciseId: competition.id
                    }
                  }
                )
              })
            }


          }
        )

        ListItem().height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .onReachEnd(() => {
        console.log('触底了！')

      })

    }
    .align(Alignment.Top)
    .height('100%')

  }
}
