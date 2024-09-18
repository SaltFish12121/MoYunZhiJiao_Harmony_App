import WordInfo from '../../viewmodel/WordInfo'

export default class SubmitWritingInfo{
  id: number  //提交作业ID
  submit: any //提交的图
  word: WordInfo[][]  //拆出的字

  constructor(id: number, submit: any, word: WordInfo[][] = []) {
    this.id = id
    this.submit = submit
    this.word = word
  }
}