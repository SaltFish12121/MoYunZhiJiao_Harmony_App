import StrokeInfo from './StrokeInfo'

export default class WordInfo{
  name: string  //字的名称
  word: string //拆出的字的图
  strokes: StrokeInfo[]  //字拆出的笔画
  strokeNumber: number  //字得分
  templateWord: string //样本字
  comment: string //字的评语

  constructor(name: string, word: string, strokes: StrokeInfo[], strokeNumber: number = 0, templateWord: string = '', comment: string = '') {
    this.name = name;
    this.word = word
    this.strokes = strokes
    this.strokeNumber = strokeNumber
    this.templateWord = templateWord
    this.comment = comment
  }
}