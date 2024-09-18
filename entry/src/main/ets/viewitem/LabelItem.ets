import LabelInfo from '../viewmodel/LabelInfo'

@Component
export default struct LabelItem {
  Label : LabelInfo = new LabelInfo('')

  build() {
    Column(){
      Text(this.Label.name)
        .fontSize(10)
    }
    .borderRadius(15)
    .padding({ left: 15, right: 15, top: 6, bottom: 6 })
    .backgroundColor($r('app.color.gray'))


  }
}