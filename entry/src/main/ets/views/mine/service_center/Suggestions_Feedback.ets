import router from '@ohos.router'
import UserService from '../../../service/UserService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Component
export default struct Suggestions_Feedback {

  @State feedback: string = ''
  @State type: string = ''
  @State success: boolean = false

  build() {
    Column(){
      //提交区
      Column(){
        Row(){
          Column(){
            Select([
                { value: '样式建议与反馈', icon: "/common/public_icon.svg" },
                { value: '体验建议与反馈', icon: "/common/public_icon.svg" }
              ])
              .selected(2)
              .value('建议与反馈')
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number, value: string) => {
                console.info('Select:' + index)

                this.type = value
              })
          }


          Column(){
            Text('我的反馈')
              .fontColor($r('app.color.blue'))
          }
          .alignItems(HorizontalAlign.End)
          .onClick(() => {
            router.pushUrl(
              {
                url: 'pages/mine/service_center/MineFeedbackPage'
              }
            )
          })
        }
        .width('95%')
        .justifyContent(FlexAlign.SpaceBetween)



        Column(){
          TextArea({ placeholder: '填写建议与反馈', text: this.feedback })
            .backgroundColor($r('app.color.start_window_background'))
            .onChange((v) => {
              this.feedback = v
            })
        }
        .height(200)

        Column(){
          Stack(){
            Image($r('app.media.juxin'))
              .width(78)
              .height(78)

            Image($r('app.media.add'))
              .height(38)
              .width(38)
          }
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .height(350)
      .backgroundColor($r('app.color.start_window_background'))


      //确定
      Button('确定')
        .margin({top: 20})
        .width('85%')
        .onClick(async (event: ClickEvent) => {
          //能否提交
          if (this.type != '' && this.feedback != '') {
            //提交反馈
            await this.uploadFeedback()

            //是否成功
            console.log( 'success' ,this.success)
            if (this.success) {
              AlertDialog.show({
                message: '提交反馈成功',
                confirm: {
                  value: '确定',
                  action: ()=>{
                  }
                }
              })

              this.feedback = ''
            } else {
              AlertDialog.show({
                message: '提交反馈失败',
                confirm: {
                  value: '确定',
                  action: ()=>{
                  }
                }
              })
            }

          } else {
            AlertDialog.show({
              message: '没有选择建议与反馈',
              confirm: {
                value: '确定',
                action: ()=>{}
              }
            })
          }

        })

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))
  }

  //上传意见反馈
  //反馈可以不登陆提交
  async uploadFeedback(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    userId = 32//测试

    await UserService.uploadFeedback(userId, this.feedback, this.type)
      .then((success) => {
        console.log('Tags', '上传意见反馈成功')

        this.success = success

        console.log('Result', 'ifsuccess', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '上传意见反馈失败')
      })

  }

}