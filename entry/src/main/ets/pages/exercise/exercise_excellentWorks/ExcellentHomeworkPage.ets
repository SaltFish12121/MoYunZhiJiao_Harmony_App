import router from '@ohos.router'
import { HeaderTitleCollect } from '../../../common/components/CommonComponents'
import Exercise_ShowDetail_Competition from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Competition'
import Exercise_ShowDetail_Self from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Self'
import Exercise_Top_School from '../../../views/exercise/exercise_detial/Exercise_Top_School'
import ExerciseService from '../../../service/ExerciseService'
import ExcellentHomeworkInfo from '../../../viewmodel/exerciseDetial/ExcellentHomeworkInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Entry
@Component
struct ExcellentHomeworkPage {

  // @State rating: number = 3.5
  @State title: string = '基础笔画练习'
  @State ifCollect: boolean = false
  @State collectId: number = 0
  @State exerciseId: number = 0

  @State excellentHomework: ExcellentHomeworkInfo = new ExcellentHomeworkInfo(0, '笔画练习（一）', '教师李梅', false,
    4, 50, '行书', '专项-偏旁部首练习',
    '际传存论青常照采照再八算何机话元。', /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'),
    [
      new SubmitWritingInfo(50, /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'), [])
    ], 88, '总体文章错误少，缺点笔峰不足，部分字连笔', '分学区话它样界出线先北统列程处。北资百长而场划包族系件期社革消引。因当发东理阶们样由商道处。至正活听加资目强后无白三验科。新革同拉飞可影验四际个的回身斯。书劳车主观个原提性反指本文委。')

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitleCollect({ title: $title, ifCollect: $ifCollect, collectId: $collectId, type: 'ExcellentHomework' })
          .width('95%')

        //2出处
        Row(){
          Row(){
            Text('来源：')
              .fontSize(16)

            Text(/*'教师李梅'*/`${this.excellentHomework.comeFrom}`)
              .fontSize(16)
          }

          /*
          Column(){
            //收藏
            Image($r('app.media.collect0'))
              .width(40)
          }
          */

        }
        .margin({bottom: 20})
        .width('90%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)


        //3信息
        Exercise_Top_School({ exercise: $excellentHomework})

        //4详情
        Exercise_ShowDetail_Self({ exercise: $excellentHomework})


        //5教师评语
        Column(){
          Text('教师评语')
            .width('100%')

          Column(){
            Text(/*'教师评语内容'*/`${this.excellentHomework.teacherComment}`)
              .fontSize(12)
              .width('95%')
              .margin({top: 15, bottom: 15})
          }
          .width('90%')
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

        }
        .margin({top: 20})
        .width('90%')


        //3 关闭
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


        Column(){

        }
        .height(50)

      }

    }
    .width('100%')
    .height('100%')
  }


  async onPageShow(){
    console.log('PageShow')

    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.id
    }

    console.log('Tabs_Exercise', this.exerciseId, this.title)

    if (get.ifSuccess == 1) {
      //获取优秀学校练习
      await this.getExcellentHomework()
    }
  }

  //获取优秀学校练习
  async getExcellentHomework(){
    await ExerciseService.getExcellentHomework(this.exerciseId)
      .then((excellentHomework: ExcellentHomeworkInfo) => {
        console.log('Tags', '获取书法知识成功')

        this.excellentHomework = excellentHomework

        console.log('Result', this.excellentHomework.type, this.excellentHomework.title)

      })
      .catch((error: string) => {

        console.log('Tags', '获取书法知识失败')
      })

    // this.change(this.knowledgeShow)

    this.title = this.excellentHomework.title

    this.ifCollect = this.excellentHomework.ifCollect

    this.collectId = this.excellentHomework.id

    // console.log('Result', this.exerciseType)
  }

}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}