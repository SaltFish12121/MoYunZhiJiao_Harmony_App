import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import UserService from '../../service/UserService'
import MessageInfo from '../../viewmodel/MessageInfo'
import { MessageType } from '../../viewmodel/MessageInfo'

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
  @State message: MessageInfo[] = [/*
    new MessageInfo(MessageType.system,'信息设置','2024-5-24','您修改头像已经通过审核'),
    new MessageInfo(MessageType.system,'尊贵的VIP用户','2024-4-9','恭喜你成为VIP'),
    new MessageInfo(MessageType.system,'作业“基础练习”已发布','2024-5-24','截止日期6-15'),
    new MessageInfo(MessageType.system,'作业“基础练习”已发布','2024-4-9','截止日期6-15'),
    new MessageInfo(MessageType.system,'作业“基础练习”已即将截止','2024-5-24','还剩4小时'),
    new MessageInfo(MessageType.system,'作业“基础练习”已即将截止','2024-4-9','还剩4小时'),
    new MessageInfo(MessageType.system,'您报名的“全国大赛”已成功','2024-5-24','开赛时间2024-5-5')
    */
  ]

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


  /*
  getMineMessage(){
    let userId = 1

    UserService.getMineMessage(userId, 0)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        this.message = message
      })
      .catch((error) => {
        console.log('Tags', '获取消息通知失败')

      })
  }
  */

}