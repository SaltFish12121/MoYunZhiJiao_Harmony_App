
export default class SchoolUnfinishExerciseDetailInfo{
  id: number  //练习ID
  title: string //标题
  exerciseType: string  //作业类型（个人/集体）
  ifCollect: boolean  //是否收藏

  difficulty: number  //难度
  wordNumber: number  //字数
  typeface: string  //字体
  type: string  //类型
  cutoffTime: string  //截止时间

  require: string //要求
  example: any  //样例
  submit: any[] //提交的图

  cutoff: boolean

  constructor(id: number, title: string, exerciseType: string, ifCollect: boolean,
              difficulty: number, wordNumber: number, typeface: string, type: string, cutoffTime: string,
              require: string, example: any, submit: any[], cutoff: boolean = false
              ) {
    this.id = id
    this.title=title
    this.exerciseType = exerciseType
    this.ifCollect = ifCollect

    this.difficulty = difficulty
    this.wordNumber = wordNumber
    this.typeface = typeface
    this.type=type
    this.cutoffTime = cutoffTime

    this.require = require
    this.example = example
    this.submit = submit

    this.cutoff = cutoff
  }

}