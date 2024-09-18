import { HeaderTitle } from '../../../common/components/CommonComponents'
import Comprehensive_Exercises from '../../../views/exercise/self_exercise/self_generated/Comprehensive_Exercises'
import ExpertCopywriting from '../../../views/exercise/self_exercise/self_generated/ExpertCopywriting'
import Special_Exercises from '../../../views/exercise/self_exercise/self_generated/Special_Exercises'
import ExerciseService from '../../../service/ExerciseService'
import router from '@ohos.router'
import { Radical } from '../../../data/Radical'
import WordListInfo from '../../../viewmodel/WordListInfo'


@Entry
@Component
struct NewSelfPage {
  @State title: string = '自我练习'
  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  @State sampleWord: WordListInfo[] = [
    new WordListInfo(73, "https://dummyimage.com/120x240"),
    new WordListInfo(67, "https://dummyimage.com/120x240"),
    new WordListInfo(74, "https://dummyimage.com/120x240"),
    new WordListInfo(59, "https://dummyimage.com/120x240"),
    new WordListInfo(4, "https://dummyimage.com/120x240"),
    new WordListInfo(98, "https://dummyimage.com/120x240"),
    new WordListInfo(2, "https://dummyimage.com/120x240"),
    new WordListInfo(81, "https://dummyimage.com/120x240"),
    new WordListInfo(47, "https://dummyimage.com/120x240"),
    new WordListInfo(59, "https://dummyimage.com/120x240"),
    new WordListInfo(78, "https://dummyimage.com/120x240"),
    new WordListInfo(3, "https://dummyimage.com/120x240"),
    new WordListInfo(69, "https://dummyimage.com/120x240"),
    new WordListInfo(4, "https://dummyimage.com/120x240"),
    new WordListInfo(70, "https://dummyimage.com/120x240"),
    new WordListInfo(23, "https://dummyimage.com/120x240"),
    new WordListInfo(71, "https://dummyimage.com/120x240"),
    new WordListInfo(51, "https://dummyimage.com/120x240"),
    new WordListInfo(77, "https://dummyimage.com/120x240"),
    new WordListInfo(59, "https://dummyimage.com/120x240"),
    new WordListInfo(85, "https://dummyimage.com/120x240"),
    new WordListInfo(64, "https://dummyimage.com/120x240"),
    new WordListInfo(66, "https://dummyimage.com/120x240"),
    new WordListInfo(8, "https://dummyimage.com/120x240")
  ];
  @State radical: Radical = new Radical(0, '', '')
  @State structure: string = ''
  @State typeface: string = ''

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
      //1头部
      HeaderTitle({ title: $title })
      Divider()
        .strokeWidth(2)

      //2导航栏：专项练习，综合练习，专家字帖
      Tabs({barPosition: BarPosition.Start}){
        //1.专项练习
        TabContent(){
          // Text('专项练习')
          Special_Exercises({ radical: $radical, typeface: this.typeface, structure: this.typeface, sampleWord: $sampleWord })

        }
        .tabBar(this.TabBarBuilder($r('app.string.self_specialExercises'), 0))

        //2.综合练习
        TabContent(){
          // Text('综合练习')
          Comprehensive_Exercises()
        }
        .tabBar(this.TabBarBuilder($r('app.string.self_comprehensiveExercises'), 1))

        // //3.专家字帖
        // TabContent(){
        //   // Text('专家字帖')
        //   ExpertCopywriting()
        // }
        // .tabBar(this.TabBarBuilder($r('app.string.self_expertCopywriting'), 2))

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
    this.getSampleWord()
  }


  //获取样本字
  getSampleWord(){
    console.log(this.radical.radical, this.structure, this.typeface)

    ExerciseService.getSampleWord('', this.radical.radical, this.structure, this.typeface, 1)
      .then((sampleWord: WordListInfo[]) => {

        this.sampleWord = sampleWord
      })
      .catch((error: string) => {
        console.log('Tags', '获取样本字', error)
      })
  }

}

// 声明接受参数的类型
interface PARAMS {
  success: boolean
  radical: Radical
}