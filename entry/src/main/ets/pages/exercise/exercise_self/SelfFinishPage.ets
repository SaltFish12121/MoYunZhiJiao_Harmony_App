import router from '@ohos.router'
import { HeaderTitle, HeaderTitleCollect } from '../../../common/components/CommonComponents'
import Exercise_ShowDetail_Self from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Self'
import Exercise_Top_Self from '../../../views/exercise/exercise_detial/Exercise_Top_Self'
import SelfFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SelfFinishExerciseDetailInfo'
import ExerciseService from '../../../service/ExerciseService'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Entry
@Component
struct SelfFinishPage {

  @State title: string = '基础笔画练习'
  @State ifCollect: boolean = false
  @State collectId: number = 0

  @State uerId: number = 0
  @State exerciseId: number = 0
  @State selfFinish: SelfFinishExerciseDetailInfo = new SelfFinishExerciseDetailInfo(0, '笔画练习（一）', false, '行书',
    /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'),
    [
      new SubmitWritingInfo(50, /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'), [])
    ], 88, '分学区话它样界出线先北统列程处。北资百长而场划包族系件期社革消引。因当发东理阶们样由商道处。至正活听加资目强后无白三验科。新革同拉飞可影验四际个的回身斯。书劳车主观个原提性反指本文委。')


  @State success: boolean = false

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitleCollect({ title: $title, ifCollect: $ifCollect, collectId: $collectId, type: 'SelfExercise' })

        //2内容
        if (this.success) {
          Exercise_Top_Self({ selfExercise: $selfFinish })
        }



        //3练习情况
        Exercise_ShowDetail_Self({ exercise: $selfFinish })
        .margin({ top: 10 })


        //4关闭
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
    console.log('show')

    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.id
    }

    console.log('Tabs_Exercise', this.exerciseId, this.title)

    if (get.ifSuccess == 1) {
      //获取学校完成练习
      await this.getSelfFinish()
    }
  }

  //获取自我完成练习
  async getSelfFinish(){

    await ExerciseService.getMineFinish(this.uerId, this.exerciseId)
      .then((selfFinish: SelfFinishExerciseDetailInfo) => {
        console.log('Tags', '获取自我完成练习成功')

        this.selfFinish = selfFinish

        this.success = true

        console.log('Result', this.selfFinish.title, this.selfFinish.example)

      })
      .catch((error: string) => {
        this.success = true
        console.log('Tags', '获取自我完成练习失败')
      })

    // this.change(this.knowledgeShow)

    this.title = this.selfFinish.title

    this.ifCollect = this.selfFinish.ifCollect

    this.collectId = this.selfFinish.id

  }

}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}