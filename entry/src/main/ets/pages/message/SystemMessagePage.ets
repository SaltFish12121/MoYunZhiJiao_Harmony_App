import { HeaderTitle } from '../../common/components/CommonComponents'
import MessageItem from '../../viewitem/MessageItem'
import MessageInfo from '../../viewmodel/MessageInfo'
import UserService from '../../service/UserService'
import No_Content from '../../views/No_Content'
import Cant_Connect from '../../views/Cant_Connect'

@Extend(ListItem) function message_List(){
  .width('100%')
  .backgroundColor(0xFFFFFF)
}

//系统消息
@Entry
@Component
struct SystemMessagePage {
  @State System_messages: MessageInfo[] = []
  @State title: string = '系统消息'
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据
  @State ifConnect: boolean = false

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })
        .backgroundColor($r('app.color.start_window_background'))


      if (this.ifConnect) {
        if (this.System_messages != null && this.System_messages.length == 0) {
          No_Content()
        } else {

          //2 消息列表
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
            this.isMore = true
            this.getMineMessage()
          })
          .onReachEnd(() => {
            console.log('触底了！')

            if(!this.isLoading && this.isMore){
              this.isLoading = true
              // 翻页
              this.pageNum++
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
    //获取系统消息
    this.getMineMessage()
  }


  async getMineMessage(){

    await UserService.getMineMessage(0, this.pageNum)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        this.System_messages = message
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取消息通知失败')
        this.ifConnect = false
      })
  }

  async getMineMessage2(){

    await UserService.getMineMessage(0, this.pageNum)
      .then((message: MessageInfo[]) => {
        console.log('Tags', '获取消息通知成功')

        //拼接
        this.System_messages = this.System_messages.concat(message)
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