import LabelInfo from '../viewmodel/LabelInfo'

@Component
export default struct LabelItem {
  Label : LabelInfo = new LabelInfo('123')

  build() {
    Column(){
      Text(this.Label.name)
        .fontSize(15)
    }
    .borderRadius(15)
    .padding({ left: 15, right: 15, top: 6, bottom: 6 })
    .backgroundColor($r('app.color.gray'))
    .onClick(() => {
      console.log('label', this.Label.name)
    })


  }
}