import { HeaderTitle } from '../../common/components/CommonComponents'
import Exercise_Upload from '../../views/exercise/exercise_detial/Exercise_Upload'
import CompetitionService from '../../service/CompetitionService'
import CompetitionDetailInfo from '../../viewmodel/CompetitionDetailInfo'
import router from '@ohos.router'
import SubmitWritingInfo from '../../viewmodel/exerciseDetial/SubmitWritingInfo'
import PreferencesUtil from '../../common/utils/PreferencesUtil'

@Entry
@Component
struct CompetitionUnfinishedPage {
  @State title: string = '基础笔画练习'

  @State competition: CompetitionDetailInfo = new CompetitionDetailInfo(0, '笔画练习（一）', '2024-8-11', '2024-8-30',
    '行书', '际传存论青常照采照再八算何机话元。', /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'),
    [
      new SubmitWritingInfo(50, /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'), [])
    ], 88, 18, '重在参与奖', '总体文章错误少，缺点笔峰不足，部分字连笔', false)

  @State success: boolean = false
  @State cutoff: boolean = false

  @State content: ResourceStr[] = [$r('app.media.exercise_test1')]
  @State competitionId: number = 0

  build(){
    Scroll(){
      Column({space: 10}){
        //1 头部
        // Text('123')
        HeaderTitle({ title: this.title })

        //2 内容
        Column({space: 15}){


          //1截止日期
          Row({space: 30}){
            Text('截止日期')

            Text(/*'2024-6-29 13：30'*/this.competition.finishTime)
          }
          .width('90%')


          //2要求
          Column({space: 10}){
            Row(){
              Text('要求')

              Text(/*'楷体'*/this.competition.typeface)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

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

          // 3样例
          Column(){
            Text('提交格式')
              .width('100%')


            Image(/*$r('app.media.exercise_test1')*/this.competition.example)
              .width('90%')
              .margin({top: 10 })
          }
          .width('90%')



          //5上传作品
          Exercise_Upload({ exerciseId: $competitionId, content: $content })


        }
        .width('100%')


        //3 提交
        Column(){
          Text('提交')
            .fontSize(20)
            .onClick(async (event: ClickEvent) => {
              await this.submitCompetition()

              if (this.success) {
                AlertDialog.show({
                  message: '竞赛提交成功',
                  confirm: {
                    value: '确定',
                    action: ()=>{
                      router.back()
                    }
                  }
                })

              } else {
                AlertDialog.show({
                  message: '竞赛提交失败，请重新尝试',
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


        Column(){

        }
        .height(50)

      }
      .width('100%')
      // .height('100%')

    }
    .width('100%')
    .height('100%')
  }

  async onPageShow(){
    console.log('page')

    const param = router.getParams() as PARAMS
    if (param.competitionId != undefined) {
      this.competitionId = param.competitionId
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
    this.competitionId = this.competition.id

  }

  //提交竞赛
  async submitCompetition(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    await CompetitionService.submitCompetition(userId, this.competition.id, this.content)
      .then((success) => {
        console.log('Tags', '获取竞赛详情成功')

        this.success = success

        console.log('Result', this.success)
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛详情失败', error)

      })

  }
}

// 声明接受参数的类型
interface PARAMS {
  competitionId: number
}