export default class WordListInfo{
  id: number    //所练习字的ID
  template: string //模板字
  name: string

  constructor(id: number, template: string, name: string) {
    this.id = id
    this.template = template
    this.name = name
  }
}