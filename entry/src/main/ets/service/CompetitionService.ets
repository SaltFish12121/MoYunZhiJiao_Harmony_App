import http from '@ohos.net.http'
import CompetitionInfo from '../viewmodel/CompetitonInfo'
import CompetitionDetailInfo from '../viewmodel/CompetitionDetailInfo'
import { Http } from '../common/constants/Http'

class CompetitionService{
  baseURL: string = `${Http.BaseURL}/CompetitionService`
  Authorization: string = Http.Token

  /**
   * get
   * 获取竞赛
   * @param userId
   * @returns 竞赛
   */
  getCompetition(userId: number, type: string): Promise<CompetitionInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取竞赛'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCompetition`,
        {
          method: http.RequestMethod.GET,
          extraData: { userId: userId, type: type },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log(`${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log(`${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log(`${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取竞赛详情
   * @param exerciseId
   * @returns 竞赛
   */
  getCompetitionDetail(exerciseId: number): Promise<CompetitionDetailInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取竞赛详情'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCompetitionDetail/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { userId: exerciseId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log(`${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log(`${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log(`${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }


  /**
   * post
   * 竞赛报名
   * @param userId
   * @returns
   */
  signUpCompetition(userId: number, competitionId: number): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '竞赛报名'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/signUpCompetition`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, competitionId: competitionId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log(`${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log(`${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log(`${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * post
   * 竞赛提交
   * @param userId
   * @returns
   */
  submitCompetition(userId: number, competitionId: number, content: ResourceStr[]): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '竞赛提交'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/submitCompetition`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, competitionId: competitionId, content: content },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log(`${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log(`${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log(`${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }
}

let competitionService = new CompetitionService()

export default competitionService as CompetitionService