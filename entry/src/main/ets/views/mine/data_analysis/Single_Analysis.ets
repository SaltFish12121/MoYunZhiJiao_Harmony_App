import router from '@ohos.router'
import WordAnalysisListInfo from  '../../../viewmodel/analysis/WordAnalysisListInfo'
import { Radical } from '../../../data/Radical'
import UserService from '../../../service/UserService'

@Extend(Row) function word_card(){
  .justifyContent(FlexAlign.Center)
  .width("100%")
  .height("100")
  .borderRadius(10)
}

@Component
export default struct Single_Analysis {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6/*, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19*/]
  @Link selectNumber: number
  @Link sampleWord: WordAnalysisListInfo[]
  @Link radical: Radical
  @Link structure: string
  @Link typeface: string
  @Link search: string

  @State currentBp: string = 'unknown'

  @Link pageNum: number
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据


  build() {

    Scroll(){

      Column(){

        Column(){

        }
        .height(10)


        GridRow({
          columns: 2,
          gutter: { x: 10, y: 10 },
          breakpoints: { value: ["400vp", "600vp", "800vp"],
            reference: BreakpointsReference.WindowSize },
          direction: GridRowDirection.Row
        }) {

          ForEach(
            this.sampleWord,
            (sampleWord: WordAnalysisListInfo) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

              Row(){
                Row(){
                  Image(/*$r('app.media.KaitiChineseStroke_val_000000000041')*/sampleWord.template)
                    .sourceSize({width: 70, height: 70})
                    .width(70)
                    .height(70)
                }
                .justifyContent(FlexAlign.Center)
                .width('50%')

                Column(){
                  Column({space: 5}){
                    Text('平均得分率')
                      .fontSize(10)

                    Text(sampleWord.averageScore/*'86'*/+'分')
                      .fontSize(12)
                      .fontColor($r('app.color.tips_red'))
                  }

                  Column({space: 5}){
                    Text('总计练习次数')
                      .fontSize(10)

                    Text(sampleWord.exerciseNumber/*'13'*/+'次')
                      .fontSize(12)
                      .fontColor($r('app.color.tips'))
                  }

                }
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.SpaceAround)
                .height('80%')
                .width('50%')

              }
              .backgroundColor($r('app.color.start_window_background'))
              .word_card()

            }
            .borderColor($r('app.color.text_gray'))
            // .borderWidth(2)
            .onClick(() => {

              router.pushUrl(
                {
                  url: "pages/mine/data_analysis/SingleDetailAnalysisPage",
                  params: {
                    wordId: sampleWord.id
                  }
                }
              )

            })


          })


        }
        .width("95%")
        .onBreakpointChange((breakpoint) => {
          this.currentBp = breakpoint
          // console.log(`this==${this.currentBp}`)
        })


        Column(){

        }
        .height(100)


      }
      .width('100%')
      // .height('100%')
      .backgroundColor($r('app.color.mid_gray'))

    }
    .align(Alignment.TopStart)
    .backgroundColor($r('app.color.mid_gray'))
    .height('100%')
    .width('100%')
    .onReachEnd(() => {
      console.log('触底了！')

      if(!this.isLoading && this.isMore){
        this.isLoading = true
        // 翻页
        this.pageNum++
        this.getSampleWord()
      }
    })


  }

  onPageShow(){
    //获取分析字

  }

  //获取所有字分析列表
  getSampleWord(){
    console.log(this.radical.radical, this.structure, this.typeface)
    UserService.getWordAnalysisList(0, this.search, this.radical.radical, this.structure, this.typeface, this.pageNum)
      .then((sampleWord: WordAnalysisListInfo[]) => {

        this.sampleWord = sampleWord
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)
      })
  }
}