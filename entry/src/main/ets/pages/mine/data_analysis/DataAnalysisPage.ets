import { HeaderTitle } from '../../../common/components/CommonComponents'
import ExerciseAnalysisInfo from '../../../viewmodel/analysis/ExerciseAnalysisInfo'
import UserService from '../../../service/UserService'
import Exercise_Analysis from '../../../views/mine/data_analysis/Exercise_Analysis'
import Single_Analysis from '../../../views/mine/data_analysis/Single_Analysis'

//数据分析
@Entry
@Component
struct DataAnalysisPage {
  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor2(index))
    }
    .border({ width: 1 ,color: $r('app.color.blue')})
    .width('80%')
    .height(29)
    .backgroundColor(this.selectColor1(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor1(index: number){
    return this.currentIndex === index ? $r('app.color.blue') : $r('app.color.start_window_background')
  }

  selectColor2(index: number){
    return this.currentIndex2 === index ? $r('app.color.start_window_background') : $r('app.color.blue')
  }


  @State title: string = '练字分析'

  @State exerciseAnalysis: ExerciseAnalysisInfo[] = []
  @State year: string = new Date().getFullYear().toString()+'年'
  @State month: string = (new Date().getMonth()+1).toString()+'月'

  @State ifConnect: boolean = false


  build() {
    Column(){
      //1 标题
      HeaderTitle({ title: $title})

      //2 分类：练习分析，单字分析
      Tabs({barPosition: BarPosition.Start}){
        //2.1 练习分析
        TabContent(){
          Exercise_Analysis({ exerciseAnalysis: $exerciseAnalysis, year: $year, month: $month })
        }
        .tabBar(this.TabBarBuilder('练习分析', 0))

        //2.2 单字分析
        TabContent(){
          Single_Analysis()
        }
        .tabBar(this.TabBarBuilder('单字分析', 1))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
        this.currentIndex2 = index
      })

    }
    .width('100%')
    .height('100%')

  }


  async onPageShow(){

    //获取练习总体分析
    await this.getExerciseAnalysis()

  }



  //获取练习总体分析
  async getExerciseAnalysis(){
    console.log('Date', this.year, this.month)
    await UserService.getExerciseAnalysis(this.year, this.month)
      .then((exerciseAnalysis: ExerciseAnalysisInfo[]) => {
        console.log('Tags', '获取练习总体分析成功')

        this.exerciseAnalysis = exerciseAnalysis

        console.log('Result', this.exerciseAnalysis[0].id)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取练习总体分析失败', error)
        this.ifConnect = false
      })

  }

}
