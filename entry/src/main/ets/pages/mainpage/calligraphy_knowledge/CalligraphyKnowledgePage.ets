import { HeaderTitle } from '../../../common/components/CommonComponents'
import Knowledge_Biography from '../../../views/homepage/calligraphy_knowledge/Knowledge_Biography'
import Knowledge_Culture from '../../../views/homepage/calligraphy_knowledge/Knowledge_Culture'
import Knowledge_FamousWorks from '../../../views/homepage/calligraphy_knowledge/Knowledge_FamousWorks'
import Knowledge_Hanzi from '../../../views/homepage/calligraphy_knowledge/Knowledge_Hanzi'
import Knowledge_Recommend from '../../../views/homepage/calligraphy_knowledge/Knowledge_Recommend'
import InformationService from  '../../../service/InformationService'

import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import Cant_Connect from '../../../views/Cant_Connect'

//书法知识
@Entry
@Component
struct CalligraphyKnowledgePage {
  @State currentIndex: number = 0
  @State title: string = '书法知识'
  @State search: string = ''

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(16)
        .fontColor(this.selectColor2(index))

      Divider()
        .color(this.selectColor1(index))
        .strokeWidth(2)
        .width(70)
    }
    .width('100%')
    .height(40)
    .justifyContent(FlexAlign.Center)
  }

  selectColor1(index: number){
    return this.currentIndex === index ? $r('app.color.pink') : $r('app.color.start_window_background')
  }

  selectColor2(index: number){
    return this.currentIndex === index ? $r('app.color.pink') : $r('app.color.black')
  }

  @State recommendKnowledge: KnowledgeInfo[] = []
  @State biographyKnowledge: KnowledgeInfo[] = []
  @State HanziKnowledge: KnowledgeInfo[] = []
  @State famousWorksKnowledge: KnowledgeInfo[] = []
  @State cultureKnowledge: KnowledgeInfo[] = []

  @State pageNumRecommend: number = 1
  @State pageNumBiography: number = 1
  @State pageNumHanzi: number = 1
  @State pageNumFamousWorks: number = 1
  @State pageNumCulture: number = 1

  @State ifConnect: boolean = false

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })

      Row({space: 10}){
        Search()
          .height(40)
          .width(300)
          .onChange((v: string) => {
            this.search = v
          })

        Text('搜索')
          .fontSize(18)
          .fontColor($r('app.color.blue'))
          .onClick(async () => {
            this.pageNumRecommend = 1
            this.pageNumBiography = 1
            this.pageNumHanzi = 1
            this.pageNumFamousWorks = 1
            this.pageNumCulture = 1

            //获取书法知识
            this.ifConnect = false
            await Promise.all([
              this.getRecommendKnowledge(),
              this.getBiographyKnowledge(),
              this.getHanziKnowledge(),
              this.getFamousWorksKnowledge(),
              this.getCultureKnowledge(),
            ]);

          })
      }

      if (this.ifConnect) {
        //2 导航栏+内容
        Tabs({barPosition: BarPosition.Start}){
          //2.1 推荐
          TabContent(){
            Knowledge_Recommend({ knowledge: $recommendKnowledge, search: $search, pageNum: this.pageNumRecommend })
          }
          .tabBar(this.TabBarBuilder($r('app.string.knowledge_recommend'), 0))

          //2.2 人物传记
          TabContent(){
            Knowledge_Biography({ knowledge: $biographyKnowledge, search: $search, pageNum: this.pageNumBiography })
          }
          .tabBar(this.TabBarBuilder($r('app.string.knowledge_biography'), 1))

          //2.3 汉字
          TabContent(){
            Knowledge_Hanzi({ knowledge: $HanziKnowledge, search: $search, pageNum: this.pageNumHanzi })
          }
          .tabBar(this.TabBarBuilder($r('app.string.knowledge_Hanzi'), 2))

          //2.4 名家作品
          TabContent(){
            Knowledge_FamousWorks({ knowledge: $famousWorksKnowledge, search: $search, pageNum: this.pageNumFamousWorks })
          }
          .tabBar(this.TabBarBuilder($r('app.string.knowledge_famousWorks'), 3))

          //2.5 文化
          TabContent(){
            Knowledge_Culture({ knowledge: $cultureKnowledge, search: $search, pageNum: this.pageNumCulture })
          }
          .tabBar(this.TabBarBuilder($r('app.string.knowledge_culture'), 4))


        }
        .width('100%')
        .height('100%')
        .onChange(index => {
          this.currentIndex = index
        })
      } else {
        Cant_Connect()
      }

    }
  }

  async onPageShow(){
    this.ifConnect = false
    //获取书法知识
    await Promise.all([
      this.getRecommendKnowledge(),
      this.getBiographyKnowledge(),
      this.getHanziKnowledge(),
      this.getFamousWorksKnowledge(),
      this.getCultureKnowledge(),
    ]);
  }

  //获取书法知识
  async getRecommendKnowledge(){
    await InformationService.getKnowledge(this.search, '推荐', 1)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.recommendKnowledge = knowledge
        this.ifConnect = true
        console.log('test', this.recommendKnowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

  //获取书法知识
  async getBiographyKnowledge(){
    await InformationService.getKnowledge(this.search, '人物传记', 1)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.biographyKnowledge = knowledge
        this.ifConnect = true
        console.log('test', this.biographyKnowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

  //获取书法知识
  async getHanziKnowledge(){
    await InformationService.getKnowledge(this.search, '汉字', 1)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.HanziKnowledge = knowledge
        this.ifConnect = true
        console.log('test', this.HanziKnowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

  //获取书法知识
  async getFamousWorksKnowledge(){
    await InformationService.getKnowledge(this.search, '名家作品', 1)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.famousWorksKnowledge = knowledge
        this.ifConnect = true
        console.log('test', this.famousWorksKnowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

  //获取书法知识
  async getCultureKnowledge(){
    await InformationService.getKnowledge(this.search, '文化', 1)
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.cultureKnowledge = knowledge
        this.ifConnect = true
        console.log('test', this.cultureKnowledge[0].cover)
      })
      .catch(() => {
        console.log('Tags', '获取书法知识失败')
        // this.ifConnect = false
      })

  }

}