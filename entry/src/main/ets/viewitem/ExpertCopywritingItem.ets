import router from '@ohos.router'
import CopybookInfo from '../viewmodel/CopybookInfo'

@Component
export default struct ExpertCopywritingItem {
  exercise: CopybookInfo = new CopybookInfo(0, '', '', '')

  build() {
    Row({space: 10}){
      Column({space: 20}){
        Text(`《${this.exercise.title}》`)
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
          url: 'pages/exercise/exercise_self/ExpertCopywritingPage',
          params: {
            data: this.exercise
          }
        }
      )
    })


  }
}