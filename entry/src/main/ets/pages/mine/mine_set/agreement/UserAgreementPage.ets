import { HeaderTitle } from '../../../../common/components/CommonComponents';
import web_webview from '@ohos.web.webview';
import InformationService from '../../../../service/InformationService'
import Cant_Connect from '../../../../views/Cant_Connect';

//用户协议
@Entry
@Component
struct UserAgreementPage {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  @State title: string = '用户协议'

  @State agreement: string = ''
  @State ifConnect: boolean = false

  build() {
    Column() {
      //1头部
      HeaderTitle({ title: $title })

      if (this.ifConnect) {
        //2内容（模拟）
        RichText(this.agreement)
      } else {
        Cant_Connect()
      }

    }
  }

  onPageShow(){
    //获取用户协议
    this.getAgreement()
  }

  //获取用户协议
  getAgreement(){
    InformationService.getAgreement('用户协议')
      .then((agreement: string) => {
        console.log('Tags', '获取用户协议成功')

        this.agreement = agreement
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取用户协议失败')
        this.ifConnect = false
      })
  }
}