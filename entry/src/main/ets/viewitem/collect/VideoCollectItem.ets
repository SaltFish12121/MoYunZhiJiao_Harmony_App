import router from '@ohos.router'
import VideoInfo from '../../viewmodel/VideoListInfo'

@Component
export default struct VideoCollectItem {
  video: VideoInfo = new VideoInfo(0, '', '', '', '')

  build() {
    Row({space: 10}){
      Column({space: 20}){
        Text(this.video.title)
          .fontSize(19)

        Row({space: 10}){
          // Text(`${this.knowledge.viewNumber}阅读`)
          //   .fontSize(12)

          Text(this.video.time)
            .fontSize(12)
        }

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .height('70%')

      Blank()

      Column(){
        Image(this.video.cover)
          .width(70)
          .height(70)

      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .height('60%')
      .width(90)


    }
    .width('95%')
    .height(100)
    .onClick(() => {
      router.pushUrl(
        {
          url: 'pages/mainpage/calligraphy_teachingVideo/TeachingVideoDetialPage',
          params: {
            video: this.video
          }
        }
      )

    })
  }
}