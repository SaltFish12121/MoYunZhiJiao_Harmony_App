import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

//练习详情（提交的图）
@Entry
@Component
struct ExerciseDetailPage {
  @State Number: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
  private  Number2: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  @State submit: SubmitWritingInfo = new SubmitWritingInfo(0, "https://dummyimage.com/120x240")

  @State title: string = '详情'
  @State connect: boolean = false

  build() {
    if (this.connect) {
      Scroll(){
        Column(){
          //1头部
          HeaderTitle({ title: this.title })

          //2原图
          Column(){
            Image(this.submit.submit)
              .width('100%')
          }
          .width('80%')
          .margin({ bottom: 20})

          //3详细字
          Column(){
            Text('可点击下方字查看细致评分')
              .fontSize(14)

            Column(){

              GridRow({
                columns: 8,
                gutter: { x: 2, y: 5 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.Number, (number1: number) => {
                  // 如果当前行所有得分都为0，则跳过显示
                  if (!this.Number2.every((number2: number) => this.submit.word[number1][number2].strokeNumber === 0)){
                    ForEach(this.Number2, (number2: number) => {
                      GridCol() {
                        Column() {
                          Column() {
                            Image(this.submit.word[number1][number2].word)
                              .height(30);
                          }
                          .width('100%')
                          .constraintSize({ minHeight: 35, maxHeight: 35 })
                          .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid })
                          .alignItems(HorizontalAlign.Center)
                          .justifyContent(FlexAlign.Center);

                          Column() {
                            Text(`${this.submit.word[number1][number2].strokeNumber}`)
                              .fontSize(12)
                              .fontColor($r('app.color.text_red'));
                          }
                          .width('100%');
                        }
                        .width('100%')
                        .onClick(() => {
                          if (this.submit.word[number1][number2].strokeNumber != 0) {
                            router.pushUrl({
                              url: 'pages/exercise/exercise_detail/ExerciseEachWordPage',
                              params: {
                                data: this.submit.word[number1][number2],
                                ifSuccess: 1
                              }
                            })
                          }
                        })

                      }
                    })
                  }
                })


              }

            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .width('90%')

          Column(){

          }
          .height(50)

        }
        .width('100%')

      }
    }

  }


  async  onPageShow(){
    const param = router.getParams() as PARAMS

    if (param != null) {
      this.submit = param.submit
      console.log('Params', this.submit.submit, this.submit.word[0][0].word, this.submit.word[0][7].word, this.submit.word[11][0].word, this.submit.word[11][7].word)
      this.connect = true
    }

  }
}

// 声明接受参数的类型
interface PARAMS {
  submit: SubmitWritingInfo
}