export default class ExcellentWorkInfo{
  id: number  //优秀作品ID
  type: WorkType //优秀作品类型
  come: string  //来源
  title: string //标题
  time: string  //创建时间

  constructor(id: number, type: WorkType, come: string, title: string, time: string) {
    this.id = id
    this.type=type
    this.come=come
    this.title=title
    this.time=time
  }
}

export enum WorkType{
  schoolWork = '学校作品',
  competitionWork = '竞赛作品'
}