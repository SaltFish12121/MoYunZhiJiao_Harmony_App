export default class WordAnalysisListInfo {
  id: number    //所练习字的ID
  averageScore: number //平均得分
  exerciseNumber: number  //练习总次数
  template: any //模板字

  constructor(id: number, averageScore: number, exerciseNumber: number, template: any) {
    this.id = id
    this.averageScore = averageScore
    this.exerciseNumber = exerciseNumber
    this.template = template
  }
}