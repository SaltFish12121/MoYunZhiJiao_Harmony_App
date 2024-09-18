import router from '@ohos.router';
import { HeaderSearch, HeaderTitle } from '../../../common/components/CommonComponents'
import { Radical, radical } from '../../../data/Radical'

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
  url: string = 'pages/exercise/exercise_self/NewSelfPage'

  @State title: string = '偏旁部首'

  build() {
    Column(){

      //1头部
      Column(){
        HeaderTitle({ title: $title })

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
                      url: this.url,
                      params: {
                        success: true,
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
    .backgroundColor($r('app.color.mid_gray'))

  }

  onPageShow(): void {
    const url = router.getParams() as PARAMS
    this.url = url.url
  }
}

// 声明接受参数的类型
interface PARAMS {
  url: string
}