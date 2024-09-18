export default class CollectInfo{
  id: number  //收藏练习ID
  type: CollectType //类型
  title: string //标题
  time: string  //时间

  constructor(id: number, type: CollectType = CollectType.schoolExercise, title: string, time: string) {
    this.id=id
    this.type=type
    this.title=title
    this.time=time
  }
}

export enum CollectType{
  schoolExercise = '学校作业',
  selfExercise = '自我练习',
  excellentSchoolExercise = '优秀学校作品',
  excellentCompetitionExercise = '优秀竞赛作品'
}