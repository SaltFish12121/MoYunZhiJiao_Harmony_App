import { HeaderTitle } from '../../../../common/components/CommonComponents'

@Extend(Row) function messageset_content(){
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
  .width('95%')
  .height(64)
}

@Entry
@Component
struct ManageStorageSpacePage {
  @State message: string = 'Hello World'

  @State title: string = '储存空间设置'

  build() {
    Column(){
      //1头部
      Stack({alignContent: Alignment.TopEnd}){

        HeaderTitle({ title: $title })
          .width('100%')

        Row(){
          Text('清除')
            .fontSize(18)
            .fontColor($r('app.color.text_gray'))
        }
        .height(59)
        .width(50)
        .onClick(() => {

        })

      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))

      //2系统缓存
      Column(){
        Divider()

        Row(){
          Row(){
            Radio({ value: 'Radio1', group: 'radioGroup' })
              .checked(false)
              .height(24)
              .width(24)
              .onChange((isChecked: boolean) => {
                console.log('Radio1 status is ' + isChecked)
              })

            Text('系统缓存')

            Blank()

            Text('缓存大小（MB）')
          }
          .messageset_content()

        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

      }
      .width('100%')
      .height('100%')



    }
    .width('100%')
    .height('100%')

  }
}