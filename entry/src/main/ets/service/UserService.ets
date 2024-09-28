import MessageInfo from '../viewmodel/MessageInfo'
import UserInfo from '../viewmodel/user/UserInfo'
import CollectInfo from '../viewmodel/CollectInfo'
import ExcellentWorkInfo from '../viewmodel/ExcellentWorkInfo'
import KnowledgeInfo from '../viewmodel/KnowledgeInfo'
import VideoListInfo from '../viewmodel/VideoListInfo'
import FeedbackInfo from '../viewmodel/FeedbackInfo'
import ExerciseAnalysisInfo from '../viewmodel/analysis/ExerciseAnalysisInfo'
import WordAnalysisInfo from '../viewmodel/analysis/WordAnalysisInfo'
import WordAnalysisListInfo from '../viewmodel/analysis/WordAnalysisListInfo'
import http from '@ohos.net.http'
import PreferencesUtil from '../common/utils/PreferencesUtil'
import { Http } from '../common/constants/Http'

class UserService{
  baseURL: string = `${Http.BaseURL}/UserService`
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
   * 获取个人基本信息
   * @param userId
   * @returns 个人基本信息
   */
  getPersonal(): Promise<UserInfo>{
    return new Promise(async(resolve, reject) => {
      let title: string = '获取个人基本信息'
      console.log('token', 'getPersonal', this.Authorization)

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getPersonal`,
        {
          method: http.RequestMethod.GET,
          // extraData: { userId: userId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result.toString(), this.Authorization, 'end')

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
   * 获取个人练习收藏信息
   * @param userId
   * @returns 个人收藏信息
   */
  getExerciseCollect(pageNum: number): Promise<CollectInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取个人练习收藏信息'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExerciseCollect/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`,  resp.result.toString())

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
   * 获取个人知识收藏
   * @param userId
   * @returns
   */
  getKnowledgeCollect(pageNum: number): Promise<KnowledgeInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取个人知识收藏'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getKnowledgeCollect/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          // extraData: { pageNum: pageNum },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`,  resp.result.toString())

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
   * 获取个人视频收藏
   * @param userId
   * @returns
   */
  getVideoCollect(pageNum: number): Promise<VideoListInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取个人视频收藏'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getVideoCollect/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          extraData: { pageNum: pageNum },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`,  resp.result.toString())

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
   * 获取个人消息
   * @param userId
   * @param messageType
   * @returns 个人消息
   */
  getMineMessage(messageType: number, pageNum: number): Promise<MessageInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取个人消息'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getMineMessage/${messageType}/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          // extraData: { messageType: messageType, pageNum: pageNum },
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
   * 获取个人意见反馈记录
   * @param userId
   * @returns 个人意见反馈记录
   */
  getMineFeedback(): Promise<FeedbackInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取个人意见反馈记录'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getMineFeedback`,
        {
          method: http.RequestMethod.GET,
          // extraData: { userId: userId },
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
   * 获取练习总体分析
   * @param userId
   * @returns
   */
  getExerciseAnalysis(): Promise<ExerciseAnalysisInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取练习总体分析'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExerciseAnalysis`,
        {
          method: http.RequestMethod.GET,
          // extraData: { userId: userId },
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
   * 获取单字练习分析
   * @param userId
   * @param wordId
   * @returns
   */
  getSingleWordAnalysis(wordId: number): Promise<WordAnalysisInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取单字练习分析'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSingleWordAnalysis/${wordId}`,
        {
          method: http.RequestMethod.GET,
          // extraData: { userId: userId },
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
   * 获取样本分析字列表
   * @param userId
   * @param radical
   * @param structure
   * @param typeface
   * @returns
   */
  getWordAnalysisList(search: string, radical: string, structure: string, typeface: string, pageNum: number): Promise<WordAnalysisListInfo[]> {
    return new Promise((resolve, reject) => {
      let title: string = '获取样本分析字列表'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getWordAnalysisList/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          extraData: { search: search, radical: radical, structure: structure, typeface: typeface },
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
   * post
   * 修改用户名
   * @param userId
   * @param newName
   * @returns
   */
  alterUserName(userId: number, newName: string): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '修改用户名'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterUserName`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, newName: newName },
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
   * post
   * 修改性别
   * @param userId
   * @param gender
   * @returns
   */
  alterGender(userId: number, gender: string): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '修改性别'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterGender`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, gender: gender },
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
   * post
   * 修改头像
   * @param userId
   * @param avatar
   * @returns
   */
  alterAvatar(userId: number, avatar: ResourceStr): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '修改头像'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterAvatar`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, avatar: avatar },
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
   * post
   * 修改邮箱
   * @param userId
   * @param email
   * @returns
   */
  alterEmail(userId: number, email: string): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '修改邮箱'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterEmail`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, email: email },
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
   * post
   * 修改电话号
   * @param userId
   * @param newPhoneNumber
   * @returns
   */
  alterPhoneNumber(userId: number, newPhoneNumber: string): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '修改电话号'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterPhoneNumber`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, newPhoneNumber: newPhoneNumber },
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
   * post
   * 修改密码
   * @param userId
   * @param oldPassword
   * @param newPassword
   * @returns 是否修改成功（成功，密码与之前相同）
   */
  alterPassword(userId: number, oldPassword: string, newPassword: string): Promise<ReturnResult>{
    return new Promise((resolve, reject) => {
      let title: string = '修改密码'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/alterPassword`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, oldPassword: oldPassword, newPassword: newPassword },
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
   * post
   * 上传意见反馈
   * @param userId
   * @param content
   * @returns
   */
  uploadFeedback(userId: number, content: string, type: string): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '上传意见反馈'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/uploadFeedback`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, content: content, type: type },
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
   * post
   * 更新收藏
   * @param userId
   * @param collectType
   * @param collectId
   * @param newCollect
   * @returns
   */
  updateCollect(userId: number, collectId: number, collectType: string, newCollect: boolean): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '更新收藏'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/updateCollect`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, collectType: collectType, collectId: collectId, newCollect: newCollect },
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

let userService = new UserService()

export default userService as UserService


class ReturnResult{
  success: boolean
  message: string

  constructor(success: boolean, message: string) {
    this.success = success
    this.message = message
  }
}