import KnowledgeInfo from  '../viewmodel/KnowledgeInfo'
import VideoInfo from '../viewmodel/VideoInfo'
import VideoListInfo from '../viewmodel/VideoListInfo'
import VideoCollectionInfo from '../viewmodel/VideoCollectionInfo'
import CompetitionInformInfo from '../viewmodel/CompetitionInformInfo'
import ProblemInfo from '../viewmodel/ProblemInfo'
import http from '@ohos.net.http'
import { Http } from '../common/constants/Http'
import VideoContentInfo from  '../viewmodel/VideoContentInfo'
import PreferencesUtil from '../common/utils/PreferencesUtil'

class InformationService{
  baseURL: string =  `${Http.BaseURL}/InformationService`
  Authorization: string = Http.Token

  async getUserToken(){
    this.Authorization = await PreferencesUtil.getPreferenceValue('MyPreferences', 'Token', '') as string
    if (this.Authorization == null) {
      this.Authorization = Http.Token
    }
    console.log('token', 'Init', this.Authorization)
  }

  /**
   * get
   * 获取常用问题
   * @returns 常用问题
   */
  getCommonProblem(): Promise<ProblemInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取常用问题'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCommonProblem`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString(), this.Authorization )

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取首页知识展示
   * @returns 首页知识展示
   */
  getKnowledgeShow(): Promise<KnowledgeInfo[]>{
    return new Promise((resolve, reject) => {
      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getKnowledgeShow`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', '获取首页知识展示成功\n', resp.result.toString(), this.Authorization)

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', '获取首页知识展示失败1', JSON.stringify(resp), this.Authorization)
            reject('获取首页知识展示失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', '获取首页知识展示失败2', JSON.stringify(error))
          reject('获取首页知识展示失败')
        })
    })
  }

  /**
   * get
   * 获取书法知识
   * @param search
   * @returns
   */
  getKnowledge(search: string, type: string, pageNum: number): Promise<KnowledgeInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取书法知识'
      console.log("up", search, type, pageNum, 8)

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getKnowledge/${pageNum}/8`,
        {
          method: http.RequestMethod.GET,
          extraData: { search: search, type: type, pageNum: pageNum, pageSize: 8},//, type: type, pageNum: pageNum, pageSize: 8
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString(), JSON.stringify(resp))

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取首页视频展示列表
   * @returns 首页视频展示
   */
  getVideoShow(): Promise<VideoListInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取首页视频展示列表'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getVideoShow`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取书法教学视频列表
   * @returns
   */
  getTeachingVideo(search: string, pageNum: number): Promise<VideoListInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取书法教学视频列表'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getTeachingVideo/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization},
          extraData: { search: search }
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取单独教学视频
   * @param videoId
   * @returns
   */
  getTeachingSingleVideo(videoId: number): Promise<VideoInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取单独教学视频'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getTeachingSingleVideo/${videoId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { videoId: videoId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取教学视频合集
   * @param videoId
   * @returns
   */
  getTeachingCollectionVideo(videoId: number): Promise<VideoCollectionInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取教学视频合集'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getTeachingCollectionVideo/${videoId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { videoId: videoId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取首页竞赛展示
   * @returns 首页竞赛展示
   */
  getCompetitionShow(): Promise<CompetitionInformInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取首页竞赛展示'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCompetitionShow`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * get
   * 获取竞赛通知
   * @returns
   */
  getCompetition(): Promise<CompetitionInformInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取竞赛通知'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCompetition`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })

    })
  }


  /**
   * get
   * 获取单个竞赛通知
   * @returns
   */
  getCompetitionSingle(competitionId: number): Promise<CompetitionInformInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取单个竞赛通知'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getCompetitionSingle/${competitionId}`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })

    })
  }


  /**
   * get
   * 获取协议
   * @param type
   * @returns
   */
  getAgreement(type: string): Promise<string>{
    return new Promise((resolve, reject) => {
      let title: string = '获取协议'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getAgreement`,
        {
          method: http.RequestMethod.GET,
          extraData: { type: type },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * 获取视频
   * @param videoDetailId
   * @returns
   */
  getVideo(videoDetailId: number): Promise<VideoContentInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取视频'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getVideo/${videoDetailId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { videoDetailId: videoDetailId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }

  /**
   * 获取搜索
   * @param search
   * @returns
   */
  getKnowledgeSearch(search: string): Promise<ResourceStr>{
    return new Promise((resolve, reject) => {
      let title: string = '获取搜索'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSearch`,
        {
          method: http.RequestMethod.GET,
          extraData: { search: search, },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', `${title}失败1`, JSON.stringify(resp))
            reject(`${title}失败`)
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', `${title}失败2`, JSON.stringify(error))
          reject(`${title}失败`)
        })
    })
  }
}

let informationService = new InformationService()

export default informationService as InformationService