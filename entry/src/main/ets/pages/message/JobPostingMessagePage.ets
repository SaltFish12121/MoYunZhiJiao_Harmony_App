import router from '@ohos.router'
import { HeaderTitle } from '../../common/components/CommonComponents'
import { CommonConstants } from '../../common/constants/CommonConstants'
import MessageInfo from '../../viewmodel/MessageInfo'
import { MessageType } from '../../viewmodel/MessageInfo'
import MessageItem from '../../viewitem/MessageItem'
import UserService from '../../service/UserService'
import PreferencesUtil from '../../common/utils/PreferencesUtil'

@Extend(ListItem) function message_List(){
  // .margin({left: 10, bottom: 5})
  .width('100%')
  .backgroundColor(0xFFFFFF)
  // .borderRadius(CommonConstants.DEFAULT_10)
  /*
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
  */
}


@Entry
@Component
struct JobPostingMessagePage {
  @State JobPost_messages: MessageInfo[] = [
    new MessageInfo(0,MessageType.homeworkPost,'作业“基础练习”已发布','2024-5-24','截止日期6-15'),
    new MessageInfo(0,MessageType.system,'作业“基础练习”已发布','2024-4-9','截止日期6-15')
  ]
  @State title: string = '作业发布'
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  onPageShow(){
    //获取作业发布消息
    this.getMineMessage()
  }

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })
        .backgroundColor($r('app.color.start_window_background'))

      // Divider().strokeWidth(2)

      //2消息列表
      List({space: 10}){
        ListItem().height(5)

        //当前页获取
        ForEach(
          this.JobPost_messages,
          (message: MessageInfo) => {

            ListItem(){
              MessageItem({ message: message})
            }
            .message_List()

          }
        )

        ListItem().height(100)
      }
      .alignListItem(ListItemAlign.Center)
      .backgroundColor($r('app.color.light_gray'))
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getMineMessage()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getMineMessage2()
        }
      })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.light_gray'))
  }

  async getMineMessage(){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getMineMessage(userId, 1, 1)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        this.JobPost_messages = message
      })
      .catch((error: string) => {
        console.log('Tags', '获取消息通知失败')

      })
  }

  async getMineMessage2(){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getMineMessage(userId, 0, this.pageNum)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        //拼接
        this.JobPost_messages = this.JobPost_messages.concat(message)
        this.isLoading = false
        if(!message || message.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        console.log('Tags', '获取消息通知失败')

      })
  }

}