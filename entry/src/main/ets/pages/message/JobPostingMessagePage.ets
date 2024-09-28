import router from '@ohos.router'
import { HeaderTitle } from '../../common/components/CommonComponents'
import { CommonConstants } from '../../common/constants/CommonConstants'
import MessageInfo from '../../viewmodel/MessageInfo'
import { MessageType } from '../../viewmodel/MessageInfo'
import MessageItem from '../../viewitem/MessageItem'
import UserService from '../../service/UserService'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import Cant_Connect from '../../views/Cant_Connect'
import No_Content from '../../views/No_Content'

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
    /*
    new MessageInfo(0,MessageType.homeworkPost,'作业“基础练习”已发布','2024-5-24','截止日期6-15'),
    new MessageInfo(0,MessageType.system,'作业“基础练习”已发布','2024-4-9','截止日期6-15')
    */
  ]
  @State title: string = '作业发布'
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据
  @State ifConnect: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })
        .backgroundColor($r('app.color.start_window_background'))

      // Divider().strokeWidth(2)

      if (this.ifConnect) {
        if (this.JobPost_messages != null && this.JobPost_messages.length == 0) {
          No_Content()
        } else {

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
      } else {
        Cant_Connect()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.light_gray'))

  }

  onPageShow(){
    //获取作业发布消息
    this.getMineMessage()
  }

  async getMineMessage(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getMineMessage(1, 1)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        this.JobPost_messages = message
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取消息通知失败')
        this.ifConnect = true
      })
  }

  async getMineMessage2(){
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getMineMessage(1, this.pageNum)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        //拼接
        this.JobPost_messages = this.JobPost_messages.concat(message)
        this.isLoading = false
        if(!message || message.length === 0){
          this.isMore = false
        }
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取消息通知失败')
        this.ifConnect = false
      })
  }

}