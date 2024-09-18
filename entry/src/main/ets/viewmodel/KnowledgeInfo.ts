export default class KnowledgeInfo{
  id: number            //ID 编号
  type: KnowledgeType   //知识类型
  ifRecommend: boolean  //是否为推荐知识
  title: string         //标题
  viewNumber: number    //观看数量
  time: string          //创建时间
  cover: any    //封面
  content: string
  ifCollect: boolean

  constructor(id: number ,type: KnowledgeType = KnowledgeType.biography, ifRecommend: boolean = false ,title: string = '',viewNumber: number = 0,time: string = '',cover: any = '', content: string = '', ifCollect: boolean = false) {
    this.id = id
    this.type=type
    this.ifRecommend=ifRecommend
    this.title=title
    this.viewNumber=viewNumber
    this.time=time
    this.cover=cover
    this.content = content
    this.ifCollect = ifCollect
  }
}

export enum KnowledgeType{
  biography = '人物传记',
  famousWorks = '名家作品',
  Hanzi = '汉字',
  culture = '文化'
}

// class test{
//   cover: ResourceStr
// }