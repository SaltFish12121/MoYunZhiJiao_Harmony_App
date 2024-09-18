import { HeaderTitle } from '../../common/components/CommonComponents'
import { CommonConstants } from '../../common/constants/CommonConstants'
import MessageItem from '../../viewitem/MessageItem'
import { MessageType } from '../../viewmodel/MessageInfo'
import MessageInfo from '../../viewmodel/MessageInfo'
import UserService from '../../service/UserService'
import PreferencesUtil from '../../common/utils/PreferencesUtil'

@Extend(ListItem) function message_List(){
  .width('100%')
  .backgroundColor(0xFFFFFF)

}

@Entry
@Component
struct SystemMessagePage {
  @State System_messages: MessageInfo[] = [
    new MessageInfo(0,MessageType.system,'信息设置','2024-5-24','您修改头像已经通过审核'),
    new MessageInfo(0,MessageType.system,'尊贵的VIP用户','2024-4-9','恭喜你成为VIP')
  ]
  @State title: string = '系统消息'
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })
        .backgroundColor($r('app.color.start_window_background'))

      // Divider().strokeWidth(1)

      //2消息列表
      List({space: 10}){
        ListItem().height(5)

        //当前页获取
        ForEach(
          this.System_messages,
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

  onPageShow(){
    //获取系统消息
    this.getMineMessage()
  }


  async getMineMessage(){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getMineMessage(userId, 0, this.pageNum)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        this.System_messages = message
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
        this.System_messages = this.System_messages.concat(message)
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