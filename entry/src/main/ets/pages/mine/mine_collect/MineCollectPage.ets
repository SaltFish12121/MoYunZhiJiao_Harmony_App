import { HeaderTitle } from '../../../common/components/CommonComponents'
import Exercise_Collect from '../../../views/mine/mine_collect/Exercise_Collect'
import Knowledge_Collect from '../../../views/mine/mine_collect/Knowledge_Collect'
import Video_Collect from '../../../views/mine/mine_collect/Video_Collect'
import UserService from '../../../service/UserService'
import CollectInfo from '../../../viewmodel/CollectInfo'
import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import VideoInfo from '../../../viewmodel/VideoListInfo'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'
import Cant_Connect from '../../../views/Cant_Connect'

//我的收藏
@Entry
@Component
struct MineCollectPage {
  @State currentIndex: number = 0

  userId: number = 0
  //练习
  @State exerciseCollect: CollectInfo[] = []
  //知识
  @State knowledgeCollect: KnowledgeInfo[] = []
  //教学
  @State videoCollect: VideoInfo[] = []


  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(14)
        .fontColor($r('app.color.black'))
    }
    .width('100%')
    .height(40)
    .backgroundColor(this.selectColor(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor(index: number){
    return this.currentIndex === index ? $r('app.color.button1') : $r('app.color.gray')
  }

  @State title: string = '我的收藏'

  @State ifConnect1: boolean = false
  @State ifConnect2: boolean = false
  @State ifConnect3: boolean = false

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })


      //2 导航栏
      Tabs({barPosition: BarPosition.Start}){
        //2.1 练习
        TabContent(){
          if (this.ifConnect1) {
            Exercise_Collect({ exerciseCollect: $exerciseCollect})
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder('练习', 0))

        //2.2 文章
        TabContent(){
          if (this.ifConnect2) {
            Knowledge_Collect({ knowledgeCollect: $knowledgeCollect })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder('知识', 1))

        //2.3 视频
        TabContent(){
          if (this.ifConnect3) {
            Video_Collect({ videoCollect: $videoCollect })
          } else {
            Cant_Connect()
          }
        }
        .tabBar(this.TabBarBuilder('教学', 2))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
      })

    }


  }


  async onPageShow(){
    this.userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    this.userId = 31

    //获取练习收藏
    this.getExerciseCollect()

    //获取知识收藏
    this.getKnowledgeCollect()

    //获取教学收藏
    this.getVideoCollect()

  }

  //获取练习收藏
  getExerciseCollect(){

    UserService.getExerciseCollect(1)
      .then((collect: CollectInfo[]) => {
        console.log('Tags', '获取练习收藏成功')

        this.exerciseCollect = collect
        this.ifConnect1 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取练习收藏失败')
        this.ifConnect1 = false
      })

  }

  //获取知识收藏
  async getKnowledgeCollect(){

    await UserService.getKnowledgeCollect(1)
      .then((collect: KnowledgeInfo[]) => {
        console.log('Tags', '获取知识收藏成功')

        this.knowledgeCollect = collect
        this.ifConnect2 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取知识收藏失败')
        this.ifConnect2 = false
      })

  }

  //获取教学收藏
  async getVideoCollect(){

    await UserService.getVideoCollect(1)
      .then((collect: VideoInfo[]) => {
        console.log('Tags', '获取个人视频收藏成功')

        this.videoCollect = collect
        this.ifConnect3 = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人视频收藏失败', error)
        this.ifConnect3 = false
      })

  }
}