export default class CompetitionInformInfo{
  id: number  //竞赛ID
  type: boolean //竞赛类型（本/其他）
  title: string //竞赛标题
  time: string  //创建时间
  cover: any    //封面
  content: string //内容

  constructor(id: number, type: boolean = false, title: string = '', time: string = '', cover: any = '', content: string = '') {
    this.id = id
    this.type=type
    this.title=title
    this.time=time
    this.cover=cover
    this.content=content
  }
}
