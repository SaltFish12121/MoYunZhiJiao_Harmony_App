import router from '@ohos.router'
import { CommonConstants } from '../../../../common/constants/CommonConstants'
import { Radical } from '../../../../data/Radical'
import Sample_Word from './Sample_Word'
import ExerciseService from '../../../../service/ExerciseService'
import WordListInfo from '../../../../viewmodel/WordListInfo'
import Cant_Connect from '../../../Cant_Connect'

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

@Extend(Row) function row_top(){
  .padding({top: 30, bottom: 35})
  .borderRadius(CommonConstants.DEFAULT_10)
  .width(CommonConstants.THOUSANDTH_940)
  .backgroundColor(Color.White)
  .height(90)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

@Component
export default struct Special_Exercises {
  @State selectNumber: number = 0

  @Link radical: Radical
  @Prop typeface: string
  @Prop structure: string

  @Link sampleWord: WordListInfo[]

  @State selectId: number[] = []
  @State search: string = ''

  @Prop ifConnect: boolean

  build() {


    Column(){

      Column(){
        //1头部搜索
        Row({space: 5}){
          Search()
            .width(280)
            .height(30)
            .onChange((v: string) => {
              this.search = v
            })

          Text('搜索')
            .fontSize(18)
            .fontColor($r('app.color.blue'))
            .onClick(() => {
              this.getTemplateWord()
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

              Row(){
                Text(`${this.radical.radical}`)
                  .textAlign(TextAlign.Center)
                  .fontSize(16)
                  .fontWeight(500)

                Text(`(${this.radical.name})`)
                  .fontSize(12)
                  .fontWeight(500)
              }
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)
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
                  url: 'pages/exercise/exercise_self/NewSelfPage'
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

                this.getTemplateWord()
              })
          }
          .content_formant()

          Row(){
            Select([{ value: '楷书', icon: "/common/public_icon.svg" },
              { value: '行书', icon: "/common/public_icon.svg" },
              { value: '行楷', icon: "/common/public_icon.svg" },
              { value: '草书', icon: "/common/public_icon.svg" }])
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
                this.getTemplateWord()
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
      .height('14%')
      .shadow({
        radius: 6,
        color: "#000000",
        offsetX: 0,
        offsetY: 2,
      })


      Scroll(){
        if (this.ifConnect) {
          //3系统样本字
          Sample_Word({ selectNumber: $selectNumber, sampleWord: $sampleWord, selectId: $selectId, radical: $radical, typeface: this.typeface, structure: this.structure ,search: this.search })
        } else {
          Cant_Connect()
        }

      }
      .width('100%')
      .height('68%')



      Column(){
        // Divider()
        //   .strokeWidth(2)

        //4确认
        Row(){
          Text('确认'+this.selectNumber)
            .fontSize(20)

        }
        .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .height(50)
        .width(150)
        .margin({top: 10})
        .onClick(() => {
          if (this.selectNumber == 0) {
            AlertDialog.show({
              message: '请先选择样本字',
              confirm: {
                value: '确定',
                action: ()=>{
                }
              }
            })
          } else {
            router.pushUrl(
              {
                url: 'pages/exercise/exercise_self/self_generated/SpecialExerciseSelectedPage',
                params:{
                  selectId: this.selectId,
                }
              }
            )
          }

        })

        // Divider()
      }
      .height('10%')
      .justifyContent(FlexAlign.Start)

    }
    .height('100%')
    .width('100%')
  }


  //获取样本字
  getTemplateWord(){
    console.log(this.radical.radical, this.structure, this.typeface)

    ExerciseService.getTemplateWord(this.search, this.radical.radical, this.structure, this.typeface, 1)
      .then((sampleWord: WordListInfo[]) => {

        this.sampleWord = sampleWord
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)
        this.ifConnect = false
      })
  }
}