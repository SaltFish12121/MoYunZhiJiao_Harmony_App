import router from '@ohos.router';
import { Radical, radical } from '../data/Radical'
import Test from '../service/Test'

//样式
@Styles function card(){
  .width('100%')
  .height(70)
  .backgroundColor($r('app.color.start_window_background'))
}

@Entry
@Component
struct RadicalSearchPage {
  scroller: Scroller = new Scroller();

  @State title: string = '偏旁部首'
  isOutControl: boolean = false

  build() {
    Column(){

      //1头部
      Column(){
        Row(){
          if (this.isOutControl) {
            Column(){
              Image($r('app.media.return'))
            }
            .height(34)
            .width(34)
          } else {
            Column(){
              Image($r('app.media.return'))
            }
            .height(34)
            .width(34)
            .onClick(() => {

              router.back()
            })

          }

          Column(){
            Text(this.title)
              .fontSize(20)
          }

          Column(){
            Button('123')
              .onClick(() => {
                this.InternetTest()
              })
          }
          .width(34)

        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .height(59)

        Search()
          .width('90%')

        Divider()
      }
      .backgroundColor($r('app.color.start_window_background'))

      //2笔画列表
      Scroll(this.scroller){
        Column(){
          ForEach(
            radical,
            (rad: Radical) => {
              Column(){
                Blank()

                Row(){
                  Text(`${rad.radical}`)
                    .fontSize(24)

                  Text(`${rad.name}`)
                    .fontSize(20)
                    .textAlign(TextAlign.Start)
                }
                .alignItems(VerticalAlign.Center)
                .justifyContent(FlexAlign.SpaceBetween)
                .width('90%')
                .onClick(() => {
                  router.back(

                    {
                      url: 'pages/exercise/exercise_self/NewSelfPage',
                      params: {
                        radical: rad
                      }
                    }

                  )
                })

                Blank()

                //划线
                Divider()
                  .height(1)
              }
              .card()

            }
          )

          Column(){

          }
          .height(200)

        }
      }
      .scrollable(ScrollDirection.Vertical) // 滚动方向为垂直方向



    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)

  }

  InternetTest(){
    Test.testInternet(1)
      .then((success) => {
        console.log('success', success)
      })
      .catch(() => {
        console.log('error')
      })
  }
}

