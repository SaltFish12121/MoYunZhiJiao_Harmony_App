import VideoInfo from '../../../viewmodel/VideoInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import LabelItem from '../../../viewitem/LabelItem'

@Component
export default struct Video_Brief_Introduction {
  @Link video: VideoInfo

  build() {
    Scroll(){

      Column({space: 20}){
        //简介
        Column({ space: 10}){
          Text('简介')
            .width('90%')

          Column(){
            Text(this.video.intro)
              .fontSize(12)
          }
          .width('85%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')

        //标签内容
        Column({space: 10}) {

          Text('标签')
            .width('90%')

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {

            ForEach(
              this.video.label ,
              (label: LabelInfo) => {

                Column(){
                  LabelItem({ Label: label})
                }
                .margin({right: 10, bottom: 10})



              }
            )

          }
          .width('95%')

        }
        .margin({top: 10})


        Column(){

        }
        .height(100)

      }


    }
    .height('100%')
    .width('100%')
    .align(Alignment.TopStart)

  }
}