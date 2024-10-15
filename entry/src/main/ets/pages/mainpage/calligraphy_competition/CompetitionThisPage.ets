import router from '@ohos.router';
import { Header, HeaderTitle } from '../../../common/components/CommonComponents'
import CompetitionInformInfo from '../../../viewmodel/CompetitionInformInfo'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

//本系统竞赛
@Entry
@Component
struct CompetitionThisPage {
  @State competition: CompetitionInformInfo = new CompetitionInformInfo(0,true, '这是一个竞赛', '', $r('app.media.show_knoledge'))

  // @State content: string = '<meta name="viewport" content="width=device-width">'+'\'<p>这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字</p>'
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

            Column(){
              RichText(this.competition.content)//this.competition.content//this.content
                .onStart(() => {
                  console.info('RichText onStart');
                })
                .onComplete(() => {
                  console.info('RichText onComplete');
                })
            }
          }
          .margin({ top: 50, bottom: 60})
          .width('90%')
          .alignItems(HorizontalAlign.Center)
          // .constraintSize({ minHeight: 110})

          //3 报名
          Button('点击报名')
            .onClick(async(event: ClickEvent) => {
              let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

              if (userId != 0 && userId != null) {
                router.pushUrl(
                  {
                    url: 'pages/mainpage/calligraphy_competition/ConfirmInformationPage',
                    params: {
                      id: this.competition.id,
                      title: this.competition.title
                    }
                  }
                )
              } else {// 跳转登录
                router.pushUrl({
                  url: 'pages/login/LoginPage'
                })
              }

            })

          Column()
          .height(100)
        }
      }
    }
    .height('100%')

  }


  onPageShow(){
    let params = router.getParams() as CompetitionInformInfo;

    if (params != undefined) {
      this.competition = params
      // this.content = this.competition.content
      console.log('Competition', 'get', this.competition.title)
    }
  }
}