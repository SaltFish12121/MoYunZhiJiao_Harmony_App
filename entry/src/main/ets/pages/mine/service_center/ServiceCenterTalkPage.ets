import { HeaderTitle } from '../../../common/components/CommonComponents'
@Entry
@Component
struct ServiceCenterTalkPage {

  @State title: string = ''

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })


    }
  }
}