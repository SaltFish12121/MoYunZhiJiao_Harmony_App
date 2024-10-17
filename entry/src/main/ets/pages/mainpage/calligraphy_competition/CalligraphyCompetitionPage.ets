import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import CompetitionInformItem from '../../../viewitem/CompetitionInformItem'
import CompetitionInformInfo from  '../../../viewmodel/CompetitionInformInfo'
import InformationService from  '../../../service/InformationService'

@Extend(Column) function exercise_List(){
  .width('95%')
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

//书法竞赛
@Entry
@Component
struct CalligraphyCompetitionPage {
  @State title: string = '竞赛通知'

  @State competition: CompetitionInformInfo[] = []

  build() {
    Column({space: 5}){
      //1 头部
      HeaderTitle({ title: $title })

      Scroll(){
        Column(){
          //2 本系统竞赛
          Column(){
            Row(){
              Text('本系统竞赛')
                .fontSize(24)

              Text('更多')
                .fontSize(24)
            }
            .width('95%')
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
            .onClick(() => {
              router.pushUrl(
                {
                  url: 'pages/mainpage/calligraphy_competition/CompetitionMorePage',
                  params: this.competition
                }
              )
            })

            Swiper() {
              //2.1 图片
              ForEach(
                this.competition,
                (competition: CompetitionInformInfo) =>{
                  if (competition.type==true) {
                    Image(competition.cover)
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

            }
            .margin({top: 10})
            .width('90%')
            .height(232)
            .backgroundColor(Color.White)
            .borderRadius(CommonConstants.DEFAULT_18)
          }


          //3 第三方竞赛
          Column(){
            Column(){
              Text('第三方竞赛')
                .fontSize(24)
            }
            .width('95%')
            .alignItems(HorizontalAlign.Start)

            Column(){
              //竞赛信息类别
              Column({space: 10}){
                Column(){

                }
                .height(5)

                ForEach(
                  this.competition,
                  (competition: CompetitionInformInfo) => {
                    //如果是第三方，type==false
                    if (competition.type==false){
                      Column() {
                        CompetitionInformItem({ competition: competition })
                      }
                      .height(100)
                      .exercise_List()
                      .onClick(() => {

                        router.pushUrl(
                          {
                            url: 'pages/mainpage/calligraphy_competition/CompetitionOtherPage',
                            params: competition
                          }
                        )
                      })

                    }


                  }
                )

                Column()
                .height(100)
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')

            }
            .width('100%')

          }
          .width('100%')
          .margin({top: 20})


        }

      }


    }
  }

  async onPageShow(){
    //获取竞赛通知
    await this.getCompetition()
  }

  //获取竞赛通知
  async getCompetition(){
    await InformationService.getCompetition()
      .then((competition: CompetitionInformInfo[]) => {
        console.log('Tags', '获取竞赛通知成功')

        this.competition = competition

        console.log('test', this.competition[0].title)
      })
      .catch(() => {

      })
  }

}


