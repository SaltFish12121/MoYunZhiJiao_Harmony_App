export default class ExerciseAnalysisInfo{
  id: number    //练习ID
  type: boolean  //练习类型（false：学校练习，true：自我练习）
  name: string    //练习名称
  time: string //练习时间
  score: number //练习得分

  constructor(id: number, type: boolean, name: string, time: string, score: number) {
    this.id = id
    this.type = type
    this.name = name
    this.time = time
    this.score = score
  }

}