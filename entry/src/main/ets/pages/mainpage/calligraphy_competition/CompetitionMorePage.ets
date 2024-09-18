import router from '@ohos.router'
import { HeaderSearch, HeaderTitle } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import CompetitionInformItem from '../../../viewitem/CompetitionInformItem'
import CompetitionInformInfo from '../../../viewmodel/CompetitionInformInfo'

@Extend(Column) function exercise_List(){
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

@Entry
@Component
struct CompetitionMorePage {
  @State title: string = '本系统竞赛'
  @State search: string = ''

  @State competition: CompetitionInformInfo[] =[
    new CompetitionInformInfo(1, true, '', '', '')
  ]

  build(){
    Column(){
      //1 头部
      HeaderTitle({ title: $title })

      /*
      Row({space: 10}){
        Search()
          .height(40)
          .width(300)

        Text('搜索')
          .fontSize(18)
          .fontColor($r('app.color.blue'))

      }*/

      //2 竞赛列表
      Column({space: 10}){
        Column(){

        }
        .height(5)

        ForEach(
          this.competition,
          (competition: CompetitionInformInfo) => {
            //如果是第本系统，type==true
            if (competition.type==true){
              Column() {
                CompetitionInformItem({ competition: competition })

              }
              .height(100)
              .exercise_List()
              .onClick(() => {
                router.pushUrl(
                  {
                    url: 'pages/mainpage/calligraphy_competition/CompetitionThisPage',
                    params: competition
                  }
                )
              })


            }
          }
        )

        Column(){
          // Text('end')
        }
        .height(100)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')


    }
  }

  onPageShow(){
    let competition = router.getParams() as CompetitionInformInfo[];

    if (competition != undefined) {
      this.competition = competition
    }
  }
}


