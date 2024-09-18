import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import CopybookInfo from  '../../../viewmodel/CopybookInfo'
import ExerciseService from '../../../service/ExerciseService'
import CreateExerciseDialog from '../../../views/exercise/CreateExerciseDialog'

@Entry
@Component
struct ExpertCopywritingPage {
  @State copybook: CopybookInfo = new CopybookInfo(0, '沁园春', '毛泽东', '')
  @State title: string = '专家字帖'
  @State success: boolean = false

  // @State content: ResourceStr = $r("app.media.expertCopy1")

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
      //1头
      HeaderTitle({ title: $title })

      Scroll(){
        Column(){


          Column({space: 10}){
            //2内容
            Column({space: 20}){
              Text(`《${this.copybook.title}》`)
                .fontSize(20)
                .width('100%')
                .textAlign(TextAlign.Center)


              Stack({ alignContent: Alignment.Center }){
                Text(/*'作者'*/this.copybook.author)

                Text(/*'字体'*/this.copybook.typeface)
                  .width('80%')
                  .textAlign(TextAlign.End)
              }
              .width('100%')


              Image(/*$r("app.media.expertCopy1")*/this.copybook.content)
                .width('90%')
            }
            .width('100%')

            //3是否生成
            Row(){
              Column(){
                Text('取消')
                  .fontSize(28)

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
              .width(130)
              .height(52)
              .onClick(() => {
                router.back()
              })


              Column(){
                Text('生成')
                  .fontSize(28)

              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })
              .width(130)
              .height(52)
              .onClick(() => {
                //创建练习
                this.controller.open()
              })


            }
            .width('80%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({top: 20})

            Column()
              .height(50)
          }
          // .height('80%')
          .justifyContent(FlexAlign.SpaceBetween)

        }
        .width('100%')
        // .height('100%')
      }
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)


  }

  onPageShow(){
    const copybook = router.getParams() as PARAMS

    this.copybook = copybook.data
  }


  //创建练习
  createExercise(e: string){
    ExerciseService.createExercise(1, e, this.copybook.typeface, this.copybook.content)
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
  data: CopybookInfo
}
