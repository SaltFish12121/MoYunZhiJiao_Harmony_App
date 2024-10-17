import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import ExerciseService from '../../../../service/ExerciseService'
import WordListInfo from '../../../../viewmodel/WordListInfo'

@Extend(Column) function Select_colum(){
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .width(120)
  .height(50)
  .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

}

@Extend(Row) function word_card(){
  .justifyContent(FlexAlign.Center)
  .width("100%")
  .height("100")
  .border({ width: 1, color: $r('app.color.button2'), radius: 10, style: BorderStyle.Solid })
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 2,
    offsetY: 4,
  })
}

//专项所选字检查
@Entry
@Component
struct SpecialExerciseSelectedPage {
  @State currentBp: string = 'unknown'

  @State ifEdit: boolean = false

  @State title: string = '检查所选字'
  @State typeface: string = ''

  @State selectId: number[] = []
  @State selectWord: WordListInfo[] = []
  selectNumber: number = 0

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })

      //2 内容
      Column({space: 15}){
        //2.1 提示
        Row(){
          Text('所选样例字')

          if (!this.ifEdit) {
            Text('编辑')
              .onClick(() => {
                this.ifEdit = !this.ifEdit
              })
          } else {
            Text('完成')
              .onClick(() => {
                this.ifEdit = !this.ifEdit
              })
          }

        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')


        //2.2 选的字
        GridRow({
          columns: 4,
          gutter: { x: 5, y: 10 },
          breakpoints: { value: ["400vp", "600vp", "800vp"],
            reference: BreakpointsReference.WindowSize },
          direction: GridRowDirection.Row
        }) {

          ForEach(
            this.selectWord,
            (selectWord: WordListInfo) => {
            GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {


              if (this.ifEdit) {
                //编辑

                Row() {
                  Stack({alignContent: Alignment.TopEnd}){

                    Row() {
                      Image(selectWord.template)
                        .sourceSize({width: 70, height: 70})
                        .width('80%')
                        .height('80%')

                    }
                    .word_card()


                    Row(){
                      Image($r('app.media.delete'))
                    }
                    .margin({ top: -5, right: -5})
                    .width(20)
                    .height(20)

                  }
                  .onClick(() => {

                    console.log('onclick')

                    this.selectWord = this.selectWord.filter((index) => index != selectWord)
                    this.selectNumber--
                  })

                }

              } else {
                //未编辑

                Row() {
                  Image(selectWord.template)
                    .sourceSize({width: 70, height: 70})
                    .width('80%')
                    .height('80%')

                }
                .word_card()


              }


            }

          })
        }


      }
      .margin({top: 50})
      .height('75%')
      .width('90%')


      //3 按钮
      Row(){
        Column(){
          Text('取消')
            .fontSize(28)
        }
        .Select_colum()
        .onClick(() => {
          router.back()
        })

        Column(){
          Text('下一步')
            .fontSize(28)
        }
        .Select_colum()
        .onClick(() => {
          if (this.selectNumber == 0) {
            AlertDialog.show({
              message: '所选字不能为空',
              confirm: {
                value: '确定',
                action: ()=>{
                }
              }
            })
          } else {
            router.pushUrl(
              {
                url: 'pages/exercise/exercise_self/self_generated/SpecialPreviewPage',
                params:{
                  selectWord: this.selectWord,
                  typeface: this.typeface
                }
              }
            )
          }

        })


      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('80%')


    }
    .width('100%')
    .height('100%')

  }

  async onPageShow(){
    const param = router.getParams() as PARAMS
    this.selectId = param.selectId
    this.typeface = this.typeface

    for (let index = 0; index < this.selectId.length; index++) {
      await this.getSelectWord(this.selectId[index])
    }

    this.selectNumber = this.selectId.length
  }


  //获取选取的字
  async getSelectWord(id: number){
    await ExerciseService.getSelectWord(id)
      .then((word: WordListInfo) => {
        this.selectWord[this.selectWord.length] = word
      })
      .catch((error: string) => {
        console.log('Tags', '获取选取的字', error)
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  selectId: number[]
  typeface: string
}