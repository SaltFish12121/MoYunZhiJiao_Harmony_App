import http from '@ohos.net.http'
import { Http } from '../common/constants/Http'
import PreferencesUtil from '../common/utils/PreferencesUtil'

class LoginService {
  baseURL: string = `${Http.BaseURL}/LoginService`
  // context: common.UIAbilityContext
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
   * 登录并获取登录者ID信息
   * 在登录时调用
   * @param userName
   * @param userPassword
   * @returns 登录者userId
   */
  login(userName: string, userPassword?: string): Promise<loginObject>{
    return new Promise((resolve, reject) => {

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/login`,
        {
          method: http.RequestMethod.POST,
          extraData: { userName: userName, userPassword: userPassword },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', '查询登录者ID成功\n', resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', '查询登录者ID失败1', JSON.stringify(resp))
            reject('查询登录者ID失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', '查询登录者ID失败2', JSON.stringify(error))
          reject('查询登录者ID失败')
        })


    })
  }


  /*
//储存用户信息到用户首选项
dataPreferences.getPreferences(this.context, 'userPreferences').then(preferences => {
  preferences.put('userInfo', JSON.stringify(resultData.data)).then(() => {
  //数据持久化
    preferences.flush().then(() => {
      console.info("用户信息已保存到用户首选项");
      resolve(resultData.data);
    }).catch(error => {
      console.error("用户信息持久化失败: ", error);
      reject('用户信息持久化失败');
    });

  }).catch(error => {
    console.error("存储用户信息失败: ", error);
    reject('存储用户信息失败');
  });

}).catch(error => {
  console.error("存储用户信息失败: ", error);
  reject('存储用户信息失败');
})
*/


  /**
   * post
   * 提供用户信息注册
   * @param userName
   * @param userPassword
   * @param phoneNumber
   * @param email
   * @returns 是否注册成功(账户已存在，成功)
   */
  register(userName: string, userPassword: string, phoneNumber: string, email: string): Promise<boolean>{
    return new Promise((resolve, reject) => {

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/register`,
        {
          method: http.RequestMethod.POST,
          extraData: { name: userName, password: userPassword, phone: phoneNumber, email: email },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', '用户信息注册成功\n', resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', '用户信息注册失败1', JSON.stringify(resp))
            reject('用户信息注册失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', '用户信息注册失败2', JSON.stringify(error))
          reject('用户信息注册失败')
        })

    })
  }

  /**
   * get
   * 发送并获取手机验证码
   * @param phoneNumber
   * @returns 验证码
   */
  getPhoneVerify(phoneNumber: string): Promise<string>{
    return new Promise((resolve, reject) =>{

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/getPhoneVerify`,
        {
          method: http.RequestMethod.GET,
          extraData: { phoneNumber: phoneNumber },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', '获取手机验证码成功\n', resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', '获取手机验证码失败1', JSON.stringify(resp))
            reject('获取手机验证码失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', '获取手机验证码失败2', JSON.stringify(error))
          reject('获取手机验证码失败')
        })
    })
  }

  /**
   * post
   * 忘记密码时通过手机号修改密码
   * @param phoneNumber
   * @param newPassword
   * @returns 是否修改成功
   */
  forgetPassword(phoneNumber: string, newPassword: string): Promise<boolean>{
    return new Promise((resolve, reject) => {

      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/forgetPassword`,
        {
          method: http.RequestMethod.POST,
          extraData: { phoneNumber: phoneNumber, newPassword: newPassword },
          header: {Authorization: this.Authorization}
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('Service', '修改密码成功\n', resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).data)

          } else {
            //失败
            console.log('Service', '修改密码失败1', JSON.stringify(resp))
            reject('修改密码失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('Service', '修改密码失败2', JSON.stringify(error))
          reject('修改密码失败')
        })
    })
  }

}

interface loginObject{
  id: number
  token: string
}

let loginService = new LoginService()

export default loginService as LoginService