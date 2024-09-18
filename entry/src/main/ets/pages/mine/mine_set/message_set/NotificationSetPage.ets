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
struct NotificationSetPage {

  @State title: string = '通用设置'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      //2内容
      Column(){
        Divider()

        //语言设置
        Row(){
          Row(){
            Text('语言设置')
              .fontSize(20)

            Image($r('app.media.enter'))
              .width(24)
          }
          .messageset_content()
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/mine_set/message_set/LanguageSetPage'
              }
            )
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

        //管理储存空间
        Row(){
          Row(){
            Text('管理储存空间')
              .fontSize(20)

            Image($r('app.media.enter'))
              .width(24)
          }
          .messageset_content()
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/mine_set/message_set/ManageStorageSpacePage'
              }
            )
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

      }

    }
  }
}