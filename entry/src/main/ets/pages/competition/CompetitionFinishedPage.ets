import router from '@ohos.router'
import { HeaderTitle, HeaderTitleCollect } from '../../common/components/CommonComponents'
import Exercise_ShowDetail_Competition from '../../views/exercise/exercise_detial/Exercise_ShowDetail_Competition'
import CompetitionService from '../../service/CompetitionService'
import CompetitionDetailInfo from '../../viewmodel/CompetitionDetailInfo'
import CompetitionContentInfo from '../../viewmodel/exerciseDetial/CompetitionContentInfo'
import Competition_ShowDetail_Finish from '../../views/competition/competiiton_detail/Competition_ShowDetail_Finish'
import SubmitWritingInfo from '../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Entry
@Component
struct CompetitionFinishedPage {

  @State title: string = '基础笔画练习'
  // @State ifCollect: boolean = false
  // @State collectId: number = 0
  @State competitionId: number = 0

  @State competition: CompetitionDetailInfo = new CompetitionDetailInfo(0, '笔画练习（一）', '2024-8-11', '2024-8-30',
    '行书', '际传存论青常照采照再八算何机话元。', /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'),
    [
      new SubmitWritingInfo(50, /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'), [])
    ], 88, 18, '重在参与奖', '总体文章错误少，缺点笔峰不足，部分字连笔', false)

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitle({ title: $title })
        .width('95%')

        //2 内容
        Column({space: 15}){
          //1信息
          Row(){
            /*
            Row(){
              Text('难度')

              Rating({ rating: this.rating, indicator: true })
                .stars(5)
                .stepSize(0.5)

            }
            */

            /*
            Row({space: 10}){
              Text('字数')

              Text('50')
            }
            */


            /*
            Row(){
              Text('专项-偏旁部首练习')
            }
            */
          }
          .width('90%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          //2要求
          Column({space: 10}){
            Row(){
              Text('要求')
                .textAlign(TextAlign.Start)

              Text(/*'楷体'*/this.competition.typeface)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('100%')


            Column(){
              Text(/*'作业要求'*/this.competition.require)
                .fontSize(12)
                .width('95%')
                .margin({top: 15, bottom: 15})
            }
            .width('90%')
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

          }
          .width('90%')
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)

          //3样例
          Column({space: 10}){
            Text('提交格式')
              .width('100%')


            Image(/*$r('app.media.exercise_test1')*/this.competition.example)
              .width('90%')
          }
          .width('90%')


        }


        Competition_ShowDetail_Finish({ competitionContent: $competition })
          .margin({ top: 15})


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
    console.log('page')

    const param = router.getParams() as PARAMS
    if (param.exerciseId != undefined) {
      this.competitionId = param.exerciseId
    }
    console.log('competitionId', this.competitionId)

    //获取竞赛详情
    await this.getCompetitionDetail()

    console.log('finish page')
  }


  //获取竞赛详情
  async getCompetitionDetail(){
    await CompetitionService.getCompetitionDetail(this.competitionId)
      .then((competitionDetail: CompetitionDetailInfo) => {
        console.log('Tags', '获取竞赛详情成功')

        this.competition = competitionDetail

        console.log('Result', this.competition.title)
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛详情失败', error)

      })

    this.title = this.competition.title
    // this.ifCollect = this.competition.ifCollect
    // this.collectId = this.competition.id
  }

}

// 声明接受参数的类型
interface PARAMS {
  exerciseId: number
}