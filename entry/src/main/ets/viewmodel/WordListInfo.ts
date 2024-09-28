export default class WordListInfo{
  id: number    //所练习字的ID
  template: any //模板字
  name: string

  constructor(id: number, template: any, name: string) {
    this.id = id
    this.template = template
    this.name = name
  }
}