import { HeaderTitle } from '../../../../common/components/CommonComponents'
@Entry
@Component
struct ArchivalInformationPage {

  @State title: string = '备案信息'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      //2备案信息
      Column(){
        Text('备案信息')
      }

    }
    .width('100%')
    .height('100%')

  }
}