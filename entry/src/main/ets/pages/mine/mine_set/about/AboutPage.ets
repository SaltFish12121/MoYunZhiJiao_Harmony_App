import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'

import { bundleManager, common, Want } from '@kit.AbilityKit';

// import { updateManager } from '@kit.StoreKit';
// import { hilog } from '@kit.PerformanceAnalysisKit';
// import type { common } from '@kit.AbilityKit';
// import { BusinessError } from '@kit.BasicServicesKit';
//
// let context: common.UIAbilityContext = getContext() as common.UIAbilityContext;

@Extend(Column) function about_column(){
  .width('100%')
  .height(64)
  .justifyContent(FlexAlign.Center)
  .alignItems(HorizontalAlign.Center)
}

@Extend(Row) function about_row(){
  .width('95%')
  .alignItems(VerticalAlign.Center)
  .justifyContent(FlexAlign.SpaceBetween)
}

//关于
@Entry
@Component
struct AboutPage {

  @State title: string = '关于'

  @State versionCode: number = 0
  @State versionName: string = ''

  @State newVersionName: string = ''

  build() {
    Column(){
      //1头部
      HeaderTitle({ title: $title })


      //2手机版本
      Divider()

      Column(){
        Row(){
          Text('本机版本')
            .fontSize(20)

          Text(/*'当前版本'*/this.versionName)
        }
        .about_row()

      }
      .about_column()


      //3检测新版本
      Divider()

      Column(){
        Row(){
          Text('检测新版本')
            .fontSize(20)

          Text('当前版本')
        }
        .about_row()

      }
      .about_column()


      //4备案信息
      Divider()

      Column(){
        Row(){
          Text('备案信息')
            .fontSize(20)

          Image($r('app.media.enter'))
            .width(24)
        }
        .about_row()

      }
      .about_column()
      .onClick(() => {
        // router.pushUrl(
        //   {
        //     url: 'pages/mine/mine_set/about/ArchivalInformationPage'
        //   }
        // )
        let context = getContext(this) as common.UIAbilityContext;
        let want: Want = {
          bundleName: 'com.huawei.hmos.settings',//设置应用bundleName
          abilityName: 'com.huawei.hmos.settings.MainAbility',//设置应用abilityName
          uri: 'application_info_entry',//跳转到应用信息页面
          parameters: {
            pushParams: context.abilityInfo.bundleName//拉起方应用包名
          }
        }
        context.startAbility(want)
      })

      Divider()

    }
    .width('100%')
    .height('100%')


  }

  onPageShow(): void {
    this.getName()
    // this.checkUpdate()
  }

  getName() {
    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
    try {
      bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
        this.versionCode = data.versionCode;
        this.versionName = data.versionName;
        console.log('testTag', 'versionCode', this.versionCode, 'versionName', this.versionName)
        // hilog.info(0x0000, 'testTag', `successfully. versionCode: ${versionCode}, versionName: ${versionName}`);
      }).catch((err: string) => {
        // hilog.error(0x0000, 'testTag', 'failed. Cause: %{public}s', err.message);
      });
    } catch (err) {
      // hilog.error(0x0000, 'testTag', 'failed: %{public}s', err.message);
    }
  }

  // checkUpdate() {
  //   try {
  //     updateManager.checkAppUpdate(context)
  //       .then((checkResult: updateManager.CheckUpdateResult) => {
  //         // this.newVersionName = checkResult.updateAvailable
  //         hilog.info(0, 'TAG', "Succeeded in checking Result updateAvailable:" + checkResult.updateAvailable);
  //       }).catch((error: BusinessError) => {
  //       hilog.error(0, 'TAG', `checkAppUpdate onError.code is ${error.code}, message is ${error.message}`);
  //     });
  //   } catch (error) {
  //     hilog.error(0, 'TAG', `checkAppUpdate onError.code is ${error.code}, message is ${error.message}`);
  //   }
  // }
}