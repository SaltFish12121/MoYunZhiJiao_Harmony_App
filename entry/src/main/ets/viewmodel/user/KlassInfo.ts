export default class KlassInfo{
  id: number  //班级id
  name: string  //班级名
  school: string  //学校
  grade: string //年级
  teacher: string //教师

  constructor(id: number = 0, name: string = '', school: string = '', grade: string = '', teacher: string = '') {
    this.id = id
    this.name = name
    this.school = school
    this.grade = grade
    this.teacher = teacher
  }
}