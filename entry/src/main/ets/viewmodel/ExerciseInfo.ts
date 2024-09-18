export default class ExerciseInfo{
  id: number  //作业ID
  type: ExerciseType  //类型
  cutoff: boolean //是否截止
  title: string //标题
  time: string  //创建时间
  cutoffTime: string //截止时间
  score: number //得分
  finish: boolean //是否完成

  constructor(id: number, type: ExerciseType = ExerciseType.schoolExercise, cutoff: boolean = false, title: string, time: string, cutoffTime: string = '', score: number = 0, finish: boolean = true) {
    this.id = id
    this.type=type
    this.cutoff=cutoff
    this.title=title
    this.time=time
    this.cutoffTime = cutoffTime
    this.score=score
    this.finish=finish
  }
}

export enum ExerciseType{
  schoolExercise = '学校作业',
  selfExercise = '自我练习'
}