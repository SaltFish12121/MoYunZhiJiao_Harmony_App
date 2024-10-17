export default class StrokeInfo{
  stroke: string  //字拆出的笔画
  number: number //笔画得分

  constructor(stroke: string, number: number) {
    this.stroke = stroke
    this.number = number
  }
}