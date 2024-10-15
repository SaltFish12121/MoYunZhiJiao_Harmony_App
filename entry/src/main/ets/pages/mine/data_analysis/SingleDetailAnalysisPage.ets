import { HeaderTitle } from '../../../common/components/CommonComponents'
import router from '@ohos.router'
import UserService from '../../../service/UserService'
import WordAnalysisInfo from '../../../viewmodel/analysis/WordAnalysisInfo'
import ExerciseWordRecordInfo from '../../../viewmodel/analysis/ExerciseWordRecordInfo'

import Echarts from '../../../common/components/Echarts/Echarts'
import { EChartsOption } from '../../../common/components/Echarts/ViewModel'

//单字分析单字细节
@Entry
@Component
struct SingleDetailAnalysisPage {

  @State title: string = '单字分析'

  @State wordAnalysis: WordAnalysisInfo = new WordAnalysisInfo(0,0,[],'','',[],[])
  @State wordId: number = 0
  @State ifCan: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({title: $title })

      //2模板字+平均+占比
      Row({space: 10}){
        Column({space: 5}){
          Text('模板字')

          Column(){
            Image(/*$r('app.media.KaitiChineseStroke_train_000000001548')*/this.wordAnalysis.template)
              .width(120)
              .height(120)

          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width(140)
          .height(140)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid})
        }

        Column({space: 20}){
          Row(){
            Text('平均得分：')

            Text(`${this.wordAnalysis.averageScore}`)
              .fontColor($r('app.color.text_red'))
          }
          .width('100%')
          .height('30%')

          Column({space: 5}){
            Text('评价建议：')
              .width('100%')

            Column(){
              Text(this.wordAnalysis.suggest)
                .fontSize(12)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({left: 10})
            .width(180)
            .padding(10)
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid})

          }
          .height('70%')
          .width('100%')

        }
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .height(140)
        .width('50%')

      }
      .width('90%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({bottom: 20})

      Text('来源练习')
        .width('90%')

      //3练习记录
      if (this.wordAnalysis.record.length == 0) {
        Column(){
          Text('暂无练习')
        }
        .width('95%')
        .margin(10)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

      } else {
        Scroll(){
          Column(){
            Column({space: 10}){

              Column({space: 10}){
                ForEach(
                  this.wordAnalysis.record,
                  (record: ExerciseWordRecordInfo) => {
                    Row(){
                      Column({ space: 5 }){
                        Text(record.title)
                          .textAlign(TextAlign.Center)

                        Text(''+record.time)
                          .textAlign(TextAlign.Center)
                      }
                      .margin({left: 10})
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.Center)

                      Text(record.score+'分')
                        .width('20%')
                        .textAlign(TextAlign.Center)

                    }
                    .height(60)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .width('100%')
                    .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid})
                    .onClick(() => {
                      console.log('Data', record.word)

                      router.pushUrl(
                        {
                          url: "pages/exercise/exercise_detail/ExerciseEachWordPage",
                          params: {
                            ifSuccess: 1,
                            data: record.word
                          }
                        }
                      )
                    })


                  }
                )
              }
              .width('100%')


            }
            .width('95%')

            Column()
              .height(50)
          }

        }
        .align(Alignment.Top)
        .height('90%')
      }



    }
    .width('100%')
    .height('100%')
  }

  async onPageShow(){
    const word = router.getParams() as PARAMS

    if (word != null && word != undefined) {
      this.wordId = word.wordId
    }

    //获取单字分析
    await this.getSingleWordAnalysis()
  }

  //获取单字分析
  async getSingleWordAnalysis(){

    await UserService.getSingleWordAnalysis(this.wordId)
      .then((wordAnalysis: WordAnalysisInfo) => {
        console.log('Tags', '获取单字分析成功')

        this.wordAnalysis = wordAnalysis

        console.log('Result', this.wordAnalysis.id, this.wordAnalysis.score)
      })
      .catch((error: string) => {
        console.log('Tags', '获取单字分析失败')
      })

    // this.lineChart.series[0].data = this.wordAnalysis.score
  }


}

// 声明接受参数的类型
interface PARAMS {
  wordId: number
}