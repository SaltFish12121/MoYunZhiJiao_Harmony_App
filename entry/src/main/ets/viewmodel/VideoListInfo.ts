export default class VideoListInfo{
  id: number    //视频ID
  type: string  //视频类型（是否合集）
  title: string //标题
  time: string  //创建时间
  cover: any    //封面

  constructor(id: number ,type: string, title: string, time: string, cover: any) {
    this.id = id
    this.type = type
    this.title=title
    this.time=time
    this.cover=cover
  }
}