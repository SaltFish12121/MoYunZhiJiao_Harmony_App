import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import VideoInfo from '../../../viewmodel/VideoListInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import VideoItem from '../../../viewitem/VideoItem'

@Extend(Row) function videoShow_List(){
  .width(200)
  .borderRadius(CommonConstants.DEFAULT_10)
  .backgroundColor(Color.White)
  .border({ width: 1, color: $r('app.color.gray'), radius: 10, style: BorderStyle.Solid })

}

@Component
export default struct Calligraphy_Teaching {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @Link video: VideoInfo[]

  build() {
    Column(){
      //1 上方提示语
      Row(){
        Text($r('app.string.homework_teachingVideo'))
          .fontSize(CommonConstants.DEFAULT_20)

        Text('更多')
          .fontSize(CommonConstants.DEFAULT_20)
      }
      .width(CommonConstants.THOUSANDTH_900)
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/mainpage/calligraphy_teachingVideo/CalligraphyTeachingPage'
          }
        )

      })

      //2 视频展示图

      Scroll(){
        Row({ space: 20 }) {

          ForEach(this.video,
            (video: VideoInfo) =>
            {
              Row() {

                VideoItem({ video: video })

              }
              .videoShow_List()

            }
          )

          Row(){

          }
          .width(5)
        }
        .margin({left: 5})
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)

        .height(200)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('90%')
      .height(220)


    }
  }
}