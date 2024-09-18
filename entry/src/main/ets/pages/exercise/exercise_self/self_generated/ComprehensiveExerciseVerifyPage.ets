import router from '@ohos.router'
import { Header } from '../../../../common/components/CommonComponents'
import ExerciseService from '../../../../service/ExerciseService'
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
struct ComprehensiveExerciseVerifyPage {
  @State title: string = ''
  @State content: string = ''
  @State success: boolean = false
  @State typeface: string = ''
  @State composeType: string = ''

  @State sample: ResourceStr = $r('app.media.exercise_test1')

  build() {
    Column(){
      //1头部
      Header()

      Scroll(){
        Column({space: 20}){

          //2内容
          Column({space: 5}){
            Row(){
              Text(/*'练习名称'*/this.title)
                .fontSize(28)
            }
            .width('90%')
            .justifyContent(FlexAlign.Center)

            Row(){
              Text('预览图')
            }
            .width('90%')
            .justifyContent(FlexAlign.Start)

            Column(){
              Image(/*$r('app.media.exercise_test1')*/this.sample)
                .width(350)

            }
            .width(350)
          }
          // .height('75%')
          // .margin({top: 20})

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
              this.createExercise()

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

  async onPageShow(){
    const exercise = router.getParams() as PARAMS

    if (exercise.title != null) {
      this.title = exercise.title
    }

    if (exercise.content != null) {
      this.content = exercise.content
    }

    if (exercise.typeface != null) {
      this.typeface = exercise.typeface
    }

    if (exercise.composeType != null) {
      this.composeType = exercise.composeType
    }

    await this.generateExercise()
  }

  generateExercise(){
    ExerciseService.generateExercise2(this.title, this.content)
      .then((content) => {
        console.log('Tags', '创建练习成功')

        this.sample = content

        console.log('Result', this.sample)
      })
      .catch((error: string) => {
        console.log('Tags', '创建练习失败', error)
      })
  }

  //创建练习
  async createExercise(){
    // let userId = 1
    let userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number

    ExerciseService.createExercise(userId, this.title, this.typeface, this.content)
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
  title: string
  content: string
  typeface: string
  composeType: string
}