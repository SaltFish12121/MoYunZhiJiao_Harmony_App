import router from '@ohos.router'
import { HeaderTitle } from '../../common/components/CommonComponents'
import CompetitionService from '../../service/CompetitionService'
import CompetitionDetailInfo from '../../viewmodel/CompetitionDetailInfo'
import Competition_ShowDetail_Finish from '../../views/competition/competiiton_detail/Competition_ShowDetail_Finish'
import SubmitWritingInfo from '../../viewmodel/exerciseDetial/SubmitWritingInfo'
import Cant_Connect from '../../views/Cant_Connect'

//完成的竞赛
@Entry
@Component
struct CompetitionFinishedPage {

  @State title: string = '基础笔画练习'
  @State competitionId: number = 0

  @State competition: CompetitionDetailInfo = new CompetitionDetailInfo(0, '笔画练习（一）', '2024-8-11', '2024-8-30',
    '行书', '际传存论青常照采照再八算何机话元。', 'https://dummyimage.com/120x240',
    [
      new SubmitWritingInfo(50, 'https://dummyimage.com/120x240', [])
    ], 88, 18, '重在参与奖', '总体文章错误少，缺点笔峰不足，部分字连笔', false)

  @State ifConnect: boolean = false

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitle({ title: $title })
        .width('95%')

        if (this.ifConnect) {
          //2 内容
          Column({space: 15}){

            //2要求
            Column({space: 10}){
              Row(){
                Text('要求')
                  .textAlign(TextAlign.Start)

                //字体
                Text(this.competition.typeface)
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .width('100%')


              ///作业要求
              Column(){
                Text(this.competition.require)
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


              Image(this.competition.example)
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

        this.title = this.competition.title

        console.log('Result', this.competition.title)

        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛详情失败', error)
        this.ifConnect = false
      })
  }

}

// 声明接受参数的类型
interface PARAMS {
  exerciseId: number
}