import SubmitWritingInfo from './SubmitWritingInfo'

export default class CompetitionContentInfo{
  id: number  //展示竞赛ID
  score: number //得分
  rank: number  //排名
  awards: string  //奖项
  comment: string //评语

  submitWriting: SubmitWritingInfo[]  //提交的图

  constructor(id: number = 0, score: number = 0, rank: number = 0, awards: string = '', comment: string = '', submitWriting: SubmitWritingInfo[] = []) {
    this.id = id
    this.score = score
    this.rank = rank
    this.awards = awards
    this.comment = comment
    this.submitWriting = submitWriting
  }

}