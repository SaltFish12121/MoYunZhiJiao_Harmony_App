import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import CompetitionItem from '../../viewitem/CompetitionUnfinishItem'
import CompetitionInfo from '../../viewmodel/CompetitonInfo'
import { CompetitionType,IfSignUpType } from '../../viewmodel/CompetitonInfo'
import CompetitionService from '../../service/CompetitionService'
import CompetitionInformInfo from  '../../viewmodel/CompetitionInformInfo'
import InformationService from  '../../service/InformationService'

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
export default struct Compition_Unfinished{
  @Link competition: CompetitionInfo[]
  @State competitionInformation: CompetitionInformInfo = new CompetitionInformInfo(0)

  build() {
    Column(){
      List({space: 10}){
        ListItem().height(5)

        ForEach(
          this.competition,
          (competition: CompetitionInfo) => {

            if (competition.type != '结束'){
              ListItem() {
                CompetitionItem({competition: competition})
              }
              .exercise_List()
              .onClick(async() => {
                console.log('exerciseId', competition.id)

                if (competition.type == CompetitionType.unSubmit && competition.ifSignUp == IfSignUpType.SignUp ) {
                  router.pushUrl(
                    {
                      url: 'pages/competition/CompetitionUnfinishedPage',
                      params:{
                        competitionId: competition.id
                      }
                    }
                  )
                } else if(competition.type == CompetitionType.unCutOff && competition.ifSignUp == IfSignUpType.unSignUp) {
                  console.log('getCompetitionSingle', competition.id)
                  await this.getCompetitionSingle(competition.id)

                  router.pushUrl(
                    {
                      url: 'pages/mainpage/calligraphy_competition/CompetitionThisPage',
                      params: this.competitionInformation
                      //有问题！！！
                    }
                  )
                } else {
                  AlertDialog.show({
                    message: '当前竞赛无法查看',
                    confirm: {
                      value: '确定',
                      action: ()=>{
                      }
                    }
                  })
                }

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


  aboutToAppear(){
    if (this.competition != null) {
      console.log("competition", this.competition[0].ifSignUp, this.competition[0].type)
    }
  }


  //获取竞赛通知
  async getCompetitionSingle(competitionId: number){
    await InformationService.getCompetitionSingle(competitionId)
      .then((competition: CompetitionInformInfo) => {
        console.log('Tags', '获取竞赛通知成功')

        this.competitionInformation = competition

        console.log('test', this.competitionInformation.title)
      })
      .catch(() => {

      })
  }
}