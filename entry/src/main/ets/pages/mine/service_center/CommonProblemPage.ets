import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import ProblemInfo from '../../../viewmodel/ProblemInfo'

//问题详情
@Entry
@Component
struct CommonProblemPage {

  @State problem: ProblemInfo = new ProblemInfo()
  @State problemList: ProblemInfo[] = []
  @State title: string = ''
  @State arr: number = 0
  @State arrList: number[] = []

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })

      //2 内容
      Column({space: 10}){
        Text('问：' + this.problem.question)
          .fontSize(18)

        Text('答：' + this.problem.content)
          .fontSize(18)

      }
      .margin({ top: 50, bottom: 80})
      .width('95%')

      //3 上一章  下一章
      Row({space: 30}){

        if (this.arr > 1) {
          Button('上一章')
            .fontSize(14)
            .fontColor($r('app.color.blue'))
            .backgroundColor($r('app.color.start_window_background'))
            .border({ width: 1, color: $r('app.color.blue'), radius: 10, style: BorderStyle.Solid })
            .onClick(() => {
              const arr = this.arr-1

              console.log('arr', arr)
              //跳转其他问题详情
              router.replaceUrl(
                {
                  url: 'pages/mine/service_center/CommonProblemPage',
                  params: {
                    problem: this.problemList[arr-1],
                    problemList: this.problemList,
                    arr: arr,
                    arrList: this.arrList
                  }
                }
              )
            })
        }

        if (this.arr < this.arrList[this.problemList.length-1]) {
          Button('下一章')
            .fontSize(14)
            .onClick(() => {
              const arr = this.arr+1

              console.log('arr', arr)
              //跳转其他问题详情
              router.replaceUrl(
                {
                  url: 'pages/mine/service_center/CommonProblemPage',
                  params: {
                    problem: this.problemList[arr-1],
                    problemList: this.problemList,
                    arr: arr,
                    arrList: this.arrList
                  }
                }
              )
            })
        }


      }
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)
      .width('90%')

    }
    .width('100%')
    .height('100%')

  }


  onPageShow(){
    const data = router.getParams() as PARAMS

    this.problem = data.problem
    this.problemList = data.problemList
    this.arr = data.arr
    this.arrList = data.arrList

    this.title = this.problem.title

    console.log('length', this.problemList.length, this.arr, this.arrList)
  }
}

// 声明接受参数的类型
interface PARAMS {
  problem: ProblemInfo
  problemList: ProblemInfo[]
  arr: number
  arrList: number[]
}