import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
@Extend(Column) function New(){
  .margin({left: 10, bottom: 5})
  .justifyContent(FlexAlign.Center)
  .width('80%')
  .height(120)
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

@Component
export default struct New_Self {
  build() {
    Column(){
      Column(){
        Text('系统模板')
          .fontSize(34)
      }
      .New()
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/exercise/exercise_self/NewSystemPage'
          }
        )
      })

      Column(){
        Text('已有练习')
          .fontSize(34)
      }
      .New()
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/exercise/exercise_self/NewHistoryPage'
          }
        )
      })

      Column(){
        Text('自主生成')
          .fontSize(34)
      }
      .New()
      .onClick(() => {
        router.pushUrl(
          {
            url: 'pages/exercise/exercise_self/NewSelfPage',
            params: {
              success: false
            }
          }
        )
      })

      Column(){

      }
      .width('80%')
      .height(120)
    }
    .margin({top: 10})
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}