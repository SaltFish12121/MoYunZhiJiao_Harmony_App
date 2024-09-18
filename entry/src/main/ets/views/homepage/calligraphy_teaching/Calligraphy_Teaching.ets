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
  @Link video: VideoInfo[]/* = [
    new VideoInfo('楷书的教学视频1', '2024-4-10', $r('app.media.homepage_video'), [
      new LabelInfo('楷书叔'),
      new LabelInfo('教育'),
      new LabelInfo('学习'),
      new LabelInfo('横折练习'),
      new LabelInfo('弯钩'),
      new LabelInfo('撇捺'),
      new LabelInfo('笔画'),
    ]),
    new VideoInfo('楷书的教学视频2', '2024-4-10', $r('app.media.homepage_video2'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo('楷书的教学视频3', '2024-4-10', $r('app.media.homepage_video3'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo('楷书的教学视频4', '2024-4-10', $r('app.media.homepage_video4'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo('楷书的教学视频5', '2024-4-10', $r('app.media.homepage_video'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ])
  ]*/

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



      /*
      Swiper(){
        //2.1 图片
        Image($r('app.media.icon'))

        Image($r('app.media.icon'))
      }
      .margin({top: 10})
      .width('90%')
      .height(232)
      .backgroundColor(Color.White)
      .borderRadius(CommonConstants.DEFAULT_18)
      * */

    }
  }
}