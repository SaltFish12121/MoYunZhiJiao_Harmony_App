import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import MessageInfo from '../../viewmodel/MessageInfo'

@Extend(Column) function content_formant(){
  .padding({top: 30, bottom: 35})
  .borderRadius(CommonConstants.DEFAULT_10)
  .width(CommonConstants.THOUSANDTH_940)
  .backgroundColor(Color.White)
  .height(86)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

@Component
export default struct Tabs_Message {

  //传入的数据
  @State message: MessageInfo[] = []

  build() {
    Column(){

      //1 顶部标题
      Column(){
        Text('消息中心')
          .fontSize(CommonConstants.DEFAULT_24)
      }
      .justifyContent(FlexAlign.Center)
      .height(60)

      Divider()
        .height(22)

      //2 内容
      Column({space: CommonConstants.SPACE_12}){
        //1 系统消息
        Column(){
          Text($r('app.string.message_system'))
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/message/SystemMessagePage'
            }
          )
        })

        //2 作业发布
        Column(){
          Text($r('app.string.message_jobPosting'))
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/message/JobPostingMessagePage'
            }
          )
        })

        //3 作业提醒
        Column(){
          Text($r('app.string.message_jobReminder'))
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/message/JobRemindMessagePage'
            }
          )
        })

        //4 竞赛通知
        Column(){
          Text($r('app.string.message_competitionNotice'))
        }
        .content_formant()
        .onClick(() => {
          router.pushUrl(
            {
              url: 'pages/message/NoticeMessagePage'
            }
          )
        })
      }


    }
    .width('100%')
    .height('100%')
  }


}