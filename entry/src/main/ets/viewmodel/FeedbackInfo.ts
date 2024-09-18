
export default class FeedbackInfo{
  id: number  //反馈ID编号
  type: string  //类型
  content: string //反馈内容
  time: string  //反馈时间
  feedback: string  //反馈回复

  constructor(id: number = 0, type: string = '', content: string = '', time: string = '', feedback = '暂未回复') {
    this.id = id
    this.type = type
    this.time=time
    this.content=content
    this.feedback = feedback
  }
}