import Echarts from '../../../common/components/Echarts/Echarts'
import { EChartsOption } from '../../../common/components/Echarts/ViewModel'
import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'
import ExerciseAnalysisInfo from '../../../viewmodel/analysis/ExerciseAnalysisInfo'
import UserService from '../../../service/UserService'
import Cant_Connect from '../../../views/Cant_Connect'

@Entry
@Component
struct DataAnalysisPage {
  //图表实例
  myEchart1: Echarts | null = null
  /*
   * 图表配置
   */
  option1: EChartsOption = {
    //标题
    title: {
      text: '练习次数'
    },
    //图例
    legend: {
      data: ['次数']
    },
    //x轴配置
    xAxis: {
      type: 'category',
      data: []
    },
    //y轴配置
    yAxis: {
      type: 'value'
    },
    //数据配置
    series: [
      {
        data: [],
        type: 'bar',//柱状图
        name: '访问量'
      }
    ]
  };


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
      text: '每天练习均分'
    },
    grid:{
      left:"15%"
    },
    legend:{
      data: ['平均分']
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
        name:'平均分'
      }
    ]
  }`
    this.myEchart2?.render(this.option2)
  }


  // 组件实例
  chart?: Echarts;

  @State title: string = '练字分析'

  @State exerciseAnalysis: ExerciseAnalysisInfo = new ExerciseAnalysisInfo(0, [0], [0])

  @State ifCan : boolean = false
  @State ifConnect: boolean = false

  build() {
    Scroll(){
      Column({space: 30}){

        //1.标题
        HeaderTitle({ title: $title})

        if (this.ifConnect) {
          //2.练习频率
          Column() {

            // Text('练习次数')
            //   .width('95%')

            if (this.ifCan){
              //柱状图
              Echarts({
                eHeight: 300,
                //回调
                renderCallBack: (e: Echarts) => {
                  this.myEchart1 = e
                  //初次渲染组件，接口获取数据是异步此时this.option可能还没有新数据
                  this.myEchart1.render(this.option1)
                }
              })
            }

          }
          .width('100%')
          .height(350)
          .backgroundColor('#FFFFFF')
          .borderRadius(10)

          //3.练字分析
          Column() {

            // Text('练字分析')
            //   .width('95%')

            if (this.ifCan){
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
          .margin({top: 30})

          //4.单字分析
          Row(){
            Text('单字分析')

            Image($r('app.media.enter'))
              .width(20)
          }
          .margin({top: 30})
          .padding(10)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('90%')
          .height(80)
          .border({ width: 1, color: $r('app.color.light_black'), radius: 10, style: BorderStyle.Solid })
          .shadow({
            radius: 4,
            color: "#000000",
            offsetX: 0,
            offsetY: 2,
          })
          .onClick(() => {
            router.pushUrl(
              {
                url: "pages/mine/data_analysis/SingleAnalysisPage",
                params: {
                  success: false
                }
              }
            )
          })

          Column()
            .height(50)
        } else {
          Cant_Connect()
        }


      }
      .width('100%')
    }
    .width('100%')
    .height('100%')

  }


  async aboutToAppear(){
    //获取练习总体分析
    await this.getExerciseAnalysis()

    this.getData1()
    this.getData2()
  }


  //接口请求获取数据
  getData1() {
    //模拟接口请求
    setTimeout(() => {
      //设置x轴数据
      this.option1.xAxis.data = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      //设置y轴数据
      this.option1.series[0].data = this.exerciseAnalysis.frequency /*[120, 200, 150, 80, 70, 110, 130]*/
      //调用render重新渲染
      this.myEchart1?.render(this.option1)
    }, 2000)
  }


  //接口请求获取数据
  getData2() {
    //模拟接口请求
    setTimeout(() => {
      this.xAxisData2 = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      this.seriesData2 = this.exerciseAnalysis.score /*[120, 200, 150, 80, 70, 110, 130]*/
      this.setOption2()
    }, 2000)
  }

  //获取练习总体分析
  async getExerciseAnalysis(){
    await UserService.getExerciseAnalysis()
      .then((exerciseAnalysis: ExerciseAnalysisInfo) => {
        console.log('Tags', '获取练习总体分析成功')

        this.exerciseAnalysis = exerciseAnalysis

        console.log('Result', this.exerciseAnalysis.id)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛通知失败', error)
        this.ifConnect = false
      })


    this.ifCan = true

    // console.log(`${this.frequency}`)
  }
}
