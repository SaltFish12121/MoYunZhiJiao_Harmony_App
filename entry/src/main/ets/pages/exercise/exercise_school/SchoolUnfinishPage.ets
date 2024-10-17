import router from '@ohos.router'
import {   HeaderTitleType } from '../../../common/components/CommonComponents'
import Exercise_Top_School from '../../../views/exercise/exercise_detial/Exercise_Top_School'
import ExerciseService from '../../../service/ExerciseService'
import SchoolUnfinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolUnfinishExerciseDetailInfo'
import Cant_Connect from '../../../views/Cant_Connect'
import { imageUploadModule } from '../../../model/ImageUploadModule'
import Exercise_Upload from '../../../views/exercise/exercise_detial/Exercise_Upload'

//学校未完成
@Entry
@Component
struct SchoolUnfinishPage {
  @State userId: number = 0
  @State exerciseId: number = 0
  @State schoolUnfinish: SchoolUnfinishExerciseDetailInfo = new SchoolUnfinishExerciseDetailInfo(0, '笔画练习（一）', '个人', false, 4, 50, '行书', '专项-偏旁部首练习', '2024-8-30', '际传存论青常照采照再八算何机话元。', ['https://dummyimage.com/120x240'],
    [
      'https://dummyimage.com/120x240'
    ], false)

  @State cutoff: boolean = false

  @State rating: number = 3.5
  @State title: string = '标题'
  @State type: string = '类型'

  @State ifConnect: boolean = false
  @State ifUpload: boolean = false
  @State content: string[] = []


  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitleType({ title: $title, type: $type,  })
          .width('95%')


        if (this.ifConnect) {
          //2 内容
          Exercise_Top_School({ exercise: $schoolUnfinish })


          //3 截止日期
          Row({space: 30}){
            Text('截止日期')

            Text(this.schoolUnfinish.cutoffTime)
          }
          .width('90%')
          .margin({top: 5})


          //4 上传作品
          Exercise_Upload({ exerciseId: this.exerciseId, content: $content, ifCutOFF: this.schoolUnfinish.cutoff })


          //5 关闭
          Row({space: 20}){
            //5.1 关闭
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


            //5.2 提交
            if (this.cutoff) {
              Column(){
                Text('提交')
                  .fontSize(20)
                  .onClick(async () => {

                    console.log('ImageFile', 'filesPaths', this.content, this.exerciseId)

                    // 上传图片
                    const uploadedPaths = await imageUploadModule.prepareUpload(`/ExerciseService/uploadExercise/${this.exerciseId}`, "image", this.content);
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
          this.content = this.schoolUnfinish.submit
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