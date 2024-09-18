export default class CompetitionInfo{
  id: number  //竞赛ID
  ifSignUp: IfSignUpType //类型(是否报名)
  type: CompetitionType //类型（当前类型）
  title: string         //标题
  startTime: string     //答题开始时间
  finishTime: string       //答题截止时间
  score: number         //得分

  constructor(id: number ,ifSignUP: IfSignUpType = IfSignUpType.unSignUp, type: CompetitionType = CompetitionType.unSubmit, title: string = '', startTime: string = '', finishTime: string = '', score: number = 0) {
    this.id = id
    this.ifSignUp=ifSignUP
    this.type=type
    this.title=title
    this.startTime=startTime
    this.finishTime=finishTime
    this.score=score
  }
}

export enum IfSignUpType{
  unSignUp = '未报名',
  SignUp = '已报名'
}

export enum CompetitionType{
  submit = '已提交',
  unSubmit = '未提交',
  cutOff = '已截止',
  unCutOff = '未截止',
  finish = '结束'
}