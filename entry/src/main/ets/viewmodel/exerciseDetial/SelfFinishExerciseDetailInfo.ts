import SubmitWritingInfo from './SubmitWritingInfo'

export default class SelfFinishExerciseDetailInfo{
  id: number  //练习ID
  title: string //标题
  ifCollect: boolean  //是否收藏

  typeface: string  //字体

  example: any  //样例
  submit: SubmitWritingInfo[] //提交的图

  score: number //得分
  systemComment: string //系统评语

  constructor(id: number, title: string, ifCollect: boolean,
              typeface: string,
              example: any, submit: SubmitWritingInfo[],
              score: number, systemComment: string = '') {
    this.id = id
    this.title=title
    this.ifCollect = ifCollect

    this.typeface = typeface

    this.example = example
    this.submit = submit

    this.score = score
    this.systemComment = systemComment
  }

}