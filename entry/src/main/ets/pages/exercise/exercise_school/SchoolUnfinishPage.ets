import router from '@ohos.router'
import {   HeaderTitleType, HeaderTitleTypeCollect } from '../../../common/components/CommonComponents'
import Exercise_Top_School from '../../../views/exercise/exercise_detial/Exercise_Top_School'
import Exercise_Upload from '../../../views/exercise/exercise_detial/Exercise_Upload'
import ExerciseService from '../../../service/ExerciseService'
import SchoolUnfinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolUnfinishExerciseDetailInfo'
import Cant_Connect from '../../../views/Cant_Connect'
import { imageUploadModule } from '../../../model/ImageUploadModule'

@Entry
@Component
struct SchoolUnfinishPage {
  @State userId: number = 0
  @State exerciseId: number = 0
  @State schoolUnfinish: SchoolUnfinishExerciseDetailInfo = new SchoolUnfinishExerciseDetailInfo(0, '笔画练习（一）', '个人', false, 4, 50, '行书', '专项-偏旁部首练习', '2024-8-30', '际传存论青常照采照再八算何机话元。', ['https://dummyimage.com/120x240'],
    [
      /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1')
    ], false)

  @State cutoff: boolean = false

  @State rating: number = 3.5
  @State title: string = '标题'
  @State type: string = '类型'

  @State ifConnect: boolean = false
  @State ifUpload: boolean = false
  // @State content: string[] = ['https://dummyimage.com/120x240']

  @State selectedPaths: string[] | null = null
  @State filesPaths: string[] = []

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitleType({ title: $title, type: $type,  })
          .width('95%')


        if (this.ifConnect) {
          //2 内容
          Exercise_Top_School({ exercise: $schoolUnfinish })


          //3 倒计时
          Row({space: 30}){
            Text('截止日期')

            Text(/*'2024-4-14'*/this.schoolUnfinish.cutoffTime)
          }
          .width('90%')
          .margin({top: 5})


          //4 上传作品
          // Exercise_Upload({ exerciseId: this.exerciseId, content: $content })
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

            if (this.cutoff) {
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

          }
          .width('90%')
          .margin({top: 30, bottom: 60})


          // 3关闭
          Row({space: 20}){
            // 3关闭
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


            // 4提交
            if (this.cutoff) {// this.cutoff
              Column(){
                Text('提交')
                  .fontSize(20)
                  .onClick(async () => {

                    console.log('ImageFile', 'filesPaths', this.filesPaths, this.exerciseId)

                    // 上传图片
                    const uploadedPaths = await imageUploadModule.prepareUpload(`/ExerciseService/uploadExercise/${this.exerciseId}`, "image", this.filesPaths);
                    console.log('ImageFile', '上传的图片路径:', uploadedPaths);


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
    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.exerciseId
    }

    this.type = '集体'

    console.log('Tabs_Exercise', this.title, this.type)

    //获取学校完成练习
    await this.getSchoolUnfinish()
  }

  aboutToAppear(){
    console.log('appear')
  }

  //获取学校完成练习
  async getSchoolUnfinish(){

    await ExerciseService.getSchoolUnfinish(this.exerciseId)
      .then((schoolUnfinish: SchoolUnfinishExerciseDetailInfo) => {
        console.log('Tags', '获取书法知识成功')

        this.schoolUnfinish = schoolUnfinish

        this.ifConnect = true

        this.title = this.schoolUnfinish.title

        this.type = this.schoolUnfinish.exerciseType

        if (this.schoolUnfinish.submit.length != 0) {
          this.filesPaths = this.schoolUnfinish.submit
        }

        console.log('Result', this.type, this.schoolUnfinish.example)

        console.log('Result', this.schoolUnfinish.type, this.schoolUnfinish.title)

      })
      .catch((error: string) => {
        this.ifConnect = false
        console.log('Tags', '获取书法知识失败')
      })



  }
}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  exerciseId: number
}