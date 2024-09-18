import router from '@ohos.router'
@Component
export default struct Comprehensive_Exercises {
  @State name: string = ''
  @State content: string = ''
  @State typeface: string = '楷书'
  @State composeType: string = '默认'

  @State placeholder: string = '请输入名称'
  @State inputColor: ResourceColor = $r('app.color.light_black')
  @State placeholder2: string = '请输入内容'
  @State inputColor2: ResourceColor = $r('app.color.light_black')
  build() {
    Scroll(){

      Column({space: 15}){
        //1名称
        Row({space: 10}){
          Text('名称')
            .fontSize(20)

          TextInput({placeholder: this.placeholder})
            .placeholderColor(this.inputColor)
            .backgroundColor($r('app.color.start_window_background'))
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
            .width(200)
            .onChange((v) => {
              this.name = v
            })
        }
        .width('90%')
        .height(77)


        //2内容
        Column({space: 10}){
          Text('内容')
            .fontSize(20)
            .width('100%')
            .textAlign(TextAlign.Start)

          TextArea({placeholder: this.placeholder2})
            .placeholderColor(this.inputColor2)
            .backgroundColor($r('app.color.start_window_background'))
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
            .height('90%')
            .onChange((v) => {
              this.content = v
            })

        }
        .width('90%')
        .height('40%')

        //3排版
        Row({space: 40}){
          Text('选择排版')
          .fontSize(20)

          Row({space:5}){
            Select([{ value: '默认', icon: "/common/public_icon.svg" },
              { value: '居中', icon: "/common/public_icon.svg" },
              { value: '竖版', icon: "/common/public_icon.svg" }])
              .selected(0)
              .value('默认')
              .font({ size: 14, weight: 500 })
              .fontColor('#182431')
              .backgroundColor($r('app.color.start_window_background'))
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number, v: string) => {
                console.info('Select:' + index)
                this.composeType = v
              })


            // Text('默认')
            //   .fontSize(14)

            // Image($r('app.media.down'))
            //   .width(12)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          // .width(70)
          .height(31)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

        }
        .margin({top: 20})
        .width('90%')

        //4字体
        Row({space: 40}){
          Text('选择字体')
          .fontSize(20)

          Row({space:5}){
            Select([{ value: '楷书', icon: "/common/public_icon.svg" },
              { value: '行书', icon: "/common/public_icon.svg" },
              { value: '行楷', icon: "/common/public_icon.svg" },
              { value: '草书', icon: "/common/public_icon.svg" }])
              .selected(0)
              .value('字体')
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
              .backgroundColor($r('app.color.start_window_background'))
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number, value: string) => {
                console.info('Select:' + index)

                this.typeface = value
              })

          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          // .width(64)
          .height(31)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
          .onClick(() => {

          })


        }
        .margin({top: 20})
        .width('90%')

        //5确认
        Column(){
          Text('确认')
            .fontSize(28)
        }
        .margin({top: 40})
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .width(170)
        .height(52)
        .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
        .onClick(() => {

          if (this.name != '') {
            if (this.content != '') {
              router.pushUrl(
                {
                  url: 'pages/exercise/exercise_self/self_generated/ComprehensiveExerciseVerifyPage',
                  params: {
                    title: this.name,
                    content: this.content,
                    typeface: this.typeface,
                    composeType: this.composeType
                  }
                }
              )
            } else {
              this.placeholder2 = '内容不能为空'
              this.inputColor2 = $r('app.color.tips_red')
            }
          } else {
            this.placeholder = '名称不能为空'
            this.inputColor = $r('app.color.tips_red')
          }


        })


      }
      .width('100%')

    }
    .align(Alignment.TopStart)
    .width('100%')
    .height('100%')

  }
}