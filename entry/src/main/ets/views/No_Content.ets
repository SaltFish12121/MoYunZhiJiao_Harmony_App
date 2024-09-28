@Component
export default struct No_Content {
  build() {
    Column(){
      Text('暂未获取消息')
        .fontColor($r('app.color.blue'))
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}