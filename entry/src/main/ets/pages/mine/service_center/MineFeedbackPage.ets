import { HeaderTitle } from '../../../common/components/CommonComponents'
import UserService from '../../../service/UserService'
import FeedbackInfo from '../../../viewmodel/FeedbackInfo'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Entry
@Component
struct MineFeedbackPage {
  private arr: number[] = [0, 1]

  @State feedback: FeedbackInfo[] = [
    new FeedbackInfo(0,'样式建议与反馈', '如何注册', '2024-6-5 19:07:13'),
    new FeedbackInfo(0,'体验建议与反馈', '如何创建练习', '2024-6-4 09:07:13'),
    new FeedbackInfo(0,'样式建议与反馈', '如何报名竞赛', '2024-6-3 09:47:13')/*,
    new FeedbackInfo(0,'用户1', '如何注册', '2024-6-5'),
    new FeedbackInfo(0,'用户1', '如何创建练习', '2024-6-5'),
    new FeedbackInfo(0,'用户1', '如何报名竞赛', '2024-6-5'),
    new FeedbackInfo(0,'用户1', '如何注册', '2024-6-5'),
    new FeedbackInfo(0,'用户1', '如何创建练习', '2024-6-5'),
    new FeedbackInfo(0,'用户1', '如何报名竞赛', '2024-6-5'),*/
  ]

  @State title: string = '我的反馈'

  build() {
    Scroll(){
      Column(){
        //1头部
        HeaderTitle({ title: $title })
          .backgroundColor($r('app.color.start_window_background'))
          .margin({bottom: 5})

        // Divider()

        //2反馈内容
        Column(){
          List(){
            ForEach(this.feedback, (feedback: FeedbackInfo) => {
              ListItem() {

                Column(){

                  Column(){
                    Row(){

                      Column(){
                        Text(feedback.time)

                        Text('问题类型：'+feedback.type)
                      }
                      .height(45)
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.SpaceBetween)
                      .margin({left: 10})

                    }
                    .height(70)
                    .width('95%')

                    Divider()
                    .width('90%')

                    Column({space: 10}){
                      Row(){
                        Text('问：')
                          .fontColor($r('app.color.blue'))

                        Text(feedback.content)
                          .width('90%')
                      }
                      .alignItems(VerticalAlign.Top)
                      .justifyContent(FlexAlign.Start)
                      .width('90%')

                      Row(){
                        Text('答：')
                          .fontColor($r('app.color.blue'))

                        if (feedback.feedback == null) {
                          Text('暂未回复')
                            .width('90%')
                        } else {
                          Text(feedback.feedback)
                            .width('90%')
                        }

                      }
                      .alignItems(VerticalAlign.Top)
                      .justifyContent(FlexAlign.Start)
                      .width('90%')
                    }
                    .margin({top: 10, bottom: 10})


                  }
                  .width('90%')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .backgroundColor($r('app.color.start_window_background'))
                  .borderRadius(10)

                }
                .width('100%')
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)

              }
              .margin({top: 10, bottom: 10})



            })

            ListItem(){

            }
            .height(100)

          }

        }
        .width('100%')


      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.mid_gray'))
    }
  }

  onPageShow(){
    //获取个人意见反馈记录
    this.getMineFeedback()
  }

  //获得个人意见反馈记录
  async getMineFeedback(){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    userId = 32 //测试用
    UserService.getMineFeedback(userId)
      .then((feedback: FeedbackInfo[]) => {
        console.log('Tags', '获取个人意见反馈记录成功')

        this.feedback = feedback
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人意见反馈记录失败')
      })
  }

}