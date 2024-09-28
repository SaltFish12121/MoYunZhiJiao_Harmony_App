import { HeaderTitle } from '../../../common/components/CommonComponents'
import router from '@ohos.router'
import UserService from '../../../service/UserService'
import WordAnalysisInfo from '../../../viewmodel/analysis/WordAnalysisInfo'
import ExerciseWordRecordInfo from '../../../viewmodel/analysis/ExerciseWordRecordInfo'

import Echarts from '../../../common/components/Echarts/Echarts'
import { EChartsOption } from '../../../common/components/Echarts/ViewModel'

@Entry
@Component
struct SingleDetailAnalysisPage {
  //图表配置
  @State option2: string = ``
  //x轴数据
  @State xAxisData2: string[] = [];
  //y轴数据
  @State seriesData2: number[] = [];
  myEchart2: Echarts | null = null;

  /*
 * 设置配置并重新渲染
 */
  setOption2() {
    this.option2 = `{
    title: {
      text: '得分分析'
    },
    grid:{
      left:"15%"
    },
    legend:{
      data: ['得分']
    },
    xAxis: {
      type: 'category',
      data: ${JSON.stringify(this.xAxisData2)}
    },
    yAxis: {
      axisLabel: {
        show: true,
        formatter:(value, index)=> {
            return value + '分';
        }
      }
    },
    series: [
      {
        data: ${JSON.stringify(this.seriesData2)},
        type: 'line',
        name:'得分'
      }
    ]
  }`
    this.myEchart2?.render(this.option2)
  }

  // 组件实例
  chart?: Echarts;

  @State title: string = '单字分析'

  @State wordAnalysis: WordAnalysisInfo = new WordAnalysisInfo(0,0,[],'','',[],[])
  @State wordId: number = 0
  @State ifCan: boolean = false

  build() {
    Column(){
      //1头部
      HeaderTitle({title: $title })

      Scroll(){
        Column(){
          //2模板字+平均+占比
          Row(){
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
          .width('85%')
          .justifyContent(FlexAlign.SpaceBetween)

          //3得分折线图
          Column() {

            // Text('得分分析')
            //   .width('95%')

            if (this.ifCan) {
              //添加折线图组件
              Echarts({
                eHeight: 300,
                renderCallBack: (e: Echarts) => {
                  this.myEchart2 = e
                  this.setOption2()
                }
              })
            }

          }
          .width('100%')
          .height(350)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)
          .margin({top: 30, bottom: 30})

          //4练习记录
          Column({space: 10}){
            Text('练习记录')
              .width('100%')

            Column({space: 10}){
              ForEach(
                this.wordAnalysis.record,
                (record: ExerciseWordRecordInfo) => {
                  Row(){
                    Text(record.title)
                      .width('40%')
                      .textAlign(TextAlign.Center)

                    Text(''+record.time)
                      .width('40%')
                      .textAlign(TextAlign.Center)

                    Text(record.score+'分')
                      .width('20%')
                      .textAlign(TextAlign.Center)

                  }
                  .height(40)
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
      .height('90%')


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

    this.getData2()
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

    this.ifCan = true
  }

  //接口请求获取数据
  getData2() {
    //模拟接口请求
    setTimeout(() => {
      this.xAxisData2 = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      this.seriesData2 = this.wordAnalysis.score
      this.setOption2()
    }, 2000)
  }

}

// 声明接受参数的类型
interface PARAMS {
  wordId: number
}