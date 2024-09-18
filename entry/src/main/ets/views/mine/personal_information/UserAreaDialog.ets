import { CommonConstants } from '../../../common/constants/CommonConstants'

@CustomDialog
export default struct UserAreaDialog{
  controller: CustomDialogController

  area: (e: string) => void  = () => {

  }


  normalIcon : Resource = $r("app.media.user")
  selectedIcon: Resource = $r("app.media.user")
  @State arr: number[] = [1, 2, 3]
  @State current: number = 1

  build() {
    Column(){
      // 1.标题
      Column({space: 15}){
        Row(){
          Column()
            .width(20)

          Column({space: 5}){
            Text('选择地区')
              .fontSize(16)

            Text('请选择所在地区，为您提供相关学习内容')
              .fontSize(12)
              .fontColor($r('app.color.light_black'))
          }

          Image($r('app.media.close'))
            .width(20)
            .onClick(() => {
              this.controller.close()
            })

        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)


        //搜素
        Search({ placeholder: '请输入就读学校'})
          .backgroundColor('#F5F5F5')
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 14, weight: 400 })
          .textFont({ size: 14, weight: 400 })
          .height(30)
      }
      .width('100%')
      .borderRadius({ topLeft: 20, topRight: 20 })
      .backgroundColor($r('app.color.start_window_background'))
      .padding(10)

      Scroll(){
        Column({space: CommonConstants.SPACE_10}){
          //定位地区
          Row(){
            Text('南京市')
              .fontSize(14)

            Text('重新定位')
              .fontSize(14)
              .fontColor($r('app.color.blue'))
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          //地区列表
          Text('area')
            .onClick(() => {
              this.area('未设置')
              this.controller.close()
            })

          // List()


        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding(10)

      }
      .align(Alignment.Top)
      .backgroundColor($r('app.color.start_window_background'))
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