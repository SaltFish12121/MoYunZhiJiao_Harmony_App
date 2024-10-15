import router from '@ohos.router'
import { HeaderCollect, HeaderTitleCollect } from '../../../common/components/CommonComponents'
import Video_Brief_Introduction from '../../../views/homepage/calligraphy_teaching/Video_Brief_Introduction'
import VideoListInfo from '../../../viewmodel/VideoListInfo'
import VideoCollectionInfo from '../../../viewmodel/VideoCollectionInfo'
import VideoInfo from '../../../viewmodel/VideoInfo'
import LabelInfo from '../../../viewmodel/LabelInfo'
import Video_Catalogue from '../../../views/homepage/calligraphy_teaching/Video_Catalogue'
import InformationService from '../../../service/InformationService'
import VideoContentInfo from  '../../../viewmodel/VideoContentInfo'
import { window } from '@kit.ArkUI'
import Cant_Connect from '../../../views/Cant_Connect'

//书法视频细节
@Entry
@Component
struct TeachingVideoDetailPage {
  @State currentIndex: number = 0
  @State order: ResourceStr = $r('app.media.positive_order')
  private order1: ResourceStr = $r('app.media.inverted_order')
  private temp: ResourceStr = ''

  @State videoSrc: Resource = $rawfile('video1.mp4')
  @State previewUri: Resource = $r('app.media.show_knoledge')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true

  controller: VideoController = new VideoController()


  @State title: string = ''
  @State arr: number[] = []
  @State ifCollect: boolean = false
  @State collectId: number = 0
  @State selectVideoId: number = 0
  @State selectVideoTitle: string = ''

  @State videoContent: VideoContentInfo = new VideoContentInfo(0, this.previewUri, this.videoSrc)
  @State videoList: VideoListInfo = new VideoListInfo(0,'合集','视频','','')
  @State singleVideo: VideoInfo = new VideoInfo(0,'','')
  @State videoCollection: VideoCollectionInfo = new VideoCollectionInfo(0,new LabelInfo(''),'',[])
  @State sonVideo: VideoInfo[] = [new VideoInfo(0, '', '')]

  @State xComponentWidth: number | string = 0;
  @State xComponentHeight: number | string = 0;

  @State ifConnect: boolean = false

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    if (index == 0){
      Column({space: 8}){
        Text(title)
          .fontSize(14)
          .fontColor(this.selectColor(index))

        Divider()
          .color(this.selectColor(index))
          .width(40)
          .strokeWidth(4)
      }
    }
    else {
      Row(){
        Column({space: 8}){
          Text(title)
            .fontSize(14)
            .fontColor(this.selectColor(index))

          Divider()
            .color(this.selectColor(index))
            .width(40)
            .strokeWidth(4)
        }

        if (this.currentIndex == 1) {
          Column(){
            Image(this.order)
              .width(24)
          }
          .onClick(() => {
            this.temp = this.order
            this.order = this.order1
            this.order1 = this.temp

            this.arr.reverse()
            this.sonVideo.reverse()

            if (this.sonVideo.length>0) {
              console.log(`${this.sonVideo[0].title}`)
            }

          })

        }

      }
      .margin({left: 40})
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .width('70%')
    }

  }

  selectColor(index: number){
    return this.currentIndex === index ? $r('app.color.blue') : $r('app.color.light_black')
  }

  build() {
    Column(){
      //1 头部
      if(this.videoList.type == '单独') {
        HeaderCollect({ ifCollect: $ifCollect, collectId: $collectId, type: 'Video' })
      } else {
        HeaderTitleCollect({ ifCollect: $ifCollect, title: $title, collectId: $collectId, type: 'VideoCollection' })
      }


      //2 知识内容
      Column({space: 10}){

        if (this.videoList.type == '单独') {
          Text(this.singleVideo.title)
            .fontSize(36)
        } else {
          Text(this.selectVideoTitle)
            .fontSize(36)
        }


        Column(){
          // Text('这是视频主体')

          Video({
            src: this.videoContent.contentUrl,  //内容
            previewUri: this.videoContent.coverUrl, //封面
            currentProgressRate: this.curRate,  //播放速度
            controller: this.controller
          }).width('100%').height(200)
            .autoPlay(this.isAutoPlay)
            .controls(this.showControls)
            .onStart(() => {
              console.info('onStart')
            })
            .onPause(() => {
              console.info('onPause')
            })
            .onFinish(() => {
              console.info('onFinish')
            })
            .onError(() => {
              console.info('onError')
            })
            .onPrepared((e) => {
              console.info('onPrepared is ' + e.duration)
            })
            .onSeeking((e) => {
              console.info('onSeeking is ' + e.time)
            })
            .onSeeked((e) => {
              console.info('onSeeked is ' + e.time)
            })
            .onUpdate((e) => {
              console.info('onUpdate is ' + e.time)
            })
            .onFullscreenChange((ifFull) => {
              console.info('onFullscreenChange', ifFull.fullscreen)
              //让屏幕横屏
              if (ifFull.fullscreen) {
                this.setR(2)
              } else {
                this.setR(1)
              }
            })

        }
        .width('90%')
        .height(200)
        .backgroundColor($r('app.color.light_gray'))


        if(this.videoList.type == '单独') {

          if (this.ifConnect) {
            Video_Brief_Introduction({ video: $singleVideo})
          } else {
            Cant_Connect()
          }


        } else {
          Column(){

            Tabs({barPosition: BarPosition.Start}){
              //简介
              TabContent(){
                if (this.ifConnect) {
                  Video_Brief_Introduction({ video: $videoCollection})
                }
              }.tabBar(this.TabBarBuilder('简介', 0))

              //目录
              TabContent(){
                Video_Catalogue({ sonVideo: $sonVideo, arr: $arr, selectVideoId: $selectVideoId, selectVideoTitle: $selectVideoTitle, videoContent: $videoContent })
              }.tabBar(this.TabBarBuilder('目录', 1))

            }
            .barMode(BarMode.Scrollable)
            .onChange(index => {
              this.currentIndex = index
            })

          }
          .width('100%')
          .height(500)
        }


      }
      .alignItems(HorizontalAlign.Center)

    }
  }

  aboutToAppear(){

  }

  // 设置窗口方向
  setR(orientation: number) {
    window.getLastWindow(getContext(this)).then((win) => {
      win.setPreferredOrientation(orientation).then((data) => {
        console.log('setWindowOrientation: ' + orientation + ' Succeeded. Data: ' + JSON.stringify(data));
      }).catch((err: string) => {
        console.log('setWindowOrientation: Failed. Cause: ' + JSON.stringify(err));
      });
    }).catch((err: string) => {
      console.log('setWindowOrientation: Failed to obtain the top window. Cause: ' + JSON.stringify(err));
    });
  }


  async onPageShow(){

    const params = router.getParams() as PARAMS;

    if (params != undefined) {
      this.videoList = params.video;
      this.title = this.videoList.title

      console.log('videoId', this.videoList.id)
      // this.ifCollect = this.videoList.ifCollect
    }


    // console.log(`title=${this.video_title}`)

    console.log(this.videoList.type)
    if (this.videoList.type == '单独') {
      await this.getTeachingSingleVideo()

      this.getVideo(this.videoList.id)

      this.collectId = this.videoList.id
    } else {
      await this.getTeachingCollectionVideo()

      this.selectVideoId = this.videoCollection.sonVideo[0].id  //默认第一个视频
      this.selectVideoTitle = this.videoCollection.sonVideo[0].title

      console.log('selectVideoId', this.selectVideoId)

      this.getVideo(this.selectVideoId)

      this.collectId = this.videoList.id //合集Id
    }

    console.log('collectId', this.collectId)
  }

  //获取单独教学视频
  getTeachingSingleVideo(){
    InformationService.getTeachingSingleVideo(this.videoList.id)
      .then((singleVideo: VideoInfo) => {
        console.log('Tags', '获取单独教学视频成功', singleVideo.label.name)

        this.singleVideo = singleVideo

        this.ifCollect = this.singleVideo.ifCollect
        this.ifConnect = true
      })
      .catch(() => {
        console.log('Tags', '获取单独教学视频失败')
      })
  }

  //获取教学视频合集
  async getTeachingCollectionVideo(){
    await InformationService.getTeachingCollectionVideo(this.videoList.id)
      .then((videoCollection: VideoCollectionInfo) => {
        console.log('Tags', '获取教学视频合集成功', videoCollection.label.name)

        this.videoCollection = videoCollection

        this.ifCollect = this.videoCollection.ifCollect
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取教学视频合集失败')
      })

    this.sonVideo = this.videoCollection.sonVideo

    for (let index = 0; index < this.sonVideo.length; index++) {
      this.arr[index] = index+1

    }
  }

  //获取视频数据
  async getVideo(id: number){
    await InformationService.getVideo(id)
      .then((video: VideoContentInfo) => {
        console.log('Tags', '获取视频数据成功')

        this.videoContent = video
      })
      .catch((error: string) => {
        console.log('Tags', '获取视频数据失败')
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  video: VideoListInfo
}