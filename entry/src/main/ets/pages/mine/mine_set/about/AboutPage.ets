import { HeaderTitle } from '../../../../common/components/CommonComponents'
import { bundleManager, common, Want } from '@kit.AbilityKit';

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

//关于(最新版本检测未完成）
@Entry
@Component
struct AboutPage {

  @State title: string = '关于'

  @State versionCode: number = 0
  @State versionName: string = ''

  @State newVersionName: string = ''

  build() {
    Column(){
      //1 头部
      HeaderTitle({ title: $title })


      //2 手机版本
      Divider()

      Column(){
        Row(){
          Text('本机版本')
            .fontSize(20)

          Text(this.versionName)
        }
        .about_row()

      }
      .about_column()


      //3 检测新版本
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


      //4 备案信息
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

}