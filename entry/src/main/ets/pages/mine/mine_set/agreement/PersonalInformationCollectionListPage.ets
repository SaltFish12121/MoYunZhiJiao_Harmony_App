import { HeaderTitle } from '../../../../common/components/CommonComponents';
import web_webview from '@ohos.web.webview';
import InformationService from '../../../../service/InformationService'
import Cant_Connect from '../../../../views/Cant_Connect';

//个人信息收集清单
@Entry
@Component
struct PersonalInformationCollectionListPage {
  webviewController: web_webview.WebviewController = new web_webview.WebviewController();

  @State title: string = '个人信息收集清单'

  @State agreement: string = ''
  @State ifConnect: boolean = false

  build() {
    Scroll(){
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

  }

  onPageShow(){
    //获取个人信息收集清单
    this.getAgreement()
  }

  //获取个人信息收集清单
  getAgreement(){
    InformationService.getAgreement('个人信息收集清单')
      .then((agreement: string) => {
        console.log('Tags', '获取个人信息收集清单成功')

        this.agreement = agreement
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取个人信息收集清单失败')
        this.ifConnect = false
      })
  }

}