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
struct MessageSetPage {

  @State title: string = '消息设置'

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })


      //2消息设置
      Column(){

        Divider()

        //接收推送通知
        Row(){
          Row(){
            Text('接收推送通知')
              .fontSize(20)

            Toggle({ type: ToggleType.Switch, isOn: true })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .messageset_content()
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)


        Divider()


        //接收新消息通知
        Row(){
          Row(){
            Text('接收新消息通知')
              .fontSize(20)

            Toggle({ type: ToggleType.Switch, isOn: true })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .messageset_content()
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()


        //通知栏显示消息详情
        Row(){
          Row(){
            Text('通知栏显示消息详情')
              .fontSize(20)

            Toggle({ type: ToggleType.Switch, isOn: true })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .messageset_content()
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()


        //接收通知或站内信函提醒
        Column(){
          Row(){
            Text('接收通知或站内信函提醒')
              .fontSize(20)

            Toggle({ type: ToggleType.Switch, isOn: true })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .messageset_content()

          Row(){
            Column({space: 5}) {
              Image($r('app.media.messageset_center'))
                .width(120)
                .height(180)

              Text('弹窗提醒')
                .fontSize(16)
                .fontColor($r('app.color.text_gray'))

              Radio({ value: 'Radio1', group: 'radioGroup' }).checked(true)
                .height(30)
                .width(30)
                .onChange((isChecked: boolean) => {
                  console.log('Radio1 status is ' + isChecked)
                })
            }


            Column({space: 5}) {
              Image($r('app.media.messageset_top'))
                .width(120)
                .height(180)

              Text('横幅提醒')
                .fontSize(16)
                .fontColor($r('app.color.text_gray'))

              Radio({ value: 'Radio2', group: 'radioGroup' }).checked(false)
                .height(30)
                .width(30)
                .onChange((isChecked: boolean) => {
                  console.log('Radio2 status is ' + isChecked)
                })
            }
          }
          .margin({top : 10})
          .width('90%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceAround)
        }
        .width('100%')
        .height(330)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)

        Divider()

        //站内消息中心提示
        Row(){
          Row(){
            Text('站内消息中心提示')
              .fontSize(20)

            Toggle({ type: ToggleType.Switch, isOn: true })
              .selectedColor('#007DFF')
              .switchPointColor('#FFFFFF')
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .messageset_content()
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Divider()

        //通知管理
        Row(){
          Row(){
            Text('通知设置')
              .fontSize(20)

            Image($r('app.media.enter'))
              .width(24)
          }
          .messageset_content()
          .onClick(() => {

          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)


        Divider()
      }

    }
    .width('100%')
    .height('100%')


  }
}