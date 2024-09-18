export interface UserPO{
  id?: number  //用户id
  name?: string  //用户名
  studentNumber?: string //学号
  userPassword?: string  //密码

  regionId?: number   //地区
  regionName?: string
  regionParentId?: number

  gender?: string  //性别
  otherName?: string   //头像

  klassId?: number  //班级
  klassName?: string
  klassSchool?: string
  klassGrade?: string
  klassTeacher?: string

  phoneNumber?: string //手机号
  email?: string //电子邮箱
  idNumber?: string  //身份证号

  ifBinding?: boolean //是否绑定学校
}