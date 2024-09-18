import WordInfo from '../WordInfo'

export default class ExerciseWordRecordInfo{
  id: number    //练习记录的ID
  title: string //练习标题
  time: string  //练字时间
  score: number //练字得分
  word: WordInfo  //练习的字


  constructor(id: number, title: string, time: string, score: number, word: WordInfo) {
    this.id = id
    this.title = title
    this.time = time
    this.score = score
    this.word = word
  }

}