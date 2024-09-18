import Echarts from '../../../common/components/Echarts/Echarts'
import { EChartsOption } from '../../../common/components/Echarts/ViewModel'
import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'
import ExerciseAnalysisInfo from '../../../viewmodel/analysis/ExerciseAnalysisInfo'
import UserService from '../../../service/UserService'

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
      text: '基础柱状图'
    },
    //图例
    legend: {
      data: ['访问量']
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

  //接口请求获取数据
  getData1() {
    //模拟接口请求
    setTimeout(() => {
      //设置x轴数据
      this.option1.xAxis.data = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      //设置y轴数据
      this.option1.series[0].data = [120, 200, 150, 80, 70, 110, 130]
      //调用render重新渲染
      this.myEchart1?.render(this.option1)
    }, 2000)
  }

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
      text: '基础柱折线图'
    },
    grid:{
      left:"15%"
    },
    legend:{
      data: ['访问量']
    },
    xAxis: {
      type: 'category',
      data: ${JSON.stringify(this.xAxisData2)}
    },
    yAxis: {
      axisLabel: {
        show: true,
        formatter:(value, index)=> {
            return value + '万';
        }
      }
    },
    series: [
      {
        data: ${JSON.stringify(this.seriesData2)},
        type: 'line',
        name:'访问量'
      }
    ]
  }`
    this.myEchart2?.render(this.option2)
  }

  //接口请求获取数据
  getData2() {
    //模拟接口请求
    setTimeout(() => {
      this.xAxisData2 = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
      this.seriesData2 = [120, 200, 150, 80, 70, 110, 130]
      this.setOption2()
    }, 2000)
  }

  // 组件实例
  chart?: Echarts;

  @State title: string = '练字分析'

  @State exerciseAnalysis: ExerciseAnalysisInfo = new ExerciseAnalysisInfo(0, [0], [0], [0])

  @State ifCan : boolean = false

  build() {
    Scroll(){
      Column({space: 30}){

        //1.标题
        HeaderTitle({ title: $title})

        //2.练习频率
        Column() {

          Text('练习次数')
            .width('95%')

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

          Text('练字分析')
            .width('95%')

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

      }
      .width('100%')
    }
    .width('100%')
    .height('100%')

  }


  async aboutToAppear(){
    this.getData1()
    this.getData2()

    //获取练习总体分析
    await this.getExerciseAnalysis()


  }

  //获取练习总体分析
  async getExerciseAnalysis(){
    await UserService.getExerciseAnalysis(1)
      .then((exerciseAnalysis: ExerciseAnalysisInfo) => {
        console.log('Tags', '获取练习总体分析成功')

        this.exerciseAnalysis = exerciseAnalysis

        console.log('Result', this.exerciseAnalysis.id)
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛通知失败', error)
      })


    this.ifCan = true

    // console.log(`${this.frequency}`)
  }
}



/*
import { McBarChart, McLineChart, Options } from '@mcui/mccharts'
import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import WordInfo from '../../../viewmodel/WordInfo'
import ExerciseAnalysisInfo from '../../../viewmodel/analysis/ExerciseAnalysisInfo'
import UserService from '../../../service/UserService'

@Entry
@Component
struct DataAnalysisPage {
  @State title: string = '练字分析'

  //练习次数
  // @State frequency: number[] = [1,2,3,4,5,6,7]

  @State barChart: Options = new Options({
    tooltip: { //设置提示层的相关样式与功能
      axisPointer: { //指示器配置项
        type: 'line', //指示器类型
        lineStyle: { //提示线样式
          color: '#D9D9D9', //线颜色
          width: 2, //线宽度
          type: 'solid' //线类型
        }
      },
      backgroundColor: '#FFFFFF', //提示框背景颜色
      borderColor: '#C4C4C4', //提示框边框颜色
      borderWidth: 1, //提示框边框宽度
      padding: 6, //提示框内边距
      textStyle: { //文本样式配置
        color: '#666666', //字体颜色
        fontSize: 14 //字体大小
      }
    },
    yAxis: {
      axisTick: { //刻度线配置
        length: 6, //刻度的长度
        lineStyle: { //刻度线样式
          color: '#FFFFFF', //线颜色
          width: 1 //线宽度
        }
      },
      axisLine: { //y轴线配置
        show: false //隐藏y轴线
      },
      splitLine: { // Y轴分割线配置。
        show: true, //显示分割线
        lineStyle: { //轴线样式
          color: '#D9D9D9', //线颜色
          width: 1 //线宽度
        }
      },
      axisLabel: { //y轴文本标签样式配置
        color: '#999999', //字体颜色
        fontSize: 28, //字体大小
        fontWeight: '600' //字体粗细
      },
      formatter: function (name) { //文本内容自定义函数
        return name + '次'
      }
    },
    xAxis: {//设置x轴的相关样式与功能
      axisLabel: { //X轴文本标签样式配置
        color: '#999999', //字体颜色
        fontSize: 28, //字体大小
        fontWeight: '600' //字体粗线
      },
      axisTick: { //刻度线配置
        show: true, //控制刻度线显示与隐藏
        length: 6, // 刻度线的长度
        interval: 4, //刻度线与文本的间隔
        lineStyle: { //刻度线样式
          color: '#FFFFFF', //线颜色
          width: 1 //线宽度
        }
      },
      axisLine: { //x轴线配置
        show: true, //控制轴线显示与隐藏 可选值-true显示 false-隐藏
        lineStyle: { //轴线样式
          color: '#D9D9D9', //线颜色
          width: 1, //线宽度
          type: 'solid' //线类型
        }
      },
      formatter: function (name){
        switch (name){
          case '1':
            return '1月'
          case '2':
            return '2月'
          case '3':
            return '3月'
          case '4':
            return '4月'
          case '5':
            return '5月'
          case '6':
            return '6月'
          case '7':
            return '7月'
          case '8':
            return '8月'
          case '9':
            return '9月'
          case '10':
            return '10月'
          case '11':
            return '11月'
          case '12':
            return '12月'
        }
      },
      data: ['1', '2', '3', '4', '5', '6', '7']
    },
    series: [ //设置柱状区的相关样式与功能
      {
        name: "练习次数", //图例文字
        color: '#4783FE', //图例颜色
        stack: '', //是否显示堆叠柱子
        barStyle: { //柱状样式配置
          width: 14, //柱子宽度
          color: '#4783FE', //柱子颜色
          barGap: 1 //同系列之间的柱子间隙
        },
        data: [1,2,3,4,5,6,7], //数据
        label: { //系列文本标签样式配置
          show: true, //显示文本标签样
          color: '#FFFFFF', //字体颜色
          fontWeight: '600', //字体粗细
          fontFamily: 'sans-serif', //字体样式
          position: 'center', //文本显示位置
          fontSize: 22, //字体大小
          formatter: (params) => { //文本内容自定义函数
            return params.name
          },
          distanceToLabelLine: 5 //字体与柱状间距
        }

      }
    ],
    legend: { //设置图例的相关样式与功能
      top: '5%', //图例距离顶部侧位置
      itemWidth: 10, //图形的宽度
      itemHeight: 10, //图形的高度
      textStyle: { //文本样式配置
        color: '#FAAD14', //字体颜色
        fontSize: 30, //字体大小
        fontWeight: '800' //字体粗细
      }
    },

  })

  @State lineChart: Options = new Options({
    tooltip: { //设置提示层的相关样式与功能
      axisPointer: { //指示器配置项
        type: 'line', //指示器类型
        lineStyle: { //提示线样式
          color: '#D9D9D9', //线颜色
          width: 2, //线宽度
          type: 'solid' //线类型
        }
      },
      backgroundColor: '#FFFFFF', //提示框背景颜色
      borderColor: '#C4C4C4', //提示框边框颜色
      borderWidth: 1, //提示框边框宽度
      padding: 6, //提示框内边距
      textStyle: { //文本样式配置
        color: '#666666', //字体颜色
        fontSize: 14 //字体大小
      }
    },
    xAxis: {
      axisLabel: { //X轴文本标签样式配置
        color: '#999999', //字体颜色
        fontSize: 28, //字体大小
        fontWeight: '600' //字体粗线
      },
      axisTick: { //刻度线配置
        show: true, //控制刻度线显示与隐藏
        length: 6, // 刻度线的长度
        interval: 4, //刻度线与文本的间隔
        lineStyle: { //刻度线样式
          color: '#FFFFFF', //线颜色
          width: 1 //线宽度
        }
      },
      axisLine: { //x轴线配置
        show: true, //控制轴线显示与隐藏 可选值-true显示 false-隐藏
        lineStyle: { //轴线样式
          color: '#D9D9D9', //线颜色
          width: 1, //线宽度
          type: 'solid' //线类型
        }
      },
      // data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']

      formatter: function (name){
        switch (name){
          case '1':
            return '周一'
          case '2':
            return '周二'
          case '3':
            return '周三'
          case '4':
            return '周四'
          case '5':
            return '周五'
          case '6':
            return '周六'
          case '7':
            return '周日'
        }
      },
      data: ['1', '2', '3', '4', '5', '6', '7']

    },
    yAxis: {
      axisTick: { //刻度线配置
        length: 6, //刻度的长度
        lineStyle: { //刻度线样式
          color: '#FFFFFF', //线颜色
          width: 1 //线宽度
        }
      },
      axisLine: { //y轴线配置
        show: false //隐藏y轴线
      },
      splitLine: { // Y轴分割线配置。
        show: true, //显示分割线
        lineStyle: { //轴线样式
          color: '#D9D9D9', //线颜色
          width: 1 //线宽度
        }
      },
      axisLabel: { //y轴文本标签样式配置
        color: '#999999', //字体颜色
        fontSize: 28, //字体大小
        fontWeight: '600' //字体粗细
      },
      formatter: function (name) { //文本内容自定义函数
        return name + '分'
      }
    },
    series:[
      {
        name: "学校作业得分", //图例文字
        color: '#FF4D4F', //图例颜色
        lineStyle: { //折线样式配置
          width: 2, //折线宽度
          color: '#FF4D4F' //折线显色
        },
        itemStyle: { //折线拐点配置
          symbol: 'solidCircle', //拐点类型
          symbolSize: 4 //拐点大小
        },
        data: [91, 85, 80, 73, 82, 92, 85] //数据
      },
      {
        name: "自我练习得分", //图例文字
        color: '#52C41A', //图例颜色
        lineStyle: {
          width: 2, //折线宽度
          color: '#52C41A' //折线显色
        },
        itemStyle: { //折线拐点配置
          symbol: 'solidCircle', //拐点类型
          symbolSize: 4 //拐点大小
        },
        data: [73, 80, 83, 85, 84, 92, 92] //数据
      }
    ],
    legend: { //设置图例的相关样式与功能
      top: '5%', //图例距离顶部侧位置
      itemWidth: 10, //图形的宽度
      itemHeight: 10, //图形的高度
      textStyle: { //文本样式配置
        color: '#FAAD14', //字体颜色
        fontSize: 30, //字体大小
        fontWeight: '800' //字体粗细
      }
    },
  })

  @State exerciseAnalysis: ExerciseAnalysisInfo = new ExerciseAnalysisInfo(0, [0], [0], [0])

  @State ifCan : boolean = false

  build() {
    Column({space: 30}){

      //1.标题
      HeaderTitle({ title: $title})

      //2.练习频率
      Column() {

        Text('练习次数')
          .width('95%')

        if (this.ifCan){
          //添加柱状图组件
          McBarChart({ options: this.barChart }).width('100%')
        }

      }
      .width('100%')
      .height(200)
      .backgroundColor('#FFFFFF')
      .borderRadius(10)

      //3.练字分析
      Column() {

        Text('练字分析')
          .width('95%')

        if (this.ifCan){
          //添加折线图组件
          McLineChart({ options: this.lineChart })
        }

      }
      .width('100%')
      .height(200)
      .backgroundColor('#FFFFFF')
      .borderRadius(10)
      .margin({top: 30})

      //4.最好最差的字
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
            url: "pages/mine/data_analysis/SingleAnalysisPage"
          }
        )
      })

    }
    .width('100%')
    .height('100%')

  }

  async aboutToAppear(){
    //获取练习总体分析
    await this.getExerciseAnalysis()


  }

  //获取练习总体分析
  async getExerciseAnalysis(){
    await UserService.getExerciseAnalysis(1)
      .then((exerciseAnalysis: ExerciseAnalysisInfo) => {
        console.log('Tags', '获取练习总体分析成功')

        this.exerciseAnalysis = exerciseAnalysis

        console.log('Result', this.exerciseAnalysis.id)
      })
      .catch((error) => {
        console.log('Tags', '获取竞赛通知失败', error)
      })

    this.barChart.series[0].data = this.exerciseAnalysis.frequency

    this.lineChart.series[0].data = this.exerciseAnalysis.schoolScore
    this.lineChart.series[1].data = this.exerciseAnalysis.selfScore

    this.ifCan = true

    // console.log(`${this.frequency}`)
  }



}

@Component
struct DataWord {
  goodWord: WordInfo

  build() {
    Column({space: 10}){
      Column(){
        Image(this.goodWord.word)
          .sourceSize({ width: 75, height: 75})
          .width(80)
          .height(80)
      }
      .border({ width: 1, color: $r('app.color.text_gray'), radius: 0, style: BorderStyle.Solid })


      Text(this.goodWord.strokeNumber+'分')
        .fontSize(22)
        .fontColor($r('app.color.text_red'))
    }
  }
}
*/