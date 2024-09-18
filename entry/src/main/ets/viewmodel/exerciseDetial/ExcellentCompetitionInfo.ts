import CompetitionContentInfo from './CompetitionContentInfo'

export default class ExcellentCompetitionInfo {
  id: number  //收藏ID
  title: string //标题
  comeFrom: string  //来源
  ifCollect: boolean  //是否收藏

  content: CompetitionContentInfo[]  //竞赛展示

  constructor(id: number, title: string, comeFrom: string, ifCollect: boolean,
              content: CompetitionContentInfo[]) {
    this.id = id
    this.title=title
    this.comeFrom = comeFrom
    this.ifCollect = ifCollect

    this.content = content
  }

}

