import http from '@ohos.net.http'

class Test {
  baseURL: string = 'http://127.0.0.1:4523/m1/4527099-4174694-default'

  testInternet(id: number): Promise<boolean>{
    return new Promise((resolve, reject) => {
      //1.创建http请求对象
      let httpRequest = http.createHttp()

      //2.发出请求
      httpRequest.request(
        `${this.baseURL}/test`,
        {
          method: http.RequestMethod.GET,
          extraData: { id: id }
        }
      )
        .then(resp => {
          //成功
          if (resp.responseCode === 200) {
            //查询成功
            console.log('查询登录者ID成功\n', resp.result.toString())

            resolve(JSON.parse(resp.result.toString()).success)

          } else {
            //失败
            console.log('查询登录者ID失败1', JSON.stringify(resp))
            reject('查询登录者ID失败')
          }
        })
        .catch((error: string) => {
          //失败
          console.log('查询登录者ID失败2', JSON.stringify(error))
          reject('查询登录者ID失败')
        })
    })
  }
}

let test = new Test()

export default test as Test