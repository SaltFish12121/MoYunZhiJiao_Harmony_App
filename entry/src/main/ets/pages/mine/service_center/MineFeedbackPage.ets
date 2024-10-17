import { HeaderTitle } from '../../../common/components/CommonComponents'
import UserService from '../../../service/UserService'
import FeedbackInfo from '../../../viewmodel/FeedbackInfo'
import Cant_Connect from '../../../views/Cant_Connect'
import No_Content from '../../../views/No_Content'

//用户反馈记录
@Entry
@Component
struct MineFeedbackPage {
  @State feedback: FeedbackInfo[] = []

  @State title: string = '我的反馈'
  @State ifConnect: boolean = false

  build() {
    Scroll(){
      Column(){
        //1头部
        HeaderTitle({ title: $title })
          .backgroundColor($r('app.color.start_window_background'))
          .margin({bottom: 5})

        if (this.ifConnect) {
          if (this.feedback.length == 0) {
            No_Content()
          } else {
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
        } else {
          Cant_Connect()
        }

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

    UserService.getMineFeedback()
      .then((feedback: FeedbackInfo[]) => {
        console.log('Tags', '获取个人意见反馈记录成功')

        this.feedback = feedback
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人意见反馈记录失败')
        this.ifConnect = false
      })
  }

}