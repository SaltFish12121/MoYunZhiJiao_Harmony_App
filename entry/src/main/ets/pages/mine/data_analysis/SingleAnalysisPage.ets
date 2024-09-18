import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import Single_Analysis from '../../../views/mine/data_analysis/Single_Analysis'
import ExerciseService from '../../../service/ExerciseService'
import UserService from '../../../service/UserService'
import { Radical } from '../../../data/Radical'
import WordAnalysisListInfo from  '../../../viewmodel/analysis/WordAnalysisListInfo'

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

@Entry
@Component
struct SingleAnalysisPage {
  @State radical: Radical = new Radical(0, '', '')
  @State structure: string = '左右结构'
  @State typeface: string = '楷书'
  @State search: string = ''

  @State pageNum: number = 1

  @State selectNumber: number = 0

  @State title: string = '单字分析'
  @State sampleWord: WordAnalysisListInfo[] = []

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })

      //2头部筛选
      Column({space: 10}){
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
              //获取所有字分析列表
              this.getSampleWord()
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

                this.getSampleWord()
              })
          }
          .content_formant()

          Row(){
            Select([{ value: '楷书', icon: "/common/public_icon.svg" },
            /*{ value: '行书', icon: "/common/public_icon.svg" },
            { value: '行楷', icon: "/common/public_icon.svg" },
            { value: '草书', icon: "/common/public_icon.svg" }*/])
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
                this.getSampleWord()
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

      //3练习的样本字
      Scroll(){
        Single_Analysis({ selectNumber: $selectNumber, radical: $radical, sampleWord: $sampleWord, typeface: $typeface, structure: $structure, search: $search, pageNum: $pageNum })
      }
      .width('100%')
      .height('74%')


    }
    .width('100%')
    .height('100%')

  }

  onPageShow(){
    const radical = router.getParams() as PARAMS

    if (radical != null && radical.success) {
      this.radical = radical.radical
    }

    console.log(`${this.radical.id}`, this.radical.radical, this.radical.name)

    //获取所有字分析列表
    this.getSampleWord()
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

// 声明接受参数的类型
interface PARAMS {
  success: boolean
  radical: Radical
}