import CompetitionDetailInfo from '../../../viewmodel/CompetitionDetailInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'
import router from '@ohos.router'

@Component
export default struct Competition_ShowDetail_Finish {

  @Link competitionContent: CompetitionDetailInfo

  build() {
    //2练习情况
    Column(){
      Row({space: 10}){

        Scroll(){
          Column({space: 10}){
            ForEach(
              this.competitionContent.submit,
              (submit: SubmitWritingInfo) => {
                Image(/*$r('app.media.exercise_test1')*/submit.submit)
                  .width('100%')
                  .height(250)
                  .onClick(() => {
                    router.pushUrl(
                      {
                        url: 'pages/exercise/exercise_detail/ExerciseDetailPage',
                        params: {
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


        Column({space: 25}){

          Row({space: 10}){
            Text('系统综合评分')
              .fontSize(16)

            Text(/*'90'*/`${this.competitionContent.score}`)
              .fontSize(16)
              .fontColor($r('app.color.text_red'))
          }
          .width('100%')

          Row({space: 10}){
            Text('排名')
              .fontSize(16)

            Text('第'+/*'180'*/`${this.competitionContent.rank}`+'名')
              .fontSize(16)
              .fontColor($r('app.color.text_red'))

          }
          .width('100%')


          Row({space: 10}){
            Text('所得奖项')
              .fontSize(16)

            Text(/*'无'*/this.competitionContent.award)
              .fontSize(16)
              .fontColor($r('app.color.text_red'))

          }
          .width('100%')


          Column({space: 5}){
            Text('评语')
              .width('100%')

            Column(){
              Text(/*'评语内容'*/this.competitionContent.comment)
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
        .height('80%')

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

  aboutToAppear(){
    console.log('Detail Appear')
  }

}