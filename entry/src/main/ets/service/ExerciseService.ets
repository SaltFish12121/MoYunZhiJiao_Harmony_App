import ExerciseInfo from '../viewmodel/ExerciseInfo'
import SchoolFinishExerciseDetailInfo from '../viewmodel/exerciseDetial/SchoolFinishExerciseDetailInfo'
import SchoolUnfinishExerciseDetailInfo from '../viewmodel/exerciseDetial/SchoolUnfinishExerciseDetailInfo'
import SelfFinishExerciseDetailInfo from '../viewmodel/exerciseDetial/SelfFinishExerciseDetailInfo'
import SelfUnfinishExerciseDetailInfo from '../viewmodel/exerciseDetial/SelfUnfinishExerciseDetailInfo'
import ExcellentWorkInfo from '../viewmodel/ExcellentWorkInfo'
import ExcellentHomeworkInfo from '../viewmodel/exerciseDetial/ExcellentHomeworkInfo'
import ExcellentCompetitionInfo from '../viewmodel/exerciseDetial/ExcellentCompetitionInfo'
import SystemTemplateInfo from  '../viewmodel/SystemTemplateInfo'
import CopybookInfo from  '../viewmodel/CopybookInfo'
import WordListInfo from '../viewmodel/WordListInfo'
import http from '@ohos.net.http'
import { Http } from '../common/constants/Http'
import PreferencesUtil from '../common/utils/PreferencesUtil'

class ExerciseService{
  baseURL: string = `${Http.BaseURL}/ExerciseService`
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
   * 获取学校作业
   * @param userId
   * @returns 学校作业
   */
  getSchoolExercise(type: string, pageNum: number): Promise<ExerciseInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取学校作业'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSchoolExercise/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          extraData: { type: type, pageNum: pageNum },
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
   * 获取学校完成作业详情
   * @param userId
   * @param exerciseId
   * @returns
   */
  getSchoolFinish(exerciseId: number): Promise<SchoolFinishExerciseDetailInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取学校完成作业详情'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSchoolFinish/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', `${title}成功\n`, resp.result)

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
   * 获取学校未完成作业详情
   * @param userId
   * @param exerciseId
   * @returns
   */
  getSchoolUnfinish(exerciseId: number): Promise<SchoolUnfinishExerciseDetailInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取学校未完成作业详情'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSchoolUnfinish/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
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
   * 获取自我练习
   * @param userId
   * @returns 自我练习
   */
  getMineExercise(type: string, pageNum: number): Promise<ExerciseInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取自我练习'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getMineExercise/${pageNum}`,
        {
          method: http.RequestMethod.GET,
          extraData: { type: type, pageNum: pageNum },
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
   * 获取自我完成详情
   * @param userId
   * @param exerciseId
   * @returns
   */
  getMineFinish(exerciseId: number): Promise<SelfFinishExerciseDetailInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取自我完成详情'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getMineFinish/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
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
   * 获取自我未完成
   * @param userId
   * @param exerciseId
   * @returns
   */
  getMineUnfinish(exerciseId: number): Promise<SelfUnfinishExerciseDetailInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取自我未完成'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getMineUnfinish/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
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
   * 获取优秀作品
   * @param userId
   * @returns 优秀作品
   */
  getExcellentExercise(pageNum: number): Promise<ExcellentWorkInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取优秀作品'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExcellentExercise/${pageNum}`,
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
   * 获取优秀学校练习
   * @param exerciseId
   * @returns 优秀学校练习
   */
  getExcellentHomework(exerciseId: number): Promise<ExcellentHomeworkInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '优秀学校练习'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExcellentHomework/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
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
   * 获取优秀竞赛练习
   * @param exerciseId
   * @returns 优秀竞赛练习
   */
  getExcellentCompetition(exerciseId: number): Promise<ExcellentCompetitionInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '优秀竞赛练习'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExcellentCompetition/${exerciseId}`,
        {
          method: http.RequestMethod.GET,
          extraData: { exerciseId: exerciseId },
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
   * 获取系统模板
   * @returns 系统模板
   */
  getSystemTemplate(pageNum: number): Promise<SystemTemplateInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取系统模板'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSystemTemplate/${pageNum}`,
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
   * 获取已有练习
   * @param userId
   * @returns
   */
  getExistExercise(pageNum: number): Promise<SystemTemplateInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取已有练习'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getExistExercise/${pageNum}`,
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
   * 获取专家字帖
   * @returns 专家字帖
   * 已删除
   */
  // getExpertCopybook(pageNum: number): Promise<CopybookInfo[]>{
  //   return new Promise((resolve, reject) => {
  //     let title: string = '获取专家字帖'
  //
  //     //1.创建http请求对象
  //     let httpRequest = http.createHttp()
  //
  //     //2.发出请求
  //     httpRequest.request(
  //       `${this.baseURL}/getExpertCopybook/${pageNum}`,
  //       {
  //         method: http.RequestMethod.GET,
  //         header: {Authorization: this.Authorization}
  //       }
  //     )
  //       .then(resp => {
  //         //成功
  //         if (resp.responseCode === 200) {
  //           //查询成功
  //           console.log('Service', `${title}成功\n`, resp.result.toString())
  //
  //           resolve(JSON.parse(resp.result.toString()).data)
  //
  //         } else {
  //           //失败
  //           console.log('Service', `${title}失败1`, JSON.stringify(resp))
  //           reject(`${title}失败`)
  //         }
  //       })
  //       .catch((error: string) => {
  //         //失败
  //         console.log('Service', `${title}失败2`, JSON.stringify(error))
  //         reject(`${title}失败`)
  //       })
  //   })
  // }

  /**
   * get
   * 获取模板字
   * @param radical
   * @param structure
   * @param typeface
   * @returns 模板字
   */
  getTemplateWord(search: string, radical: string, structure: string, typeface: string, pageNum: number): Promise<WordListInfo[]>{
    return new Promise((resolve, reject) => {
      let title: string = '获取样本字'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getTemplateWord/${pageNum}`,
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
   * 获取选取的字
   * @param id
   * @returns
   */
  getSelectWord(id: number): Promise<WordListInfo>{
    return new Promise((resolve, reject) => {
      let title: string = '获取选取的字'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getSelectWord/${id}`,
        {
          method: http.RequestMethod.GET,
          extraData: { id: id },
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
   * 上传练习（竞赛）
   * @param userId
   * @param exerciseId
   * @param content
   * @returns
   */
  uploadExercise(userId: number, exerciseId: number, content: ResourceStr[]): Promise<boolean>{
    return new Promise((resolve, reject) => {
      let title: string = '上传练习（竞赛）'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/uploadExercise`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, exerciseId: exerciseId, content: content },
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
   * 创建练习
   * @param userId
   * @param content
   * @returns
   */
  createExercise(userId: number, name: string, typeface: string, content: ResourceStr): Promise<boolean> {
    return new Promise((resolve, reject) => {
      let title: string = '创建练习'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/createExercise`,
        {
          method: http.RequestMethod.POST,
          extraData: { userId: userId, title: name, typeface: typeface, content: content },
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
   * 生成练习样例（专项）
   * @param selectWord
   * @returns
   */
  generateExercise(selectWord: WordListInfo[]): Promise<ResourceStr> {
    return new Promise((resolve, reject) => {
      let title: string = '生成练习样例'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/generateExercise`,
        {
          method: http.RequestMethod.POST,
          extraData: { selectWord: selectWord },
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
   * 生成练习样例2（综合）
   * @param name
   * @param content
   * @returns
   */
  generateExercise2(name: string, content: string): Promise<ResourceStr> {
    return new Promise((resolve, reject) => {
      let title: string = '生成练习样例'

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/generateExercise2`,
        {
          method: http.RequestMethod.POST,
          extraData: { name: name, content: content },
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

let exerciseService = new ExerciseService()

export default exerciseService as ExerciseService