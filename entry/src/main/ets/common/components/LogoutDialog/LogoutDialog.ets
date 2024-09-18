/*
                  AlertDialog.show({
                    message: '更改姓名失败',
                    confirm: {
                      value: '确定',
                      action: ()=>{
                      }
                    }
                  })
 */

@CustomDialog
export default struct LogoutDialog {
  controller: CustomDialogController

  confirm: () => void = () => {

  }

  build() {
    Column(){
      Column(){
        Column({space: 15}){
          Text('退出登录')
            .fontSize(18)

          Text('退出此设备登录的账号')
            .fontSize(14)
        }
        .padding(20)

        Divider()

        Column(){
          Text('确认退出')
        }
        .padding(15)
        .onClick(() => {
          this.confirm()
          this.controller.close()
        })

        Divider()

        Column(){
          Text('取消')
        }
        .padding(15)
        .onClick(() => {
          this.controller.close()
        })
      }
      .width('100%')

    }
    .width('100%')
    .height(200)
    // .backgroundColor($r('app.color.mid_gray'))
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    // .align(Alignment.Top)
  }
}