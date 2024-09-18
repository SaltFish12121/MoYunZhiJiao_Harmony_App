import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'

@Extend(Row) function messageset_content(){
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
  .width('95%')
  .height(64)
}

@Entry
@Component
struct LanguageSetPage {

  @State title: string = '语言设置'

  build() {
    Column(){
      //1头部
      Stack({alignContent: Alignment.TopEnd}){

        HeaderTitle({ title: $title })
          .width('100%')

        Row(){
          Text('确定')
            .fontSize(18)
            .fontColor($r('app.color.text_gray'))
        }
        .height(59)
        .width(50)
        .onClick(() => {
          router.back()
        })

      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))

      //2语言选择
      Column(){
        Divider()

        Row(){
          Row(){
            Text('中文')
              .fontSize(20)

            Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
              .height(30)
              .width(30)
              .onChange((isChecked: boolean) => {
                console.log('Radio1 status is ' + isChecked)
              })

          }
          .messageset_content()
          .onClick(() => {

          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

        Row(){
          Row(){
            Text('英文')
              .fontSize(20)

            Radio({ value: 'Radio2', group: 'radioGroup' }).checked(false)
              .height(30)
              .width(30)
              .onChange((isChecked: boolean) => {
                console.log('Radio2 status is ' + isChecked)
              })
          }
          .messageset_content()
          .onClick(() => {

          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

      }
      .backgroundColor($r('app.color.start_window_background'))

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.light_gray'))

  }
}