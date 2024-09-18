export default class WordListInfo{
  id: number    //所练习字的ID
  template: any //模板字

  constructor(id: number, template: any) {
    this.id = id
    this.template = template
  }
}