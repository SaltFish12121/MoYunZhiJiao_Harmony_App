import { CommonConstants } from '../../../common/constants/CommonConstants'

@CustomDialog
export default struct UserGradeDialog {
  controller: CustomDialogController

  confirm: (e: string) => void = () => {

  }

  @State primarySchool: string[] = ['一年级', '二年级', '三年级', '四年级', '五年级', '六年级']
  @State middleSchool: string[] = ['初一', '初二', '初三']
  @State highSchool: string[] = ['高一', '高二', '高三']
  @State vocational: string[] = ['职一', '职二', '职三']
  @State university: string[] = ['大一', '大二', '大三', '大四', '研究生']
  @State social: string = '毕业'

  // Area: string = '地区'


  build() {
    Column(){
      // 1.标题
      Row(){
      //   Row(){
      //     Text('地区')
      //
      //     Image($r('app.media.down'))
      //       .width(10)
      //   }
      //   .onClick(() => {
      //     this.area()
      //     this.controller.close()
      //   })


        Text('设置年级')
          .fontSize(20)
          .fontWeight(CommonConstants.FONT_WEIGHT_700)

        Image($r('app.media.close'))
          .width(20)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .borderRadius({ topLeft: 20, topRight: 20 })
      .backgroundColor($r('app.color.start_window_background'))
      .padding(10)

      Scroll(){
        Column({space: CommonConstants.SPACE_10}){

          // 2.年级
          Column({ space: 20 }){
            //学前
            Column({ space: 20 }){
              Text('学前')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)

              Column(){
                gradeType({ grade: '学前班' })
                  .onClick(() => {
                    this.confirm('学前班')
                    this.controller.close()
                  })
              }
              .width('33%')

            }
            .alignItems(HorizontalAlign.Start)


            //小学
            Column({ space: 20 }){
              Text('小学')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)


              GridRow({
                columns: 3,
                gutter: { x: 5, y: 10 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.primarySchool, (grade: string) => {
                  GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                    gradeType({ grade: grade })
                      .onClick(() => {
                        this.confirm(grade)
                        this.controller.close()
                      })

                  }

                })
              }
              .width("100%")

            }
            .alignItems(HorizontalAlign.Start)


            //初中
            Column({ space: 20 }){
              Text('初中')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)


              GridRow({
                columns: 3,
                gutter: { x: 5, y: 10 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.middleSchool, (grade: string) => {
                  GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                    gradeType({ grade: grade })
                      .onClick(() => {
                        this.confirm(grade)
                        this.controller.close()
                      })

                  }

                })
              }
              .width("100%")

            }
            .alignItems(HorizontalAlign.Start)


            //高中
            Column({ space: 20 }){
              Text('高中')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)


              GridRow({
                columns: 3,
                gutter: { x: 5, y: 10 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.highSchool, (grade: string) => {
                  GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                    gradeType({ grade: grade })
                      .onClick(() => {
                        this.confirm(grade)
                        this.controller.close()
                      })

                  }

                })
              }
              .width("100%")

            }
            .alignItems(HorizontalAlign.Start)


            //中职
            Column({ space: 20 }){
              Text('中职')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)


              GridRow({
                columns: 3,
                gutter: { x: 5, y: 10 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.vocational, (grade: string) => {
                  GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                    gradeType({ grade: grade })
                      .onClick(() => {
                        this.confirm(grade)
                        this.controller.close()
                      })

                  }

                })
              }
              .width("100%")

            }
            .alignItems(HorizontalAlign.Start)


            //大学
            Column({ space: 20 }){
              Text('大学')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)


              GridRow({
                columns: 3,
                gutter: { x: 5, y: 10 },
                breakpoints: { value: ["400vp", "600vp", "800vp"],
                  reference: BreakpointsReference.WindowSize },
                direction: GridRowDirection.Row
              }) {
                ForEach(this.university, (grade: string) => {
                  GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                    gradeType({ grade: grade })
                      .onClick(() => {
                        this.confirm(grade)
                        this.controller.close()
                      })

                  }

                })
              }
              .width("100%")

            }
            .alignItems(HorizontalAlign.Start)


            //毕业
            Column({ space: 20 }){
              Text('毕业')
                .width('100%')
                .fontWeight(CommonConstants.FONT_WEIGHT_700)

              Column(){
                gradeType({ grade: '已毕业' })
                  .onClick(() => {
                    this.confirm('已毕业')
                    this.controller.close()
                  })

              }
              .width('33%')

            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Start)

          // 3.暂不设置
          Column(){
            Text('暂不设置')
              .fontSize(12)
              .fontColor($r('app.color.light_black'))
              .margin({top: 20, bottom: 20})
          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .onClick(() => {
            this.confirm('未设置')
            this.controller.close()
          })


        }
        .width('100%')
        .backgroundColor($r('app.color.start_window_background'))
        .padding(10)

      }
      .height('70%')

    }
    .justifyContent(FlexAlign.End)
    .height('100%')



  }
}


@Component
struct gradeType {
  grade: string = ''

  build() {
    Column(){
      Text(this.grade)
        .fontSize(12)
        .margin({top: 5, bottom: 5})
    }
    .width(90)
    .backgroundColor($r('app.color.light_gray'))
    .border({ width: 1, color: $r('app.color.light_gray'), radius: 40, style: BorderStyle.Solid })

  }
}