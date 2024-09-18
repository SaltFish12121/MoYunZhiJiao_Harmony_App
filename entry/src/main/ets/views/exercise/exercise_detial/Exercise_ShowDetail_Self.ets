import router from '@ohos.router'
import SchoolFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolFinishExerciseDetailInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Component
export default struct Exercise_ShowDetail_Self {

  @Link exercise: SchoolFinishExerciseDetailInfo

  build() {
    //2练习情况
    Column(){
      Row({space: 10}){

        Scroll(){
          Column({space: 10}){
            ForEach(
              this.exercise.submit,
              (submit: SubmitWritingInfo) => {
                Image(/*$r('app.media.exercise_test1')*/submit.submit)
                  .width('100%')
                  .height(250)
                  .onClick(() => {
                    router.pushUrl(
                      {
                        url: 'pages/exercise/exercise_detail/ExerciseDetailPage',
                        params:{
                          submit: submit
                        }
                      }
                    )
                  })
              }
            )

            /*
            Image($r('app.media.exercise_test1'))
              .width('100%')
              .height(250)
              .onClick(() => {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_detail/ExerciseDetailPage'
                  }
                )
              })
            */

          }

        }
        .width('55%')
        .height(250)


        Column({space: 40}){

          Row({space: 10}){
            Text('系统综合评分')
              .fontSize(18)

            Text(/*'90'*/`${this.exercise.score}`)
              .fontSize(18)
              .fontColor($r('app.color.text_red'))
          }
          .width('100%')


          Column({space: 5}){
            Text('系统评语')
              .width('100%')

            Column(){
              Text(/*'总体文章错误少，缺点笔峰不足，部分字连笔'*/this.exercise.systemComment)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(10)
                .fontSize(12)
                .width('95%')
                .margin({top: 15, bottom: 15})
            }
            .width('90%')
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

          }
          .justifyContent(FlexAlign.Center)
          .width('100%')

        }
        .width('40%')
        .height('60%')

      }
      .width('100%')



      Column(){
        Text('点击图片可查看详情')
          .fontSize(14)
      }
      .height(40)
      .width('95%')
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)




    }
    .height(280)
    .width('100%')
  }
}