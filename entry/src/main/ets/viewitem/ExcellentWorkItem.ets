import ExcellentWorkInfo from '../viewmodel/ExcellentWorkInfo'
import { WorkType } from '../viewmodel/ExcellentWorkInfo'

@Component
export default struct ExcellentWorkItem {
  excellentWork: ExcellentWorkInfo = new ExcellentWorkInfo(0, WorkType.schoolWork, '', '', '')

  build() {

    Row({space: 10}){
      Column({space: 20}){
        Text(this.excellentWork.title)
          .fontSize(20)

        Text(this.excellentWork.time)
      }
      .justifyContent(FlexAlign.Start)
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

  }

}