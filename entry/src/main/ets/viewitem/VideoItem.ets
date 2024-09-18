import router from '@ohos.router'
import VideoInfo from '../viewmodel/VideoListInfo'

@Component
export default struct VideoItem {
  video: VideoInfo = new VideoInfo(0, '', '', '', '')

  build() {

    Column({space: 15}){
      Column(){
        Image(this.video.cover)
          .borderRadius({topLeft: 10, topRight: 10})
          .width('100%')
          .height(130)
      }
      .width('100%')

      Column({space: 15}){
        Text(this.video.title)
          .fontSize(20)

        Text(this.video.time)
          .fontSize(12)
          .fontColor($r('app.color.light_black'))
      }
      .alignItems(HorizontalAlign.Start)
      .width("90%")

    }
    .width("100%")
    .height("200")
    .onClick(() => {
      // console.log(`title=${video.title}`)

      router.pushUrl(
        {
          url: 'pages/mainpage/calligraphy_teachingVideo/TeachingVideoDetialPage',
          params: {
            video: this.video,
          }
        }
      )
    })


  }
}