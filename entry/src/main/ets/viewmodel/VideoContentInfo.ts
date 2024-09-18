export default class VideoContentInfo {
  id: number
  coverUrl: any
  contentUrl: any

  constructor(id: number, coverUrl: any, contentUrl: any) {
    this.id = id
    this.coverUrl = coverUrl
    this.contentUrl = contentUrl
  }
}