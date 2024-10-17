import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'
import StrokeInfo from '../../../viewmodel/StrokeInfo'
import VideoContentInfo from  '../../../viewmodel/VideoContentInfo'
import ExerciseService from  '../../../service/ExerciseService'
import { window } from '@kit.ArkUI'

//练习单字详情（所选的字）
@Entry
@Component
struct ExerciseEachWordPage {
  @State content: string = ''

  @State word: WordInfo = new WordInfo('', '', [])

  @State title: string = '详情'

  @State videoSrc: ResourceStr = ''
  @State previewUri: ResourceStr = ''
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true
  controller: VideoController = new VideoController()

  @State videoContent: VideoContentInfo =  new VideoContentInfo(0, this.previewUri, this.videoSrc)

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      Scroll(){
        Column(){
          //1 写的字与模板字
          Row(){
            //1.1 所写字
            Column({space: 5}){
              Text('所写字')

              Column(){
                Image(this.word.word)
                  .height(80)

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width(100)
              .height(100)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
            }

            //1.2 模板字
            Column({space: 5}){
              Text('模板字')

              Column(){
                if (this.word.templateWord != ''){
                  Image(this.word.templateWord)
                    .width(80)
                    .height(80)
                }

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width(100)
              .height(100)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
            }

            //1.3 综合评分
            Column({space: 5}){
              Text('综合评分')
                .fontSize(16)

              Column(){
                Text(`${this.word.strokeNumber}`)
                  .fontColor($r('app.color.text_red'))
                  .fontSize(28)
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .height(100)
              .width(70)
            }

          }
          .width('85%')
          .justifyContent(FlexAlign.SpaceBetween)


          //2 书写视频
          Column({space: 5}){
            Text('书写视频')
              .width('100%')
              .fontSize(16)

            Video({
              src: this.videoContent.contentUrl,
              previewUri: this.videoContent.contentUrl,
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
              .onFullscreenChange((ifFull) => {
                console.info('onFullscreenChange', ifFull.fullscreen)
                //让屏幕横屏
                if (ifFull.fullscreen) {
                  this.setR(2)
                } else {
                  this.setR(1)
                }
              })

          }
          .width('90%')
          .margin({top: 20})


          //3 建议与笔画
          Row(){
            //3.1 左边-综合建议
            Column({space: 10}){

              Column({space: 10}){
                Column(){
                  Text('综合建议')
                    .fontSize(20)
                }


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
            .width('48%')
            .align(Alignment.Top)




            //3.2 右边-笔画详情
            Column(){

              Column(){
                Text('笔画详情')
                  .fontSize(20)

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.SpaceBetween)
              .height(30)

              Column({space: 5}){

                Scroll(){
                  Column(){
                    ForEach(
                      this.word.strokes,
                      (stroke: StrokeInfo) => {


                        Column(){
                          Row(){
                            // 笔画
                            Image(stroke.stroke)
                              .sourceSize({width: 50, height: 40})
                              .height(40)
                              .width(50)

                            // 得分
                            Text(''+stroke.number)
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

                    Column().height(80)
                  }

                }
                .height(250)
                .align(Alignment.Top)



              }
              .padding({top: 10, bottom: 10})
              .constraintSize({ minWidth: 50})
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid})

            }
            .width('48%')
            .align(Alignment.Top)
            .margin({top: 20})

          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Top)
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

          Column().height(100)

        }
        .align(Alignment.Top)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
    }

  }


  async onPageShow(){
    const word = router.getParams() as PARAMS

    if (word != null && word.ifSuccess == 1) {
      this.word = word.data
      this.content = word.data.comment
      console.log('Params template', this.word.templateWord, this.word.strokes , this.content )
    }

    await this.getWordVideo(this.word.name)
  }


  // 设置窗口方向
  setR(orientation: number) {
    window.getLastWindow(getContext(this)).then((win) => {
      win.setPreferredOrientation(orientation).then((data) => {
        console.log('setWindowOrientation: ' + orientation + ' Succeeded. Data: ' + JSON.stringify(data));
      }).catch((err: string) => {
        console.log('setWindowOrientation: Failed. Cause: ' + JSON.stringify(err));
      });
    }).catch((err: string) => {
      console.log('setWindowOrientation: Failed to obtain the top window. Cause: ' + JSON.stringify(err));
    });
  }

  //获取字的视频
  async getWordVideo(name: string){
    console.log('getWordVideo', name)

    await ExerciseService.getWordVideo(name)
      .then((video: VideoContentInfo) => {
        console.log('Tags', '获取字的视频成功')

        this.videoContent = video
      })
      .catch((error: string) => {
        console.log('Tags', '获取字的视频失败')
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  data: WordInfo
}