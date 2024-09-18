export default class SelfUnfinishExerciseDetailInfo{
  id: number  //练习ID
  title: string //标题
  ifCollect: boolean  //是否收藏

  typeface: string  //字体

  require: string //要求
  example: any  //样例
  submit: any[] //提交的图


  constructor(id: number, title: string, ifCollect: boolean,
              typeface: string,
              require: string, example: any, submit: any[],
  ) {
    this.id = id
    this.title=title
    this.ifCollect = ifCollect

    this.typeface = typeface

    this.require = require
    this.example = example
    this.submit = submit

  }
}