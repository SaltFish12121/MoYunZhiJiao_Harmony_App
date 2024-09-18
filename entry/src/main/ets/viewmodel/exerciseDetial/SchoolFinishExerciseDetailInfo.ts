import SubmitWritingInfo from './SubmitWritingInfo'

export default class SchoolFinishExerciseDetailInfo{
  id: number  //练习ID
  title: string //标题
  exerciseType: string  //作业类型（个人/集体）
  ifCollect: boolean  //是否收藏

  difficulty: number  //难度
  wordNumber: number  //字数
  typeface: string  //字体
  type: string  //类型

  require: string //要求
  example: any  //样例
  submit: SubmitWritingInfo[] //提交的图

  score: number //得分
  systemComment: string //系统评语
  teacherComment: string  //教师评语

  constructor(id: number, title: string, exerciseType: string, ifCollect: boolean,
              difficulty: number, wordNumber: number, typeface: string, type: string,
              require: string, example: any, submit: SubmitWritingInfo[],
              score: number, systemComment: string = '', teacherComment: string = '') {
    this.id = id
    this.title=title
    this.exerciseType = exerciseType
    this.ifCollect = ifCollect

    this.difficulty = difficulty
    this.wordNumber = wordNumber
    this.typeface = typeface
    this.type=type

    this.require = require
    this.example = example
    this.submit = submit

    this.score = score
    this.systemComment = systemComment
    this.teacherComment = teacherComment
  }


}