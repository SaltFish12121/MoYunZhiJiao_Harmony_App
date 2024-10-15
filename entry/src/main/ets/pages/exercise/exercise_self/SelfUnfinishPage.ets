import router from '@ohos.router'
import {  HeaderTitle } from '../../../common/components/CommonComponents'
import Exercise_Top_Self from '../../../views/exercise/exercise_detial/Exercise_Top_Self'
// import Exercise_Upload from '../../../views/exercise/exercise_detial/Exercise_Upload'
import SelfUnfinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SelfUnfinishExerciseDetailInfo'
import ExerciseService from '../../../service/ExerciseService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'
import Cant_Connect from '../../../views/Cant_Connect'
import { imageUploadModule } from '../../../model/ImageUploadModule'

@Entry
@Component
struct SelfUnfinishPage {

  @State title: string = '基础笔画练习'
  @State ifCollect: boolean = false

  @State uerId: number = 0
  @State exerciseId: number = 0
  @State selfUnfinish: SelfUnfinishExerciseDetailInfo = new SelfUnfinishExerciseDetailInfo(0, '笔画练习（一）', false,
    '行书',
    '际传存论青常照采照再八算何机话元。', ['https://dummyimage.com/120x240'],
    [
      /*'https://dummyimage.com/120x240'*/
    ])

  @State ifConnect: boolean = false
  @State ifUpload: boolean = false
  // @State content: ResourceStr[] = []

  @State selectedPaths: string[] | null = null
  @State filesPaths: string[] = []


  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitle({ title: $title })

        if (this.ifConnect) {
          //2 内容
          Exercise_Top_Self({ selfExercise: $selfUnfinish })

          //3上传作品
          // Exercise_Upload({ exerciseId: this.exerciseId, content: this.content })
          Column({space: 10}){

            Text('上传作品')
              .width('100%')

            if (this.filesPaths.length != 0) {
              List(){
                ListItem().height(20)

                ForEach(
                  this.filesPaths,
                  (filesPaths: string) => {
                    ListItem(){
                      Image(filesPaths) // 使用 URI 显示图片
                        .width(250)
                        .height(300)
                        .margin({ top: '10' })
                    }
                  }
                )
              }
              .width('90%')
              .height(177)
            }

            Row(){

              Row({space: 10}){
                Image($r('app.media.camera'))
                  .width(20)
                  .margin({left: 8})

                Text('上传图片')
              }
              .width(110)
              .height(32)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 5, style: BorderStyle.Solid })
              .onClick(async () => {
                try {
                  // 选择图片
                  const selectedPaths = await imageUploadModule.pickerAvatar(5);
                  console.log('ImageFile', '选择的图片路径:', selectedPaths);
                  this.selectedPaths = selectedPaths;
                  this.filesPaths = selectedPaths

                  console.log('ImageFile', 'filesPaths', this.filesPaths);

                } catch (error) {
                  console.error('ImageFile', '选择或上传图片出错:', error);
                }

              })

            }
            .margin({top: 30})
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Center)

          }
          .width('90%')
          .margin({top: 30, bottom: 60})


          //4关闭
          Row({space: 20}){
            // 1关闭
            Column(){
              Text('关闭')
                .fontSize(20)
                .onClick((event: ClickEvent) => {
                  router.back()
                })
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .width(120)
            .height(45)
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })


            // 2提交
            if (true) {
              Column(){
                Text('提交')
                  .fontSize(20)
                  .onClick(async () => {

                    console.log('ImageFile', 'filesPaths', this.filesPaths, this.exerciseId)

                    try {
                      // 上传图片
                      const uploadedPaths = await imageUploadModule.prepareUpload(`/ExerciseService/uploadExercise/${this.exerciseId}`, "image", this.filesPaths);
                      console.log('ImageFile', '上传的图片路径:', uploadedPaths);

                      // 上传成功
                      AlertDialog.show({
                        message: '提交成功',
                        confirm: {
                          value: '确定',
                          action: ()=>{
                            router.back()
                          }
                        }
                      })

                    } catch (error) {
                      console.error('ImageFile', '上传图片出错:', error);

                      // 上传失败
                      AlertDialog.show({
                        message: '提交失败，请重新尝试',
                        confirm: {
                          value: '确定',
                          action: ()=>{
                          }
                        }
                      })
                    }

                  })
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width(120)
              .height(45)
              .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

            }

          }

          Column()
            .height(50)
        } else {
          Cant_Connect()
        }

      }

    }
    .width('100%')
    .height('100%')
  }

  async onPageShow(){
    console.log('show')
    this.uerId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.id
    }

    console.log('Tabs_Exercise', this.exerciseId, this.title)

    if (get.ifSuccess == 1) {
      //获取学校完成练习
      await this.getSelfUnfinish()
    }
  }

  //获取自我未完成练习
  async getSelfUnfinish(){

    await ExerciseService.getMineUnfinish(this.exerciseId)
      .then((selfUnfinish: SelfUnfinishExerciseDetailInfo) => {
        console.log('Tags', '获取自我完成练习成功')

        this.selfUnfinish = selfUnfinish

        this.ifConnect = true

        if (this.selfUnfinish.submit.length != 0) {
          this.filesPaths = this.selfUnfinish.submit
        }

        this.title = this.selfUnfinish.title

        this.ifCollect = this.selfUnfinish.ifCollect

        console.log('ImageFile', 'Result', this.selfUnfinish.submit)

      })
      .catch((error: string) => {
        this.ifConnect = true
        console.log('Tags', '获取自我完成练习失败')
      })

  }

}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}
