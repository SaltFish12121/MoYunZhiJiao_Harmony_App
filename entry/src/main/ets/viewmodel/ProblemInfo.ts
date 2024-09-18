export default class ProblemInfo{
  id: number  //问题编号ID
  type: string  //类型
  title: string //标题
  question: string
  content: string //内容

  constructor(id :number = 0, type: string = '', title: string = '',question: string = '', content: string = '') {
    this.id = id
    this.type=type
    this.title=title
    this.question = question
    this.content=content
  }
}
