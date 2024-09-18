export default class SystemTemplateInfo{
  id: number  //模板ID
  type: TemplateType  //类型
  title: string //标题
  content: any  //内容图片
  typeface: TypefaceType //字体

  constructor(id: number, type: TemplateType, title: string, content: any, typeface: TypefaceType =TypefaceType.KaiTi) {
    this.id = id
    this.type=type
    this.title = title
    this.content = content
    this.typeface = typeface
  }
}

export enum TemplateType{
  specialType = '专项',
  syntheticType = '综合',
  copybookType = '字帖',
  alreadyType = '已有练习'
}

export enum TypefaceType{
  KaiTi = '楷体'
}