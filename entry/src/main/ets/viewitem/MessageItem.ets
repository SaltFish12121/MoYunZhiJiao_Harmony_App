import MessageInfo from '../viewmodel/MessageInfo'
import { MessageType } from '../viewmodel/MessageInfo'

@Component
export default struct MessageItem {
  message: MessageInfo = new MessageInfo(0, MessageType.system, '', '', '')

  build() {
    Column(){
      Row(){
        Text(this.message.title)
          .fontSize(20)
      }
      .width('90%')
      .height(50)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)

      Column({ space: 10 }){
        Text(this.message.content)

        Text(this.message.time)
          .fontSize(12)
      }
      .width('90%')
      .constraintSize({minHeight: 50})
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .padding(10)
    }
    .width('100%')
    .constraintSize({minHeight: 100})
    // .padding(10)
  }
}