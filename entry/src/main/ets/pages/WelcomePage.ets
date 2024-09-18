import router from '@ohos.router';

@Entry
@Component
struct WelcomePage {
  @State message: string = 'Hello World';

  async aboutToAppear(){
    await this.jumpToIndex()
  }

  jumpToIndex(){
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/mainpage/HomePage'
      })
    }, 1500)//延迟1000ms再跳转
  }

  jumpToLogin(){
    setTimeout(() => {
      router.replaceUrl({
        url: 'pages/login/LoginPage'
      })
    }, 1500)//延迟1000ms再跳转
  }

  build() {
    Column({space: 10}){

      //1.中央slogan
      Row(){
        Image($r('app.media.app')).width(260)
      }
      .layoutWeight(1)//布局权重

      //2.logo
      // Image($r('app.media.video_1')).width(150)


    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.start_window_background'))
  }
}