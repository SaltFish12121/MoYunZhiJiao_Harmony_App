import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import ExerciseService from '../../../../service/ExerciseService'
import CreateExerciseDialog from '../../../../views/exercise/CreateExerciseDialog'
import WordListInfo from '../../../../viewmodel/WordListInfo'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Extend(Column) function Select_colum(){
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
  .width(120)
  .height(50)
  .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

}

@Entry
@Component
struct SpecialPreviewPage {
  @State title: string = '生成字帖'
  @State success: boolean = false
  @State typeface: string = ''
  @State content: ResourceStr = $r('app.media.exercise_test1')

  @State selectWord: WordListInfo[] = []

  controller: CustomDialogController = new CustomDialogController({
    builder: CreateExerciseDialog({
      confirm: (e: string): void => this.onConfirm(e)
    })
  })

  onConfirm(e: string){
    //创建练习
    this.createExercise(e)

    //是否成功
    if (this.success) {
      router.back()
      router.back()
    } else {
      AlertDialog.show({
        message: '生成练习失败',
        confirm: {
          value: '确定',
          action: ()=>{
          }
        }
      })
    }
  }

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title})

      Scroll(){
        Column({space: 20}){

          //2内容
          Column({space: 10}){
            Row(){
              Text('预览图')
            }
            .width('90%')
            .justifyContent(FlexAlign.Start)


            Column(){
              Image(/*$r('app.media.exercise_test1')*/this.content)
                .width(350)

            }
            .width(350)

          }
          // .height('75%')
          // .margin({top: 40})

          //3按钮
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
              Text('生成')
                .fontSize(28)
            }
            .Select_colum()
            .onClick(() => {
              //创建练习
              this.controller.open()
            })

          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('80%')


          Column()
            .height(50)

        }
        .width('100%')
        // .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)



  }

  async onPageShow() {
    const param = router.getParams() as PARAMS

    this.selectWord = param.selectWord

    await this.generateExercise()
  }


  generateExercise(){
    ExerciseService.generateExercise(this.selectWord)
      .then((content) => {
        console.log('Tags', '创建练习预览图成功')

        this.content = content

        console.log('Result', this.content)
      })
      .catch((error: string) => {
        console.log('Tags', '创建练习预览图失败', error)
      })
  }

  //创建练习
  async createExercise(e: string){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number

    ExerciseService.createExercise(userId, e, this.typeface, this.content)
      .then((success) => {
        console.log('Tags', '创建练习成功')

        this.success = success

        console.log('Result', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '创建练习失败', error)
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  selectWord: WordListInfo[]
}