@Component
export default struct Cant_Connect {
  build() {
    Column(){
      Text('页面加载失败，请重试')
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.light_gray'))
  }
}