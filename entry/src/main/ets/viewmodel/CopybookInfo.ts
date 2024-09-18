import { TypefaceType } from '../viewmodel/SystemTemplateInfo'

export default class CopybookInfo{
  id: number  //字贴ID
  title: string //标题
  author: string  //作者
  content: any  //内容图片
  typeface: TypefaceType  //字体

  constructor(id: number,title: string, author: string, content: any, typeface: TypefaceType =TypefaceType.KaiTi) {
    this.id = id
    this.title = title
    this.author = author
    this.content = content
    this.typeface = typeface
  }

}
