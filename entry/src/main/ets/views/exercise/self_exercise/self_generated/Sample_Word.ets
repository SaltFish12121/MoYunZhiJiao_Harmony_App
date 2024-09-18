import WordListInfo from '../../../../viewmodel/WordListInfo'
import { Radical } from '../../../../data/Radical'
import ExerciseService from '../../../../service/ExerciseService'

@Extend(Row) function word_card(){
  .justifyContent(FlexAlign.Center)
  .width("100%")
  .height("100")
  .borderRadius(10)
}


class Solution {
  private map: Map<number, number>;

  constructor() {
    this.map = new Map<number, number>();
  }

  processNumber(num: number): void {
    if (this.map.has(num)) {
      this.map.delete(num);
    } else {
      this.map.set(num, 1);
    }
  }

  getNumbers(): number[] {
    return Array.from(this.map.keys());
  }
}



@Component
export default struct Sample_Word {
  @Link selectNumber: number
  @Link sampleWord: WordListInfo[]
  @Link search: string

  @Link radical: Radical
  @Prop typeface: string
  @Prop structure: string

  @State currentBp: string = 'unknown'

  @State color1: ResourceColor = $r('app.color.button1')
  @State color2: ResourceColor = $r('app.color.start_window_background')
  @State color: ResourceColor[] = []

  s = new Solution();

  @Link selectId: number[]

  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据
  @State pageNum: number = 1

  build() {
    Scroll(){

      Column(){

        Column(){

        }
        .height(10)


        GridRow({
          columns: 4,
          gutter: { x: 10, y: 10 },
          breakpoints: { value: ["400vp", "600vp", "800vp"],
            reference: BreakpointsReference.WindowSize },
          direction: GridRowDirection.Row
        }) {

          ForEach(this.sampleWord,
            (sampleWord: WordListInfo, item: number) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

              Row(){
                Row(){
                  Image(/*$r('app.media.KaitiChineseStroke_val_000000000041')*/sampleWord.template)
                    .sourceSize({width: 70, height: 70})
                    .width('80%')
                    .height('80%')
                    .backgroundColor(this.color[item])
                    // .fillColor(this.color[item])
                }
                .backgroundColor(this.color[item])
                .word_card()

              }
              .backgroundColor($r('app.color.start_window_background'))
              .word_card()

            }
            .borderColor($r('app.color.text_gray'))
            // .borderWidth(2)
            .onClick(() => {
              if (this.color[item] != this.color1) {
                this.color[item] = this.color1
                this.selectNumber ++
              } else{
                this.color[item] = this.color2
                this.selectNumber --
              }

              this.s.processNumber(sampleWord.id)

              this.selectId = this.s.getNumbers()
              console.log('select', this.selectId)
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
      .backgroundColor($r('app.color.mid_gray'))


    }
    .width('100%')
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

  //获取样本字
  getSampleWord(){
    console.log('SampleWord', this.search, this.radical.radical, this.structure, this.typeface)

    ExerciseService.getSampleWord(this.search, this.radical.radical, this.structure, this.typeface, this.pageNum)
      .then((sampleWord: WordListInfo[]) => {

        //拼接
        this.sampleWord = this.sampleWord.concat(sampleWord)
        this.isLoading = false
        if(!sampleWord || sampleWord.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)
      })
  }
}

