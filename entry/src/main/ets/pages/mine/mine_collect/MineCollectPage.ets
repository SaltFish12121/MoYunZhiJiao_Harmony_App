import { HeaderTitle } from '../../../common/components/CommonComponents'
import Exercise_Collect from '../../../views/mine/mine_collect/Exercise_Collect'
import Knowledge_Collect from '../../../views/mine/mine_collect/Knowledge_Collect'
import Video_Collect from '../../../views/mine/mine_collect/Video_Collect'
import UserService from '../../../service/UserService'
import ExerciseInfo from '../../../viewmodel/ExerciseInfo'
import { ExerciseType } from '../../../viewmodel/ExerciseInfo'
import CollectInfo from '../../../viewmodel/CollectInfo'
import { CollectType } from '../../../viewmodel/CollectInfo'
import ExcellentWorkInfo from '../../../viewmodel/ExcellentWorkInfo'
import { WorkType } from '../../../viewmodel/ExcellentWorkInfo'
import KnowledgeInfo from '../../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../../viewmodel/KnowledgeInfo'
import VideoInfo from '../../../viewmodel/VideoListInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Entry
@Component
struct MineCollectPage {
  @State currentIndex: number = 0

  userId: number = 0
  //练习
  @State exerciseCollect: CollectInfo[] = [
    new CollectInfo(0,CollectType.schoolExercise, '笔画练习（一）', '2024-3-3'),
    new CollectInfo(0,CollectType.schoolExercise, '将进酒', '2024-3-2'),
    new CollectInfo(0,CollectType.selfExercise, '基础笔画练习(2)', '2024-3-3'),
    new CollectInfo(0,CollectType.selfExercise, '基础笔画练习(1)', '2024-3-2'),
    new CollectInfo(0,CollectType.excellentSchoolExercise, '横折练习', '2024-3-3'),
    new CollectInfo(0,CollectType.excellentCompetitionExercise, '第一次书法竞赛', '2024-3-3')

  ]
  //知识
  @State knowledgeCollect: KnowledgeInfo[] = [
    new KnowledgeInfo(0,KnowledgeType.Hanzi, true , '汉字的演变过程', 666, '2024-4-10', $r('app.media.show_knoledge')),
    new KnowledgeInfo(0,KnowledgeType.famousWorks, false , '《洛神赋十三行》王献之', 666, '2024-4-10', $r('app.media.show_knoledge'))
  ]
  //教学
  @State videoCollect: VideoInfo[] = [
    new VideoInfo(0, '', '楷书的教学视频1', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频2', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频3', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频4', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频5', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频6', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(0, '', '楷书的教学视频7', '2024-4-10', $r('app.media.show_knoledge'))
  ]


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

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })


      //2导航栏
      Tabs({barPosition: BarPosition.Start}){
        //1.练习
        TabContent(){
          // Text('练习')
          Exercise_Collect({ exerciseCollect: $exerciseCollect})
        }
        .tabBar(this.TabBarBuilder('练习', 0))

        //2.文章
        TabContent(){
          // Text('文章')
          Knowledge_Collect({ knowledgeCollect: $knowledgeCollect })
        }
        .tabBar(this.TabBarBuilder('知识', 1))

        //3.视频
        TabContent(){
          // Text('视频')
          Video_Collect({ videoCollect: $videoCollect })
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

    UserService.getExerciseCollect(this.userId, 1)
      .then((collect: CollectInfo[]) => {
        console.log('Tags', '获取练习收藏成功')

        this.exerciseCollect = collect
      })
      .catch((error: string) => {
        console.log('Tags', '获取练习收藏失败')
      })

  }

  //获取知识收藏
  async getKnowledgeCollect(){

    await UserService.getKnowledgeCollect(this.userId, 1)
      .then((collect: KnowledgeInfo[]) => {
        console.log('Tags', '获取知识收藏成功')

        this.knowledgeCollect = collect
      })
      .catch((error: string) => {
        console.log('Tags', '获取知识收藏失败')
      })

    // this.change(this.knowledgeCollect)
  }

  //获取教学收藏
  async getVideoCollect(){

    await UserService.getVideoCollect(this.userId, 1)
      .then((collect: VideoInfo[]) => {
        console.log('Tags', '获取个人视频收藏成功')

        this.videoCollect = collect
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人视频收藏失败', error)
      })

    // this.change(this.videoCollect)
  }
}