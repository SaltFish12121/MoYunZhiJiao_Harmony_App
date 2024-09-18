import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { initialize } from '@hw-agconnect/hmcore';
import PreferenceUtil from '../common/utils/PreferencesUtil'
import DbUtil from '../common/utils/DbUtil'
import UserModel from '../model/UserModel'
// @ts-ignor e
import json from '../../resources/rawfile/agconnect-services.json'


export default class EntryAbility extends UIAbility {
  //初始化
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    try {
      initialize(this.context, json);
      // 加载用户首选项
      await PreferenceUtil.loadPreference(this.context, 'MyPreferences')
      console.log('start', 'success')
      // 初始化RDB工具
      await DbUtil.initDB(this.context)
      // 创建user表
      await DbUtil.createTable(UserModel.getCreateTableSql())
    } catch (e) {
      hilog.error(0x0000, 'AGConnectError', JSON.stringify(e))
    }



    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/WelcomePage', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
