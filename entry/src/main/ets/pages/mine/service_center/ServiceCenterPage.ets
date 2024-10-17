import { HeaderTitle } from '../../../common/components/CommonComponents'
import Common_Problem from '../../../views/mine/service_center/Common_Problem'
import Suggestions_Feedback from '../../../views/mine/service_center/Suggestions_Feedback'
import InformationService from '../../../service/InformationService'
import ProblemInfo from '../../../viewmodel/ProblemInfo'
import Cant_Connect from '../../../views/Cant_Connect'

//服务中心
@Entry
@Component
struct ServiceCenterPage {
  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  @State arr: number[] = []
  @State problem: ProblemInfo[] = []

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

  @State title: string = '客服中心'
  @State ifConnect: boolean = false

  build() {
    Column(){
      //1 标题+客服
      HeaderTitle({ title: $title })

      //2 导航栏
      Tabs({barPosition: BarPosition.Start}){
        //2.1 常见问题
        TabContent(){
          if (this.ifConnect) {
            Common_Problem({ problem: $problem, arr: $arr })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder('常见问题', 0))

        //2.2 建议与反馈
        TabContent(){
          Suggestions_Feedback()
        }
        .tabBar(this.TabBarBuilder('建议与反馈', 1))

      }
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.mid_gray'))
      .onChange(index => {
        this.currentIndex = index
        this.currentIndex2 = index
      })

    }
    .width('100%')
    .height('100%')

  }

  onPageShow(){
    //获取常见问题
    this.getCommonProblem()
  }

  //获取常见问题
  async getCommonProblem(){

    await InformationService.getCommonProblem()
      .then((problem: ProblemInfo[]) => {
        console.log('Tags', '获取常见问题成功')

        this.problem = problem
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取常见问题失败')
        this.ifConnect = false
      })

    for (let index = 0; index < this.problem.length; index++) {
      this.arr[index] = index+1;
    }
  }

}