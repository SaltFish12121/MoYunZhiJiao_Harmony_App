import router from '@ohos.router'
import { HeaderSearch, HeaderTitle } from '../../../common/components/CommonComponents'
import { CommonConstants } from '../../../common/constants/CommonConstants'
import VideoItem from '../../../viewitem/VideoItem'
import VideoInfo from '../../../viewmodel/VideoListInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import InformationService from  '../../../service/InformationService'

@Extend(GridCol) function video_List(){
  .borderRadius(CommonConstants.DEFAULT_10)
  .backgroundColor(Color.White)
  .borderColor($r('app.color.text_gray'))
  .borderWidth(1)
  .height(200)
}

@Entry
@Component
struct CalligraphyTeachingPage {
  @State title: string = '书法教学'
  @State search: string = ''
  @State pageNum: number = 1

  isLoading: boolean = false//是否正在加载
  isMore: boolean = true//是否有更多数据

  @State video: VideoInfo[] = [
    new VideoInfo(1, '', '楷书的教学视频1', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(2, '', '楷书的教学视频2', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(3, '','楷书的教学视频3', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(4, '','楷书的教学视频4', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(5, '','楷书的教学视频5', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(6, '','楷书的教学视频6', '2024-4-10', $r('app.media.show_knoledge')),
    new VideoInfo(7, '','楷书的教学视频7', '2024-4-10', $r('app.media.show_knoledge'))
  ]
  /*
  @State video: VideoInfo[] = [
    new VideoInfo(1,'楷书的教学视频1', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书叔'),
      new LabelInfo('教育'),
      new LabelInfo('学习'),
      new LabelInfo('横折练习'),
      new LabelInfo('弯钩'),
      new LabelInfo('撇捺'),
      new LabelInfo('笔画'),
    ]),
    new VideoInfo(2,'楷书的教学视频2', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo(3,'楷书的教学视频3', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo(4,'楷书的教学视频4', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo(5,'楷书的教学视频5', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo(6,'楷书的教学视频6', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ]),
    new VideoInfo(7,'楷书的教学视频7', '2024-4-10', $r('app.media.show_knoledge'), [
      new LabelInfo('楷书'),
      new LabelInfo('基础')
    ])
  ]
  */
  scroller: Scroller = new Scroller()

  build(){
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
            this.pageNum = 1
            this.isMore = true
            await this.getTeachingVideo1()

            // 点击后回到顶部
            this.scroller.scrollEdge(Edge.Top)
          })
      }

      //2.视频 排列??
      /*
      Scroll(this.scroller){
        Column(){
          Column(){

          }
          .height(5)

          GridRow({
            columns: 2,
            gutter: { x: 5, y: 10 },
            breakpoints: { value: ["400vp", "600vp", "800vp"],
              reference: BreakpointsReference.WindowSize },
            direction: GridRowDirection.Row
          }) {

            ForEach(
              this.video ,
              (video: VideoInfo) => {
                GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {

                  VideoItem({ video: video })

                }
                .video_List()


              }
            )


          }
          .width("98%")
          .onBreakpointChange((breakpoint) => {
            // this.currentBp = breakpoint
            // console.log(`this==${this.currentBp}`)
          })

          Column(){

          }
          .height(150)

        }
        .margin({top: 5})


      }
      .width('100%')
      .onScrollStart(() => {
        console.log('触顶！')

        this.pageNum = 1
        this.getTeachingVideo1()
      })
      .onReachEnd(() => {
        console.log('触底了！')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getTeachingVideo2()
        }
      })
      */

      //2.视频 排列
      List({ scroller: this.scroller}) {
        ListItem() {}
        .height(5)

        ListItem() {
          GridRow({
            columns: 2,
            gutter: { x: 5, y: 10 },
            breakpoints: { value: ["400vp", "600vp", "800vp"], reference: BreakpointsReference.WindowSize },
            direction: GridRowDirection.Row
          }) {
            ForEach(this.video, (video: VideoInfo) => {
              GridCol({ span: { xs: 1, sm: 2, md: 3, lg: 4 } }) {
                VideoItem({ video: video })
              }
              .video_List()
            })
          }
          .width("98%")
          .onBreakpointChange((breakpoint) => {
            // this.currentBp = breakpoint
            // console.log(`this==${this.currentBp}`)
          })

        }

        ListItem()
          .height(150)

      }
      .margin({ top: 5 })
      .width('100%')
      .onReachStart(() => {
        console.log('触顶！')
        this.pageNum = 1
        this.isMore = true
        this.getTeachingVideo1()
      })
      .onReachEnd(() => {
        console.log('触底了！')
        if (!this.isLoading && this.isMore) {
          this.isLoading = true
          // 翻页
          this.pageNum++
          // page = ShopModel.pageNo
          this.getTeachingVideo2()
        }
      })

    }

  }

  onPageShow(){
    //获取书法教学
    this.getTeachingVideo1()
  }

  //获取书法教学
  async getTeachingVideo1(){//测试
    console.log('pageNum', this.pageNum)
    await InformationService.getTeachingVideo(this.search, this.pageNum)
      .then((video: VideoInfo[]) => {
        console.log('Tags', 'show', '获取书法教学视频成功')

        this.video = video

        console.log('test', this.video[0].cover)
      })
      .catch((error: string) => {
        console.log('Tags', 'show', '获取书法教学视频失败', error)
      })

  }

  //获取书法教学2
  async getTeachingVideo2(){
    console.log('pageNum', this.pageNum)
    await InformationService.getTeachingVideo(this.search, this.pageNum)
      .then((video: VideoInfo[]) => {
        console.log('Tags', 'show', '获取书法教学视频成功')

        //拼接
        this.video = this.video.concat(video)
        this.isLoading = false
        if(!video || video.length === 0){
          this.isMore = false
        }

        console.log('test', this.video[0].cover)
      })
      .catch((error: string) => {
        console.log('Tags', 'show', '获取书法教学视频失败', error)
      })

  }

}