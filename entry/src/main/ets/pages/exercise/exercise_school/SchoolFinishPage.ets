import router from '@ohos.router'
import {  HeaderTitleTypeCollect } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import Exercise_ShowDetail_Self from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Self'
import Exercise_Top_School from '../../../views/exercise/exercise_detial/Exercise_Top_School'
import ExerciseInfo from '../../../viewmodel/ExerciseInfo'
import { ExerciseType } from '../../../viewmodel/ExerciseInfo'
import ExerciseService from '../../../service/ExerciseService'

import SchoolFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolFinishExerciseDetailInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'
import Cant_Connect from '../../../views/Cant_Connect'

@Entry
@Component
struct SchoolFinishPage {
  @State uerId: number = 0
  @State exerciseId: number = 0
  @State schoolFinish: SchoolFinishExerciseDetailInfo = new SchoolFinishExerciseDetailInfo
  (
    0, '笔画练习（一）', '个人', false, 4, 50, '行书', '专项-偏旁部首练习', '际传存论青常照采照再八算何机话元。', $r('app.media.exercise_test1'),
    [
      new SubmitWritingInfo(50, $r('app.media.exercise_test1'), [])
    ], 88, '总体文章错误少，缺点笔峰不足，部分字连笔', '分学区话它样界出线先北统列程处。北资百长而场划包族系件期社革消引。因当发东理阶们样由商道处。至正活听加资目强后无白三验科。新革同拉飞可影验四际个的回身斯。书劳车主观个原提性反指本文委。'
  )

  @State rating: number = 3.5
  @State title: string = '基础笔画练习'
  @State exerciseType: string = '个人'
  @State ifCollect: boolean = false
  @State collectId: number = 0

  @State ifConnect: boolean = false

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitleTypeCollect({ title: $title, type: $exerciseType, ifCollect: $ifCollect, collectId: $collectId, collectType: 'SchoolExercise' })
          .width('95%')

        if (this.ifConnect){
          //2 内容
          Exercise_Top_School({ exercise: $schoolFinish})
            .margin({bottom: 15})

          //3详情
          Exercise_ShowDetail_Self({ exercise: $schoolFinish})


          //4教师评语
          Column(){
            Text('教师评语')
              .width('100%')

            Column(){
              Text(/*'教师评语内容'*/this.schoolFinish.teacherComment)
                .fontSize(12)
                .width('95%')
                .margin({top: 15, bottom: 15})
            }
            .width('90%')
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

          }
          .margin({top: 20})
          .width('90%')


          //5 关闭
          Column(){
            Text('关闭')
              .fontSize(20)
              .onClick((event: ClickEvent) => {
                router.back()
              })
          }
          .margin({top: 50})
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width(120)
          .height(45)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })


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

    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.id
    }

    console.log('Tabs_Exercise', this.exerciseId, this.title, this.exerciseType)

    if (get.ifSuccess == 1) {
      //获取学校完成练习
      await this.getSchoolFinish()
    }

  }

  async aboutToAppear(){
    console.log('appear')

    //获取学校完成练习
    // await this.getSchoolFinish()

  }


  //获取学校完成练习
  async getSchoolFinish(){

    await ExerciseService.getSchoolFinish(this.exerciseId)
      .then((schoolFinish: SchoolFinishExerciseDetailInfo) => {
        console.log('Tags', '获取书法知识成功')

        this.schoolFinish = schoolFinish

        this.ifConnect = true

        this.title = this.schoolFinish.title

        this.exerciseType = this.schoolFinish.exerciseType

        this.ifCollect = this.schoolFinish.ifCollect

        this.collectId = this.schoolFinish.id
        console.log('Result', this.exerciseType, this.schoolFinish.example)
        console.log('Result', this.schoolFinish.id, this.schoolFinish.title, this.schoolFinish.submit[0].submit)
        // this.ifConnect = true
      })
      .catch((error: string) => {
        this.ifConnect = false
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

}


// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}