import SubmitWritingInfo from '../viewmodel/exerciseDetial/SubmitWritingInfo'

export default class CompetitionDetailInfo{
  id: number  //竞赛ID
  title: string         //标题
  startTime: string     //答题开始时间
  finishTime: string       //答题截止时间

  typeface: string  //字体
  require: string //要求
  example: any  //样例
  submit: SubmitWritingInfo[] //提交内容

  score: number //得分
  rank: number  //排名
  award: string //奖项
  comment: string //评语
  ifCollect: boolean  //是否收藏

  constructor(id: number, title: string = '', startTime: string = '', finishTime: string = '',
              typeface: string,require: string, example: any, submit: SubmitWritingInfo[] = [],
              score: number = 0, rank: number = 0, award: string = '', comment: string = '', ifCollect: boolean = false)
  {
    this.id = id
    this.title=title
    this.startTime=startTime
    this.finishTime=finishTime

    this.typeface = typeface
    this.require = require
    this.example = example
    this.submit = submit

    this.score=score
    this.rank = rank
    this.award = award
    this.comment = comment
    this.ifCollect = ifCollect
  }
}