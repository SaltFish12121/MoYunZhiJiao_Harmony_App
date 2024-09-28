export default class ExerciseAnalysisInfo{
  id: number    //用户ID
  frequency: number[] //练习次数
  score: number[] //练习得分

  constructor(id: number, frequency: number[], score: number[]) {
    this.id = id
    this.frequency = frequency
    this.score = score
  }

}