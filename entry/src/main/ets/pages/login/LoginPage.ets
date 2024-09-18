import router from '@ohos.router'
@Entry
@Component
struct LoginPage {

  build() {
    Column(){
      //1头部
      Row(){
        Column(){
          Image($r('app.media.close'))
            .height(20)
        }
        .height(34)
        .width(34)
        .onClick(() => {
          router.replaceUrl(
            {
              url: 'pages/mainpage/HomePage'
            }
          )
        })


      }
      .justifyContent(FlexAlign.SpaceBetween)
      .height(59)
      .width('95%')

      //2内容
      Column(){
        Text($r('app.string.app_name'))
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Image($r('app.media.app'))
          .margin({top: 50})
          .width(250)
      }


      //3按钮
      Column({space: 40}){
        Button('学校用户')
          .width('80%')
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/login/studentEnter/StudentEnter'
              }
            )
          })


        Button('其它用户')
          .width('80%')
          .backgroundColor($r('app.color.button1'))
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/login/socialEnter/SocialEnter'
              }
            )
          })

      }
      .margin({top: 150})


    }
    .width('100%')
    .height('100%')
  }
}