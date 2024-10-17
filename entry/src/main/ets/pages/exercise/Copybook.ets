import router from '@ohos.router'
import { HeaderTitle } from '../../common/components/CommonComponents'
import SystemTemplateInfo from '../../viewmodel/SystemTemplateInfo'
import { TemplateType } from '../../viewmodel/SystemTemplateInfo'
import ExerciseService from '../../service/ExerciseService'
import CreateExerciseDialog from '../../views/exercise/CreateExerciseDialog'
import PreferencesUtil from '../../common/utils/PreferencesUtil'

//字帖
@Entry
@Component
struct Copybook {
  @State title: string = ''
  @State template: SystemTemplateInfo = new SystemTemplateInfo(0, TemplateType.copybookType, '' ,[])
  @State success: boolean = false
  @State content: string[] = []

  controller: CustomDialogController = new CustomDialogController({
    builder: CreateExerciseDialog({
      confirm: async(e: string): Promise<void> => await this.onConfirm(e)
    })
  })

  async onConfirm(e: string){
    //创建练习
    await this.createExercise(e)

    //是否成功
    if (this.success) {
      router.back()
      router.back()
    } else {
      AlertDialog.show({
        message: '生产练习失败',
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
      //1 头部
      HeaderTitle({ title: $title})


      Column(){
        //2 样例
        Column(){

          Row(){
            Text('样例')

            Text(''+this.template.typeface)

          }
          .width('95%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)


          if (this.content.length != 0) {

            Scroll(){
              Row(){
                ForEach(this.content,
                  (example: string) => {
                    Image(/*$r('app.media.exercise_test1')*/example)
                      .width('90%')
                  }
                )

              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('90%')
          }


        }
        .margin({top: 30})
        .width('90%')


        //3 选择
        Column(){
          Text('选择')
            .fontSize(20)
        }
        .margin({top: 50})
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width(120)
        .height(45)
        .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
        .onClick((event: ClickEvent) => {

          //创建练习
          this.controller.open()

        })

      }
      .height('85%')
      .justifyContent(FlexAlign.SpaceBetween)


    }
    .width('100%')
    .height('100%')

  }

  onPageShow(){
    const exercise = router.getParams() as PARAMS

    if (exercise != null) {
      this.title = exercise.title
      if(this.title != ''){
        this.template = exercise.template
        if (this.template.content != null) {
          this.content = this.template.content
        }
      } else {
        this.title = this.template.title
      }
    }

    console.log('Params', this.template.title, this.template.content)
  }

  //创建练习
  async createExercise(e: string){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await ExerciseService.createExercise(userId, e, this.template.typeface, this.template.content, '已完成')
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
  template: SystemTemplateInfo
}