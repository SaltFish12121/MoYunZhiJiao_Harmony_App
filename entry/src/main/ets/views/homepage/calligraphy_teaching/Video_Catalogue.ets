import VideoInfo from '../../../viewmodel/VideoInfo'
import VideoContentInfo from  '../../../viewmodel/VideoContentInfo'
import InformationService from '../../../service/InformationService'


@Component
export default struct Video_Catalogue {

  @Link sonVideo: VideoInfo[]
  @Link arr: number[]
  @Link selectVideoId: number
  @Link selectVideoTitle: string

  @Link videoContent: VideoContentInfo

  build() {
    Scroll(){
      Column(){

        ForEach(
          this.sonVideo,
          (sonVideo: VideoInfo, arr: number) => {
            Column(){
              Column(){
                Row({space: 10}){

                  Text(''+this.arr[arr])

                  Text(sonVideo.title)
                }
                .height('50%')
                .alignItems(VerticalAlign.Center)

                Row(){
                  Text(sonVideo.playTime)
                    .fontSize(12)
                    .fontColor($r('app.color.text_gray'))

                  Text('播放量'+sonVideo.playAmount)
                    .fontSize(12)
                    .fontColor($r('app.color.text_gray'))
                }
                .height('50%')
                .width('95%')
                .alignItems(VerticalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)

              }
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.Center)
              .height(80)
              .width('90%')

              Divider()
            }
            .width('100%')
            .onClick(() => {
              this.selectVideoId = sonVideo.id
              this.selectVideoTitle = sonVideo.title
              console.log('selectVideoId', this.selectVideoId)

              this.getVideo(this.selectVideoId)
            })

          }
        )

        Column().height(50)

      }
      .width('100%')

    }
    .align(Alignment.Top)
    .height('100%')

  }

  //获取视频数据
  async getVideo(id: number){
    await InformationService.getVideo(id)
      .then((video: VideoContentInfo) => {
        console.log('Tags', '获取视频数据成功', id)

        this.videoContent = video
      })
      .catch((error: string) => {
        console.log('Tags', '获取视频数据失败')
      })
  }
}