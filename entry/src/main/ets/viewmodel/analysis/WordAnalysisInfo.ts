import ExerciseWordRecordInfo from './ExerciseWordRecordInfo'

export default class WordAnalysisInfo{
  id: number    //所练习字的ID
  averageScore: number //平均得分
  exerciseNumber: number[]  //练习次数
  suggest: string //评价建议
  template: any //模板字
  score: number[] //得分
  record: ExerciseWordRecordInfo[] //练习记录


  constructor(id: number, averageScore: number, exerciseNumber: number[], suggest: string, template: any, score: number[], record: ExerciseWordRecordInfo[]) {
    this.id = id
    this.averageScore = averageScore
    this.exerciseNumber = exerciseNumber
    this.suggest = suggest
    this.template = template
    this.score = score
    this.record = record
  }

}