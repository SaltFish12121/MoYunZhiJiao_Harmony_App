import router from '@ohos.router'
import ProblemInfo from '../../../viewmodel/ProblemInfo'

@Component
export default struct Common_Problem {

  @Link problem: ProblemInfo[]
  @Link arr: number[]

  build() {
    List(){

      ForEach(this.problem,
        (problem: ProblemInfo, arr: number) => {

          ListItem(){
            Divider()
          }

          ListItem() {
            Row(){
              Text(`【${problem.type}】`)
                .fontSize(20)

              Text(problem.title)
                .width('65%')
                .fontSize(18)

              Blank()

              Image($r('app.media.enter'))
                .width(30)
                .height(30)
            }
            .height(64)
            .width('100%')
            .onClick(() => {
              router.pushUrl(
                {
                  url: 'pages/mine/service_center/CommonProblemPage',
                  params: {
                    problem: problem,
                    problemList: this.problem,
                    arr: this.arr[arr],
                    arrList: this.arr
                  }
                }
              )
            })

          }
          .backgroundColor($r('app.color.start_window_background'))
          .width('100%')
          .height(64)
          /*
          .onClick(() => {
            router.pushUrl(
              {
                url: ''
              }
            )
          })*/


        })

      ListItem(){
        Divider()
      }

      ListItem(){

      }
      .height(100)
    }
    .height('100%')
    .scrollBar(BarState.Off)

    /*
    Scroll(){



    }
    .width('100%')
    .height('100%')*/

  }
}