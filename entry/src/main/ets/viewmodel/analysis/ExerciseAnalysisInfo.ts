export default class ExerciseAnalysisInfo{
  id: number    //用户ID
  frequency: number[] //练习次数
  schoolScore: number[] //学习练习得分
  selfScore: number[] //自我练习得分

  constructor(id: number, frequency: number[], schoolScore: number[], selfScore: number[]) {
    this.id = id
    this.frequency = frequency
    this.schoolScore = schoolScore
    this.selfScore = selfScore
  }

}