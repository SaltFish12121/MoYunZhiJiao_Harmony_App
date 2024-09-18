import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'

@Extend(Column) function about_column(){
  .width('100%')
  .height(64)
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
}

@Extend(Row) function about_row(){
  .width('95%')
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
}

@Entry
@Component
struct AboutPage {

  @State title: string = '关于'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })


      //2手机版本
      Divider()

      Column(){
        Row(){
          Text('本机版本')
            .fontSize(20)

          Text('当前版本')
        }
        .about_row()

      }
      .about_column()


      //3检测新版本
      Divider()

      Column(){
        Row(){
          Text('检测新版本')
            .fontSize(20)

          Text('当前版本')
        }
        .about_row()

      }
      .about_column()


      //4备案信息
      Divider()

      Column(){
        Row(){
          Text('备案信息')
            .fontSize(20)

          Image($r('app.media.enter'))
            .width(24)
        }
        .about_row()

      }
      .about_column()
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mine/mine_set/about/ArchivalInformationPage'
          }
        )
      })

      Divider()

    }
    .width('100%')
    .height('100%')


  }
}