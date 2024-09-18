import { CommonConstants } from '../../common/constants/CommonConstants'
@CustomDialog
export default struct CreateExerciseDialog{
  controller: CustomDialogController

  confirm: (e: string) => void = () => {

  }

  @State text: string = ''

  @State placeholder: string = '请输入名称'
  @State inputColor: ResourceColor = $r('app.color.light_black')

  build(){
    Column({space: CommonConstants.SPACE_10}){
      // 1.标题
      Text('请输入创建练习的名称')
        .fontSize(20)
        .fontWeight(CommonConstants.FONT_WEIGHT_700)
      // 2.内容
      TextInput({ text: this.text, placeholder: this.placeholder })
        .placeholderColor(this.inputColor)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor(Color.Blue)
        // .width(400)
        .height(40)
        .margin(20)
        .fontSize(14)
        .fontColor(Color.Black)
        .onChange((value: string) => {
          this.text = value
        })
      // 3.按钮
      Button('取消')
        .width(150)
        .backgroundColor($r('app.color.button2'))
        .fontColor($r('app.color.light_black'))
        .onClick(() => {
          this.controller.close()
        })
      Button('完成')
        .width(150)
        .backgroundColor($r('app.color.button1'))
        .fontColor($r('app.color.light_black'))
        .onClick(() => {
          if (this.text != '') {
            this.confirm(this.text)
            this.controller.close()
          } else {
            this.placeholder = '名称不能为空'
            this.inputColor = $r('app.color.tips_red')
          }

        })

    }
    .width('100%')
    .padding(10)
  }
}