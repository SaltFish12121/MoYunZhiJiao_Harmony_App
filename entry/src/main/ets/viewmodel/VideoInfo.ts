import LabelInfo from '../viewmodel/LabelInfo'

export default class VideoInfo{
  id: number    //视频ID
  title: string //标题
  time: string  //创建时间
  label: LabelInfo[]  //标签
  intro: string //简介
  playTime: string  //播放时长
  playAmount: number  //播放量
  ifCollect: boolean  //是否收藏

  constructor(id: number ,title: string, time: string, label: LabelInfo[]= [], intro: string = '', playTime: string = '', playAmount: number = 0, ifCollect: boolean = false) {
    this.id = id
    this.title=title
    this.time=time
    this.label=label
    this.intro = intro
    this.playTime = playTime
    this.playAmount = playAmount
    this.ifCollect = ifCollect
  }
}
