import { router } from '@kit.ArkUI'
import DateUtil from '../../../common/utils/DateUtil'
import { DatePickDialog } from '../../../common/components/DatePickDialog/DatePickDialog'
import ExerciseAnalysisInfo from '../../../viewmodel/analysis/ExerciseAnalysisInfo'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import ExerciseAnalysisItem from '../../../viewitem/ExerciseAnalysisItem'
import UserService from '../../../service/UserService'
import ExerciseService from '../../../service/ExerciseService'
import No_Content from '../../No_Content'

@Extend(ListItem) function exercise_List(){
  .width('95%')
  .backgroundColor($r('app.color.start_window_background'))
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

class YearOptions {
  currentYear: number;
  years: number[];
  arr: SelectOption[];

  constructor() {
    this.currentYear = new Date().getFullYear();
    this.years = []; // 初始化 years 数组
    let i = 0;
    for (let index = 2024; index <= this.currentYear; index++) {
      this.years[i++] = index;
    }
    this.arr = [
      { value: '全部年份', icon: "/common/public_icon.svg" },
      ...this.years.map((year): SelectOption => ({ value: year.toString()+'年' as ResourceStr, icon: "/common/public_icon.svg" }))
    ];
  }
}

@Component
export default struct Exercise_Analysis {
  @Link exerciseAnalysis: ExerciseAnalysisInfo[]
  @Link year: string
  @Link month: string

  yearOptions = new YearOptions();

  @Prop ifConnect: boolean

  build() {
    Column(){
      //1年月选择
      Row(){
        Row({space: 10}){
          //1年份选择
          Select(this.yearOptions.arr)
            .selected(0)
            .value(this.year)
            .font({ size: 18, weight: 500 })
            .fontColor($r('app.color.blue'))
            .backgroundColor($r('app.color.start_window_background'))
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number, v: string) => {
              this.year = v
              //获取练习总体分析
              this.getExerciseAnalysis()
            })


          //2月份选择
          Select([
            { value: '全部月份', icon: "/common/public_icon.svg" },
            { value: '1月', icon: "/common/public_icon.svg" },
            { value: '2月', icon: "/common/public_icon.svg" },
            { value: '3月', icon: "/common/public_icon.svg" },
            { value: '4月', icon: "/common/public_icon.svg" },
            { value: '5月', icon: "/common/public_icon.svg" },
            { value: '6月', icon: "/common/public_icon.svg" },
            { value: '7月', icon: "/common/public_icon.svg" },
            { value: '8月', icon: "/common/public_icon.svg" },
            { value: '9月', icon: "/common/public_icon.svg" },
            { value: '10月', icon: "/common/public_icon.svg" },
            { value: '11月', icon: "/common/public_icon.svg" },
            { value: '12月', icon: "/common/public_icon.svg" }
          ])
            .selected(0)
            .value(this.month)
            .font({ size: 18, weight: 500 })
            .fontColor($r('app.color.blue'))
            .backgroundColor($r('app.color.start_window_background'))
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .onSelect((index: number, v: string) => {
              this.month = v
              //获取练习总体分析
              this.getExerciseAnalysis()
            })
        }
        .width('70%')
        .justifyContent(FlexAlign.SpaceBetween)

        //全部按键
        Row(){

          Text('全部')
            // .fontColor($r('app.color.blue'))
            .fontSize(16)

        }
        .padding({top: 7, bottom: 7, left: 13, right: 13})
        .borderRadius(15)
        .backgroundColor($r('app.color.mid_gray'))
        .onClick(() => {
          this.year = '全部年份'
          this.month = '全部月份'
          //获取练习总体分析
          this.getExerciseAnalysis()
        })

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .margin({bottom: 10})

      if (this.ifConnect) {
        //2练习列表
        List({space: 10}){
          ListItem().height(5)

          ForEach(
            this.exerciseAnalysis,
            (exerciseAnalysis: ExerciseAnalysisInfo) => {
              ListItem(){
                ExerciseAnalysisItem({ exerciseAnalysis: exerciseAnalysis })
              }
              .exercise_List()
              .onClick(() => {
                console.log('exerciseId', exerciseAnalysis.id)
                //跳转练习页面
                if (exerciseAnalysis.type) {
                  //自我练习
                  router.pushUrl(
                    {
                      url: 'pages/exercise/exercise_self/SelfFinishPage',
                      params: {
                        ifSuccess: 1,
                        id: exerciseAnalysis.id,
                        title: exerciseAnalysis.name
                      }
                    }
                  )
                } else {
                  //学校练习
                  router.pushUrl(
                    {
                      url: 'pages/exercise/exercise_school/SchoolFinishPage',
                      params: {
                        ifSuccess: 1,
                        id: exerciseAnalysis.id,
                        title: exerciseAnalysis.name
                      }
                    }
                  )
                }

              })

            }
          )

          ListItem().height(50)
        }
        .width('100%')
        .height('90%')
        .alignListItem(ListItemAlign.Center)
        .align(Alignment.TopStart)
        .backgroundColor($r('app.color.mid_gray'))
        .onReachStart(() => {

        })
        .onReachEnd(() => {

        })
      } else {
        No_Content()
      }


    }
    .width('100%')
    .height('100%')
  }

  //获取练习总体分析
  async getExerciseAnalysis(){
    await UserService.getExerciseAnalysis(this.year, this.month)
      .then((exerciseAnalysis: ExerciseAnalysisInfo[]) => {
        console.log('Tags', '获取练习总体分析成功')

        this.exerciseAnalysis = exerciseAnalysis

        console.log('Result', this.exerciseAnalysis[0].id)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛通知失败', error)
        this.ifConnect = false
      })

    // console.log(`${this.frequency}`)
  }

}