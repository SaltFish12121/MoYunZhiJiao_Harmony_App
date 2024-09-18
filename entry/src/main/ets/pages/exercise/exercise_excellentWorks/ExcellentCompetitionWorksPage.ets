import { HeaderTitle, HeaderTitleCollect } from '../../../common/components/CommonComponents'
import Exercise_ShowDetail_Competition from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Competition'
import Exercise_ShowDetail_Self from '../../../views/exercise/exercise_detial/Exercise_ShowDetail_Self'
import ExerciseService from '../../../service/ExerciseService'
import ExcellentCompetitionInfo from '../../../viewmodel/exerciseDetial/ExcellentCompetitionInfo'
import CompetitionContentInfo from '../../../viewmodel/exerciseDetial/CompetitionContentInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct ExcellentCompetitionWorksPage {

  @State title: string = '基础笔画练习'
  @State ifCollect: boolean = false
  @State collectId: number = 0
  @State exerciseId: number = 0

  @State excellentCompetition: ExcellentCompetitionInfo = new ExcellentCompetitionInfo(0, '笔画练习（一）', '教师李梅', false,
    [
      new CompetitionContentInfo(0, 80, 18, '重在参与奖', '分学区话它样界出线先北统列程处。北资百长而场划包族系件期社革消引。因当发东理阶们样由商道处。至正活听加资目强后无白三验科。新革同拉飞可影验四际个的回身斯。书劳车主观个原提性反指本文委。',
        [
          new SubmitWritingInfo(50, /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'), [])
        ])
    ])


  build() {
    Scroll(){
      Column(){
        //1头部
        HeaderTitleCollect({ title: $title, ifCollect: $ifCollect, collectId: $collectId, type: 'ExcellentCompetition' })

        //2出处
        Row(){
          Row(){
            Text('来源：')
              .fontSize(16)

            Text(/*'系统'*/this.excellentCompetition.comeFrom)
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


        //3内容（可能多个）
        ForEach(
          this.excellentCompetition.content,
          (content: CompetitionContentInfo) => {
            Exercise_ShowDetail_Competition({ competitionContent: content })
          }
        )


        Column(){

        }.height(50)

      }
    }

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
      //获取优秀竞赛练习
      await this.getExcellentCompetition()
    }
  }

  //获取优秀竞赛练习
  async getExcellentCompetition(){
    await ExerciseService.getExcellentCompetition(this.exerciseId)
      .then((excellentCompetition: ExcellentCompetitionInfo) => {
        console.log('Tags', '获取书法知识成功')

        this.excellentCompetition = excellentCompetition

        console.log('Result', this.excellentCompetition.comeFrom, this.excellentCompetition.title)

      })
      .catch((error: string) => {

        console.log('Tags', '获取书法知识失败')
      })

    // this.change(this.knowledgeShow)

    this.title = this.excellentCompetition.title

    this.ifCollect = this.excellentCompetition.ifCollect

    this.collectId = this.excellentCompetition.id

    // this.content = this.excellentCompetition.content

    // this.contentLength = this.excellentCompetition.content.length
    // console.log('Result', this.exerciseType)
  }

}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}