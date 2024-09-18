import VideoInfo from './VideoInfo'
import LabelInfo from './LabelInfo'

//视频合集
export default class VideoCollectionInfo{
  id: number  //视频合集ID
  label: LabelInfo[]  //标签
  intro: string //简介
  sonVideo: VideoInfo[] //子视频
  ifCollect: boolean  //是否收藏

  constructor(id: number, label: LabelInfo[], intro: string, sonVideo: VideoInfo[], ifCollect: boolean = false) {
    this.id = id
    this.label = label
    this.intro = intro
    this.sonVideo = sonVideo
    this.ifCollect = ifCollect
  }
}