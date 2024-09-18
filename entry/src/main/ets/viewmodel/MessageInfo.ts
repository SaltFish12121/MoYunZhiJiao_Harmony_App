export default class MessageInfo{
  id: number  //消息ID
  type: MessageType //消息类型
  title: string //标题
  time: string  //时间
  content: string //内容

  constructor(id: number, type: MessageType, title: string, time: string, content: string) {
    this.id = id
    this.type=type
    this.title=title
    this.time=time
    this.content=content
  }
}

export enum MessageType{
  system = '系统消息',
  homeworkPost = '作业发布',
  homeworkRemind = '作业提醒',
  competition = '竞赛通知'
}

export const  messages: MessageInfo[] = [
  new MessageInfo(0,MessageType.system,'信息设置','2024-5-24','123'),
  new MessageInfo(0,MessageType.system,'信息设置1','2024-5-242','122')
]