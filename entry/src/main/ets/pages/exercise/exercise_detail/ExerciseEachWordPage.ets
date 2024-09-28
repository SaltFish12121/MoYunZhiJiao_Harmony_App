import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'

@Entry
@Component
struct ExerciseEachWordPage {
  @State content: string =
`优点
    总体大小适中，位置合理




不足
    这个字整体过于分离左右结构，左右分的太开右半部分，撇点与点过小`

  @State word: WordInfo = new WordInfo('', [$r('app.media.0009_1'), $r('app.media.0009_2'), $r('app.media.0009_3')])

  @State title: string = '详情'

  @State videoSrc: Resource = $rawfile('video1.mp4')
  @State previewUri: Resource = $r('app.media.show_knoledge')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true
  controller: VideoController = new VideoController()


  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })
      // .position({ x: 0, y: 0})

      Scroll(){
        Column(){
          //1写的字与样本字
          Row(){
            Column({space: 5}){
              Text('所写字')

              Column(){
                Image(this.word.word)
                  .height(120)

                // Image($r('app.media.HandwrittenChineseStroke_test_0000000038'))
                //   .width(120)
                //   .height(120)
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width(140)
              .height(140)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
            }

            Column({space: 5}){
              Text('模板字')

              Column(){
                if (this.word.templateWord != ''){
                  Image(/*$r('app.media.KaitiChineseStroke_train_000000001548')*/this.word.templateWord)
                    .width(120)
                    .height(120)
                } else {
                  Image($r('app.media.KaitiChineseStroke_train_000000001548')/*this.word.templateWord*/)
                    .width(120)
                    .height(120)
                }

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width(140)
              .height(140)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
            }


          }
          .width('85%')
          .justifyContent(FlexAlign.SpaceBetween)

          //2视频
          Column({space: 5}){
            Text('书写视频')
              .width('100%')
              .fontSize(16)

            Video({
              src: this.videoSrc,
              previewUri: this.previewUri,
              currentProgressRate: this.curRate,
              controller: this.controller
            }).width('100%').height(200)
              .autoPlay(this.isAutoPlay)
              .controls(this.showControls)
              .onStart(() => {
                console.info('onStart')
              })
              .onPause(() => {
                console.info('onPause')
              })
              .onFinish(() => {
                console.info('onFinish')
              })
              .onError(() => {
                console.info('onError')
              })
              .onPrepared((e) => {
                console.info('onPrepared is ' + e.duration)
              })
              .onSeeking((e) => {
                console.info('onSeeking is ' + e.time)
              })
              .onSeeked((e) => {
                console.info('onSeeked is ' + e.time)
              })
              .onUpdate((e) => {
                console.info('onUpdate is ' + e.time)
              })

          }
          .width('90%')
          // .backgroundColor($r('app.color.light_gray'))
          .margin({top: 20})

          //3内容
          Row(){
            //左边-综合建议
            Column({space: 10}){

              //3综合建议
              Column({space: 10}){
                Text('综合建议')
                  .fontSize(20)

                Column(){
                  Text(this.content)
                    .fontSize(16)
                    .width('90%')
                }
                .width('100%')
                .padding({top: 10, bottom: 10})
                .constraintSize({ minHeight: 300})
                .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid})
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
              .margin({top: 20})

            }
            // .height('80%')
            .width('48%')
            .align(Alignment.Top)




            //右边-笔画详情
            Column(){
              //1综合评分
              Row({ space: 10 }){
                Text('综合评分')
                  .fontSize(28)

                Text(`${this.word.strokeNumber}`)
                  .fontColor($r('app.color.text_red'))
                  .fontSize(28)
              }
              .height(100)
              .alignItems(VerticalAlign.Center)



              //2笔画详情
              Column({space: 5}){

                Column(){
                  Text('笔画详情')
                    .height(50)

                  Divider()
                }
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)
                .height(50)

                Scroll(){
                  Column(){
                    ForEach(
                      this.word.strokes,
                      (stroke: ResourceStr) => {


                        Column(){
                          Row(){
                            Image(stroke)
                              .sourceSize({width: 50, height: 40})
                              .height(40)
                              .width(50)

                            Text(/*'80'*/)
                              .fontColor($r('app.color.text_red'))
                          }
                          .width('90%')
                          .height(50)
                          .alignItems(VerticalAlign.Center)
                          .justifyContent(FlexAlign.SpaceBetween)

                          Divider()

                        }

                        .width('100%')


                      }
                    )
                  }

                }
                .height(250)
                .align(Alignment.Top)



              }
              // .width('100%')
              .padding({top: 10, bottom: 10})
              // .constraintSize({ minHeight: 300})
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid})

            }
            // .height('80%')
            .width('48%')

          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('95%')

          //3关闭
          Column(){
            Text('关闭')
              .fontSize(28)
          }
          .margin({top: 50})
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
          .height(50)
          .width(150)
          .onClick(() => {
            router.back()
          })

          Column(){

          }
          .height(100)

        }
        .align(Alignment.Top)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
    }

  }


  onPageShow(){
    const word = router.getParams() as PARAMS

    if (word != null && word.ifSuccess == 1) {
      this.word = word.data
      this.content = word.data.comment
      console.log('Params template', this.word.templateWord, this.word.strokes , this.content )
    }
    /**
     * 传入Id，数据库获取
     */

  }
}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  data: WordInfo
}