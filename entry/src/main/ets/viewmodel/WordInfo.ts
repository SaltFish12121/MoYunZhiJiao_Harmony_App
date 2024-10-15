
export default class WordInfo{
  name: string  //字的名称
  word: any //拆出的字的图
  strokes: any[]  //字拆出的笔画
  strokeNumber: number  //字得分
  templateWord: any //样本字
  comment: string //字的评语

  constructor(name: string, word: any, strokes: any[], strokeNumber: number = 80, templateWord: any = '', comment: string = '') {
    this.name = name;
    this.word = word
    this.strokes = strokes
    this.strokeNumber = strokeNumber
    this.templateWord = templateWord
    this.comment = comment
  }
}