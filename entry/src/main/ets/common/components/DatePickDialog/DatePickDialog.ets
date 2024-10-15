import { CommonConstants } from '../../constants/CommonConstants'
@CustomDialog
export struct DatePickDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date
  build() {
    Column({space: CommonConstants.SPACE_12}){
      //1.日期选择
      DatePicker({
        start: new Date('2010-01-01'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onDateChange((value: Date) => {
          console.log('DatePick', value, value.getFullYear(), value.getMonth()+1, value.getDate())
          this.selectedDate.setFullYear(value.getFullYear(), value.getMonth(), value.getDate())
        })
      //2.按钮
      Row({space: CommonConstants.SPACE_12}){
        Button('取消')
          .width(120)
          .fontColor($r('app.color.light_black'))
          .backgroundColor($r('app.color.light_gray'))
          .onClick(() => this.controller.close())
        Button('确定')
          .width(120)
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {
            //1.保存日期到全局储存
            AppStorage.setOrCreate('selectedDate', this.selectedDate.getTime())//十分关键
            //2.关闭窗口
            this.controller.close()
          })
      }
    }
    .padding(CommonConstants.SPACE_12)
  }
}