import router from '@ohos.router';
import { HeaderTitle } from '../../../common/components/CommonComponents'
import CompetitionInformInfo from '../../../viewmodel/CompetitionInformInfo'

//第三方竞赛
@Entry
@Component
struct CompetitionOtherPage {
  @State competition: CompetitionInformInfo = new CompetitionInformInfo(0)

  @State title: string = '竞赛详情'

  build(){
    Column(){
      //1 head
      HeaderTitle({ title: $title })

      Scroll(){
        Column(){

          //2 内容
          Image(this.competition.cover)
            .width('100%')

          Column({space: 20}){
            Text(this.competition.title)
              .fontSize(30)

            RichText(this.competition.content)
          }
          .margin({ top: 50, bottom: 60})
          .width('90%')
          .constraintSize({ minHeight: 1000})


          Column().height(100)
        }
      }


    }
    .height('100%')

  }

  onPageShow(){
    let params = router.getParams() as CompetitionInformInfo;

    if (params != undefined) {
      console.log('Competition', 'get')
      this.competition = params
    }
  }
}