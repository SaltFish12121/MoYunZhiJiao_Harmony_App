import router from '@ohos.router'
import WordAnalysisListInfo from  '../../../viewmodel/analysis/WordAnalysisListInfo'
import { Radical } from '../../../data/Radical'
import UserService from '../../../service/UserService'
import ExerciseService from '../../../service/ExerciseService'
import Cant_Connect from '../../Cant_Connect'

@Extend(Row) function word_card(){
  .justifyContent(FlexAlign.Center)
  .width("100%")
  .height("100")
  .borderRadius(10)
}

@Extend(Row) function content_formant(){
  // .padding({top: 30, bottom: 35})
  // .borderRadius(CommonConstants.DEFAULT_10)
  // .width(CommonConstants.THOUSANDTH_940)
  .backgroundColor(Color.White)
  // .height(90)
  .shadow({
    radius: 6,
    color: "#000000",
    // offsetX: 0,
    // offsetY: 2,
  })
}

@Component
export default struct Single_Analysis {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6/*, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19*/]
  @State selectNumber: number = 0
  @State sampleWord: WordAnalysisListInfo[] = []
  @State radical: Radical = new Radical(0, '', '')
  @State structure: string = ''
  @State typeface: string = ''
  @State search: string = ''

  scroller: Scroller = new Scroller()

  @State currentBp: string = 'unknown'

  @State isMore: boolean = true//是否有更多数据
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载

  @State font: SelectOption[] = []
  @State ifConnect: boolean = false

  build() {
    Column(){
      //1头部筛选
      Column(){
        //1头部搜索
        Row({space: 5}){
          Search()
            .width(280)
            .height(35)
            .onChange((v: string) => {
              this.search = v
            })

          Text('搜索')
            .fontSize(18)
            .fontColor($r('app.color.blue'))
            .onClick(() => {
              this.pageNum = 1
              this.isMore = true
              //获取所有字分析列表
              this.getWordAnalysisList()

              // 点击后回到顶部
              this.scroller.scrollEdge(Edge.Top)
            })
        }
        .justifyContent(FlexAlign.Center)
        .width('95%')

        //2分类选择
        Row(){
          Row(){

            if (this.radical.id == 0){

              Text(`偏旁部首`)
                .textAlign(TextAlign.Center)
                .fontSize(16)
                .fontWeight(500)
                .width(80)
                .height(40)

            } else {

              Text(`${this.radical.radical}`)
                .textAlign(TextAlign.Center)
                .fontSize(16)
                .fontWeight(500)
                .width(80)
                .height(40)
            }

            Image($r('app.media.enter'))
              .width(20)
              .margin({top: 5})
          }
          .width(100)
          .content_formant()
          .onClick(() => {
            console.log(`detail:${this.radical.radical}`)

            router.pushUrl(
              {
                url: 'pages/exercise/exercise_self/RadicalSearchPage',
                params: {
                  url: 'pages/mine/data_analysis/SingleAnalysisPage',
                }
              }
            )
          })

          Row(){
            Select([
              { value: '上三包围结构', icon: "/common/public_icon.svg" },
              { value: '上下结构', icon: "/common/public_icon.svg" },
              { value: '上中下结构', icon: "/common/public_icon.svg" },
              { value: '下三包围结构', icon: "/common/public_icon.svg" },
              { value: '全包围结构', icon: "/common/public_icon.svg" },
              { value: '右上包围结构', icon: "/common/public_icon.svg" },
              { value: '品字形结构', icon: "/common/public_icon.svg" },
              { value: '左三包围结构', icon: "/common/public_icon.svg" },
              { value: '左上包围结构', icon: "/common/public_icon.svg" },
              { value: '左下包围结构', icon: "/common/public_icon.svg" },
              { value: '左中右结构', icon: "/common/public_icon.svg" },
              { value: '左右结构', icon: "/common/public_icon.svg" }
            ])
              .selected(0)
              .value('字体结构')
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
              .backgroundColor($r('app.color.start_window_background'))
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number, v: string) => {
                console.info('Select:' + index)
                this.structure = v

                this.getWordAnalysisList()
              })
          }
          .content_formant()

          Row(){
            Select(this.font)
              .selected(0)
              .value('字体')
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
              .backgroundColor($r('app.color.start_window_background'))
              .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number, value: string) => {
                console.info('Select:' + index)

                this.typeface = value
                this.getWordAnalysisList()
              })
          }
          .content_formant()
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        Column(){

        }
        .height(10)

      }
      .height('16%')
      .shadow({
        radius: 10,
        color: "#000000",
        offsetX: 10,
        offsetY: 2,
      })

      //2内容列表
      if (this.ifConnect) {
        List(){

          ListItem()
            .height(10)

          ListItem(){
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
          }

          ListItem()
            .height(100)


        }
        .margin({ top: 5})
        .width('100%')
        .backgroundColor($r('app.color.mid_gray'))
        .height('80%')
        .onReachStart(() => {
          console.log('触顶！', this.pageNum, this.isLoading, this.isMore)
          this.pageNum = 1
          this.isMore = true
          this.isLoading = true
          this.getWordAnalysisList0()
        })
        .onReachEnd(() => {
          console.log('触底了！', this.pageNum, this.isLoading, this.isMore)

          if(!this.isLoading && this.isMore){
            this.isLoading = true
            // 翻页
            this.pageNum++
            this.getWordAnalysisList()
          }
        })


      } else {
        Cant_Connect()
      }

    }
    .width('100%')
    .height('100%')
  }

  async aboutToAppear() {
    await this.getFont()
  }


  //获取所有字分析列表
  getWordAnalysisList0(){
    console.log(this.radical.radical, this.structure, this.typeface)
    UserService.getWordAnalysisList(this.search, this.radical.radical, this.structure, this.typeface, this.pageNum)
      .then((sampleWord: WordAnalysisListInfo[]) => {

        this.sampleWord = sampleWord

        this.ifConnect = true
        this.isLoading = false
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)

        this.ifConnect = false
      })
  }

  //获取所有字分析列表
  getWordAnalysisList(){
    console.log(this.radical.radical, this.structure, this.typeface)
    UserService.getWordAnalysisList(this.search, this.radical.radical, this.structure, this.typeface, this.pageNum)
      .then((sampleWord: WordAnalysisListInfo[]) => {

        //拼接
        this.sampleWord = this.sampleWord.concat(sampleWord)
        this.isLoading = false
        if(!sampleWord || sampleWord.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        this.isLoading = false
        console.log('Tags', '获取样本字', error)
      })
  }

  //获取字体
  getFont(){
    ExerciseService.getFont()
      .then((font: string[]) => {

        this.font = font.map((typeface: string, index: number) => ({
          value: typeface,
          icon: "/common/public_icon.svg"
        } as SelectOption));

        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取字体', error)
        this.ifConnect = false
      })
  }
}