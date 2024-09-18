import router from '@ohos.router'
import { HeaderTitle } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import SystemCopybookItem from '../../../viewitem/SystemCopybookItem'
import { TemplateType } from  '../../../viewmodel/SystemTemplateInfo'
import SystemTemplateInfo from  '../../../viewmodel/SystemTemplateInfo'
import ExerciseService from '../../../service/ExerciseService'

@Extend(Column) function exercise_List(){
  .width('95%')
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}


@Entry
@Component
struct NewSystemPage {
  @State copybook: SystemTemplateInfo[] = [
    new SystemTemplateInfo(0, TemplateType.specialType, '笔画练习（二）', ''),
    new SystemTemplateInfo(0, TemplateType.specialType, '笔画练习（一）', ''),
    new SystemTemplateInfo(0, TemplateType.specialType, '横折练习（一）', ''),
    new SystemTemplateInfo(0, TemplateType.syntheticType, '鹅鹅鹅', '2024-3-3'),
    new SystemTemplateInfo(0, TemplateType.syntheticType, '静夜思', '2024-3-3'),
    new SystemTemplateInfo(0, TemplateType.syntheticType, '将进酒', '2024-3-2'),
    new SystemTemplateInfo(0, TemplateType.copybookType, '横折练习', '2024-3-3'),
    new SystemTemplateInfo(0, TemplateType.copybookType, '第一届书法大赛', '2024-3-3'),
    new SystemTemplateInfo(0, TemplateType.copybookType, '《唐灵飞经》', '2024-3-2')
  ]
  @State title: string = '系统模板'
  @State currentIndex: number = 0
  @State pageNum: number = 1
  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number) {
    Column({ space: 8 }) {
      Text(title)
        .fontSize(14)
        .fontColor($r('app.color.black'))
    }
    .width('100%')
    .height(40)
    .backgroundColor(this.selectColor(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor(index: number) {
    return this.currentIndex === index ? $r('app.color.button1') : $r('app.color.gray')
  }

  build() {
    Column() {
      //1头部
      HeaderTitle({ title: $title })

      //2.导航栏：专项类型，综合类型，字帖类型
      Tabs({ barPosition: BarPosition.Start }) {
        //1.专项类型
        TabContent() {
          // Text('专项类型')
          templateType({ exercise: $copybook, type: TemplateType.specialType, pageNum: this.pageNum })

        }
        .tabBar(this.TabBarBuilder('专项类型', 0))

        //2.综合类型
        TabContent() {
          // Text('综合类型')
          templateType({ exercise: $copybook, type: TemplateType.syntheticType, pageNum: this.pageNum })

        }
        .tabBar(this.TabBarBuilder('综合类型', 1))

        //3.字帖类型
        TabContent() {
          // Text('字帖类型')
          templateType({ exercise: $copybook, type: TemplateType.copybookType, pageNum: this.pageNum })

        }
        .tabBar(this.TabBarBuilder('字帖类型', 2))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
      })

    }
  }

  async aboutToAppear() {
    // console.log('page appear')

  }

  async onPageShow(){
    // console.log('page show')
    //获取系统模板
    await this.getSystemTemplate()
  }


  //获取系统模板
  async getSystemTemplate(){
    await ExerciseService.getSystemTemplate(this.pageNum)
      .then((copybook: SystemTemplateInfo[]) => {
        console.log('Tags', '获取系统字帖成功')

        this.copybook = copybook

        console.log('Result', '系统模板', this.copybook[0].title, this.copybook[0].type)
      })
      .catch((error: string) => {
        console.log('Tags', '获取系统字帖失败', error)
      })
  }


}


@Component
struct templateType {
  @Link exercise: SystemTemplateInfo[]
  @Link pageNum: number
  type: string = ''

  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){

      Scroll(){
        //2系统字贴列表
        Column({space: 10}){
          Column(){

          }
          .height(5)

          ForEach(this.exercise, (exercise: SystemTemplateInfo) => {
            if (exercise.type == this.type ){
              Column() {
                SystemCopybookItem({ exercise: exercise })
              }
              .exercise_List()
            }

          })

          Column(){

          }
          .height(100)

        }
        .width('100%')

      }
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum ++
          // page = ShopModel.pageNo
          this.getSystemTemplate()
        }
      })


    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear(){
    // console.log('component appear')
  }

  //获取系统模板
  async getSystemTemplate(){
    await ExerciseService.getSystemTemplate(this.pageNum)
      .then((copybook: SystemTemplateInfo[]) => {
        console.log('Tags', '获取系统字帖成功')

        //拼接
        this.exercise = this.exercise.concat(copybook)
        this.isLoading = false
        if(!copybook || copybook.length === 0){
          this.isMore = false
        }

        console.log('Result', '系统模板', this.exercise[0].title)
      })
      .catch((error: string) => {
        console.log('Tags', '获取系统字帖失败', error)
      })
  }
}