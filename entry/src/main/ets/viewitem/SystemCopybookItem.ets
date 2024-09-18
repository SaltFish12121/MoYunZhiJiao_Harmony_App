import router from '@ohos.router'
import SystemTemplateInfo from '../viewmodel/SystemTemplateInfo'
import { TemplateType } from '../viewmodel/SystemTemplateInfo'

@Component
export default struct SystemCopybookItem {
  exercise: SystemTemplateInfo = new SystemTemplateInfo(0, TemplateType.specialType, '', '')

  build() {
    Row({space: 10}){
      Column({space: 20}){
        Text(this.exercise.title)
          .fontSize(20)

        // Text(this.exercise.time)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .height('70%')

      Blank()

      Column(){
        Text('查看')
          .fontColor($r('app.color.tips_red'))
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('70%')
      .width(90)

    }
    .width('90%')
    .height(100)
    .onClick(() => {
      router.pushUrl(
        {
          url: 'pages/exercise/Copybook',
          params: {
            title: this.exercise.title,
            template: this.exercise
          }
        }
      )
    })


  }
}