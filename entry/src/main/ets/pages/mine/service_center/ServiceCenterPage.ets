import { HeaderTitle, HeaderTitleService } from '../../../common/components/CommonComponents'
import Common_Problem from '../../../views/mine/service_center/Common_Problem'
import Suggestions_Feedback from '../../../views/mine/service_center/Suggestions_Feedback'
import InformationService from '../../../service/InformationService'
import ProblemInfo from '../../../viewmodel/ProblemInfo'
import Cant_Connect from '../../../views/Cant_Connect'

@Entry
@Component
struct ServiceCenterPage {

  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  @State arr: number[] = []
  @State problem: ProblemInfo[] = [
    /*
    new ProblemInfo(0,'登录', '忘记密码该怎么办', ''),
    new ProblemInfo(0,'登录', '验证码错误怎么办', ''),
    new ProblemInfo(0,'登录', '可以多设备同时登录吗', ''),
    new ProblemInfo(0,'登录', '如何登录绑定学校的账户', ''),
    new ProblemInfo(0,'登录', '忘记学校账户的密码怎么办', ''),
    new ProblemInfo(0,'练习', '看不到自己班级发布的练习怎么办', ''),
    new ProblemInfo(0,'练习', '没有绑定班级，还能看到班级练习吗', ''),
    new ProblemInfo(0,'竞赛', '为什么有些竞赛报名不了', ''),
    new ProblemInfo(0,'竞赛', '竞赛报名成功在哪查看', ''),
    new ProblemInfo(0,'竞赛', '竞赛考试中途能退出吗', ''),
    new ProblemInfo(0,'科普', '视频收藏后能在哪里看到', ''),
    new ProblemInfo(0,'科普', '知识科普的搜素怎么用', ''),
    */
  ]

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

  @State title: string = '单字分析'
  @State ifConnect: boolean = false

  build() {
    Column(){
      //1标题+客服
      HeaderTitle({ title: $title })

      //2导航栏
      Tabs({barPosition: BarPosition.Start}){
        //1.常见问题
        TabContent(){
          // Text('常见问题')
          if (this.ifConnect) {
            Common_Problem({ problem: $problem, arr: $arr })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder('常见问题', 0))

        //2.建议与反馈
        TabContent(){
          // Text('建议与反馈')
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