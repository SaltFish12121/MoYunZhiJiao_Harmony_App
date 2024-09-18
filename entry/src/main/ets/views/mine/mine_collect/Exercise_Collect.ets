import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import ExerciseItem from '../../../viewitem/ExerciseItem'
import CollectInfo from '../../../viewmodel/CollectInfo'
import { CollectType } from '../../../viewmodel/CollectInfo'
import Excellent_Collect from './exercise_collect/Excellent_Collect'
import School_Collect from './exercise_collect/School_Collect'
import Self_Collect from './exercise_collect/Self_Collect'
import ExcellentWorkInfo from '../../../viewmodel/ExcellentWorkInfo'
import ExerciseCollectItem from '../../../viewitem/collect/ExerciseCollectItem'
import UserService from '../../../service/UserService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Extend(ListItem) function exercise_List(){
  .width('95%')
  .borderRadius(CommonConstants.DEFAULT_10)
  .shadow({
    radius: 6,
    color: "#000000",
    offsetX: 0,
    offsetY: 2,
  })
}

@Component
export default struct Exercise_Collect {
  @Link exerciseCollect: CollectInfo[]
  @State pageNum: number = 1
  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  build() {
    Column(){
      //作业列表
      List({space: 10}){
        ListItem(){

        }
        .height(5)

        ForEach(
          this.exerciseCollect,
          (exercise: CollectInfo) => {
            ListItem() {
              ExerciseCollectItem({ exercise: exercise })
            }
            .exercise_List()
            .onClick(() => {
              if (exercise.type == CollectType.schoolExercise ) {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_school/SchoolFinishPage',
                    params: {
                      ifSuccess: 1,
                      id: exercise.id,
                      title: exercise.title
                    }
                  }
                )
              } else if (exercise.type == CollectType.selfExercise) {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_self/SelfFinishPage',
                    params: {
                      ifSuccess: 1,
                      id: exercise.id,
                      title: exercise.title
                    }
                  }
                )
              } else if (exercise.type == CollectType.excellentSchoolExercise) {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentHomeworkPage',
                    params: {
                      ifSuccess: 1,
                      id: exercise.id,
                      title: exercise.title
                    }
                  }
                )
              } else {
                router.pushUrl(
                  {
                    url: 'pages/exercise/exercise_excellentWorks/ExcellentCompetitionWorksPage',
                    params: {
                      ifSuccess: 1,
                      id: exercise.id,
                      title: exercise.title
                    }
                  }
                )
              }


            })

          }
        )




        ListItem()
          .height(100)

      }
      .alignListItem(ListItemAlign.Center)
      .listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        // console.info('first' + firstIndex)
        // console.info('last' + lastIndex)
      })
      .width('100%')
      .onReachStart(() => {
        console.log('触顶')

        this.pageNum = 1
        this.getExerciseCollect2()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getExerciseCollect()
        }
      })

    }
    .align(Alignment.Top)
    .height('100%')

  }

  //获取练习收藏
  async getExerciseCollect(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getExerciseCollect(userId, this.pageNum)
      .then((collect: CollectInfo[]) => {
        console.log('Tags', '获取练习收藏成功')

        //拼接
        this.exerciseCollect = this.exerciseCollect.concat(collect)
        this.isLoading = false
        if(!collect || collect.length === 0){
          this.isMore = false
        }
      })
      .catch((error: string) => {
        console.log('Tags', '获取练习收藏失败')
      })

  }

  //获取练习收藏
  async getExerciseCollect2(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getExerciseCollect(userId, this.pageNum)
      .then((collect: CollectInfo[]) => {
        console.log('Tags', '获取练习收藏成功')

        this.exerciseCollect = collect

      })
      .catch((error: string) => {
        console.log('Tags', '获取练习收藏失败')
      })

  }
}

