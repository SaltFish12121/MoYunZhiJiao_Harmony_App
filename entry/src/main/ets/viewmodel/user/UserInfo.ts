import RegionInfo from './RegionInfo'
import KlassInfo from  './KlassInfo'
import dataPreferences from '@ohos.data.preferences'

export default class UserInfo{
  id: number  //用户id
  name: string  //用户名
  studentNumber: string //学号
  userPassword: string  //密码

  region: RegionInfo   //地区
  gender: string  //性别
  otherName: string   //头像

  klass: KlassInfo  //班级

  phoneNumber: string //手机号
  email: string //电子邮箱
  idNumber: string  //身份证号

  ifBinding?: boolean //是否绑定学校

  constructor(userId: number = 0, userName: string = '默认', studentNumber: string = '', userPassword: string = '',
              region: RegionInfo = new RegionInfo(), gender: string = '', pictureUrl: any = '',
              klass: KlassInfo = new KlassInfo(),
              phoneNumber: string = '', email: string = '', idNumber: string = '', ifBinding: boolean = false) {
    this.id = userId
    this.name = userName
    this.studentNumber = studentNumber
    this.userPassword = userPassword

    this.region = region
    this.gender = gender
    this.otherName = pictureUrl

    this.klass = klass

    this.phoneNumber = phoneNumber
    this.email = email
    this.idNumber = idNumber

    this.ifBinding = ifBinding
  }

  display(): string {
    return `ID: ${this.id}, Name: ${this.name}, Student Number: ${this.studentNumber}, Password: ${this.userPassword}, Region: ${this.region.name}, Gender: ${this.gender}, Other Name: ${this.otherName}, Klass: ${this.klass.name}, Phone Number: ${this.phoneNumber}, Email: ${this.email}, ID Number: ${this.idNumber}, If Binding: ${this.ifBinding}`;
  }
}

enum Gender{
  man = '男',
  female = '女'
}

export class PreferenceManager {
  private context: any

  constructor(context: any) {
    this.context = context
  }

  async saveUserInfo(userInfo: UserInfo): Promise<void>{
    const preferences = await dataPreferences.getPreferences(this.context, 'userPreferences');
    await preferences.put('userInfo', JSON.stringify(userInfo));
    await preferences.flush();
  }

  async getUserInfo(): Promise<UserInfo | null> {
    const preferences = await dataPreferences.getPreferences(this.context, 'userPreferences');
    const userInfoJson = await preferences.get('userInfo', '');

    // 使用类型守卫来确保userInfoJson是一个字符串
    if (typeof userInfoJson === 'string') {
      return JSON.parse(userInfoJson) as UserInfo;
    } else {
      return null;
    }
  }

}