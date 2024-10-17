import { HeaderTitle } from '../../../common/components/CommonComponents'
import Comprehensive_Exercises from '../../../views/exercise/self_exercise/self_generated/Comprehensive_Exercises'
import Special_Exercises from '../../../views/exercise/self_exercise/self_generated/Special_Exercises'
import ExerciseService from '../../../service/ExerciseService'
import router from '@ohos.router'
import { Radical } from '../../../data/Radical'
import WordListInfo from '../../../viewmodel/WordListInfo'

//自主生成
@Entry
@Component
struct NewSelfPage {
  @State title: string = '自我练习'
  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  @State sampleWord: WordListInfo[] = [];
  @State radical: Radical = new Radical(0, '', '')
  @State structure: string = ''
  @State typeface: string = ''

  @State ifConnect: boolean = false

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor2(index))
    }
    .border({ width: 1 ,color: $r('app.color.blue')})
    .width('95%')
    .height(29)
    .backgroundColor(this.selectColor1(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor1(index: number){
    return this.currentIndex === index ? $r('app.color.blue') : $r('app.color.start_window_background')
  }

  selectColor2(index: number){
    return this.currentIndex2 === index ? $r('app.color.start_window_background') : $r('app.color.blue')
  }

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })
      Divider()
        .strokeWidth(2)

      //2 导航栏：专项练习，综合练习
      Tabs({barPosition: BarPosition.Start}){
        //2.1 专项练习
        TabContent(){
          Special_Exercises({ radical: $radical, typeface: this.typeface, structure: this.structure, sampleWord: $sampleWord, ifConnect: this.ifConnect })

        }
        .tabBar(this.TabBarBuilder($r('app.string.self_specialExercises'), 0))

        //2.2 综合练习
        TabContent(){
          Comprehensive_Exercises()
        }
        .tabBar(this.TabBarBuilder($r('app.string.self_comprehensiveExercises'), 1))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
        this.currentIndex2 = index
      })
    }
  }

  onPageShow() {

    const radical = router.getParams() as PARAMS

    if (radical != undefined) {
      if (radical.success == true) {
        this.radical = radical.radical
        console.log(`${this.radical.id}`, this.radical.radical, this.radical.name)
      }
    }

    //获取样本字
    this.getTemplateWord()
  }


  //获取模板字
  getTemplateWord(){
    console.log(this.radical.radical, this.structure, this.typeface)

    ExerciseService.getTemplateWord('', this.radical.radical, this.structure, this.typeface, 1)
      .then((sampleWord: WordListInfo[]) => {

        this.sampleWord = sampleWord
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)
        this.ifConnect = false
      })
  }

}

// 声明接受参数的类型
interface PARAMS {
  success: boolean
  radical: Radical
}