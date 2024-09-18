import router from '@ohos.router'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import VideoInfo from '../../../viewmodel/VideoListInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import VideoCollectItem from '../../../viewitem/collect/VideoCollectItem'
import UserService from '../../../service/UserService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Extend(ListItem) function video_List(){
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
export default struct Video_Collect {
  @Link videoCollect: VideoInfo[]
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
          this.videoCollect,
          (video: VideoInfo) => {
            ListItem() {

              VideoCollectItem({ video: video })

            }
            .video_List()

          }
        )

        ListItem(){

        }
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
      .onReachStart(() => {
        console.log('触顶')
        this.pageNum = 1
        this.getVideoCollect2()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getVideoCollect()
        }
      })
      .width('100%')
      .align(Alignment.Top)
      .height('100%')

    }
  }


  //获取教学收藏
  async getVideoCollect(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await UserService.getVideoCollect(userId, this.pageNum)
      .then((collect: VideoInfo[]) => {
        console.log('Tags', '获取个人视频收藏成功')

        // //拼接
        // this.videoCollect = this.videoCollect.concat(collect)
        // this.isLoading = false
        // if(!collect || collect.length === 0){
        //   this.isMore = false
        // }
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人视频收藏失败', error)
      })

    // this.change(this.videoCollect)
    console.log('change')

    for(let i = 0; i<=this.videoCollect.length; i++){
      this.videoCollect[i].cover = decodeURIComponent(this.videoCollect[i].cover)

      // console.log('change', `${object[i].cover}`)
    }
  }

  //获取教学收藏
  async getVideoCollect2(){
    let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    await UserService.getVideoCollect(userId, this.pageNum)
      .then((collect: VideoInfo[]) => {
        console.log('Tags', '获取个人视频收藏成功')

        // this.videoCollect = collect

      })
      .catch((error: string) => {
        console.log('Tags', '获取个人视频收藏失败', error)
      })

    // this.change(this.videoCollect)
    console.log('change')

    for(let i = 0; i<=this.videoCollect.length; i++){
      this.videoCollect[i].cover = decodeURIComponent(this.videoCollect[i].cover)

      // console.log('change', `${object[i].cover}`)
    }
  }

}