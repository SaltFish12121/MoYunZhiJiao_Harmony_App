import Tabs_HomePage from '../../views/homepage/Tabs_HomePage'
import Tabs_Exercise from '../../views/exercise/Tabs_Exercise'
import Tabs_Competition from '../../views/competition/Tabs_Competition'
import Tabs_Message from '../../views/message/Tabs_Message'
import Tabs_Mine from '../../views/mine/Tabs_Mine'

import UserInfo from '../../viewmodel/user/UserInfo'
import KnowledgeInfo from '../../viewmodel/KnowledgeInfo'
import VideoListInfo from '../../viewmodel/VideoListInfo'
import CompetitionInformInfo from '../../viewmodel/CompetitionInformInfo'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import InformationService from  '../../service/InformationService'
import UserService from '../../service/UserService'
import UserDBService from '../../DBservice/UserDBService'

import router from '@ohos.router'
import { UserPO } from '../../common/bean/UserPO'
import { Http } from '../../common/constants/Http'
import Cant_Connect from '../../views/Cant_Connect'

//主页
@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0

  //传入的数据
  //Tabs_HomePage
  @State knowledgeShow: KnowledgeInfo[] = []
  @State videoShow: VideoListInfo[] = []
  @State competitionInformShow: CompetitionInformInfo[] = []

  //Tabs_Mine
  @State userPersonal: UserInfo = new UserInfo()
  @State userType: boolean = false
  @State ifLogin: boolean = true//默认应该 false， 如果预览测试则改为 true

  @State ifConnect: boolean = false

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, image: ResourceStr, index: number){
    Column({space: 8}){
      Image(image)
        .width(22)
        .fillColor(this.selectColor(index))
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor(index))
    }
  }

  selectColor(index: number){
    return this.currentIndex === index ? $r('app.color.blue') : $r('app.color.light_black')
  }

  build() {
    Tabs({barPosition: BarPosition.End}){
      //1.首页
      TabContent(){
        if (this.ifConnect) {
          Tabs_HomePage({ knowledgeShow: $knowledgeShow, videoShow: $videoShow, CompetitionInformShow: $competitionInformShow })
        } else {
          Cant_Connect()
        }
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_homepage'), $r('app.media.homepage'), 0))

      //2.书法练习
      TabContent(){
        if (this.currentIndex == 1 && this.ifLogin){
          Tabs_Exercise()
        }


      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_exercise'), $r('app.media.read'), 1))

      //3.书法竞赛
      TabContent(){
        if (this.currentIndex == 2 && this.ifLogin){
          Tabs_Competition()
        }

      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_competition'), $r('app.media.trophy'), 2))

      //4.消息中心
      TabContent(){
        if (this.currentIndex == 3 && this.ifLogin){
          Tabs_Message()
        }

      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_message'), $r('app.media.message'), 3))

      //5.个人信息
      TabContent(){
        if (this.currentIndex == 4){
          Tabs_Mine({ userPersonal: $userPersonal })
        }

      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_mine'), $r('app.media.user'), 4))

    }
    .width('100%')
    .height('100%')
    .onChange(async(index) => {
      this.currentIndex = index
      if (this.currentIndex == 0) {
        await Promise.all([
          this.getShowKnowledge(),
          this.getShowVideo(),
          this.getShowCompetition()
        ]);
      }

      if ((this.currentIndex == 2 || this.currentIndex == 3 || this.currentIndex == 1) && this.ifLogin == false) {
        router.pushUrl({
          url: 'pages/login/LoginPage'
        })
      }

    })
  }


  async aboutToAppear() {
    console.log('aboutToAppear', 'HomePage')

    await Promise.all([
      this.getShowKnowledge(),
      this.getShowVideo(),
      this.getShowCompetition()
    ]);

  }


  async onPageShow(){
    console.log('onPageShow', 'HomePage')
    console.log('Token', Http.Token)

    this.userPersonal.id = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number
    console.log('MyPreferences', 'test', this.userPersonal.id)

    const user = router.getParams() as PARAMS//从Tabs_Mine得到的user更新值

    //PersonalInformationPage
    if (user.ifSuccess == 1) {
      console.log('HomePage', 'success', this.userPersonal.gender)
      this.userPersonal = user.user
    }

    //Login
    console.log('ifLogin', user.ifLogin)
    if (user.ifLogin == 1) {
      this.userType = user.login
      this.ifLogin = true

      //DB 首次接收用户信息？
      await this.getPersonalInformation()

      // 1.持久化保存
      // 为属性赋值
      const userDB: UserPO = {
        id: this.userPersonal.id,
        name: this.userPersonal.name,
        studentNumber: this.userPersonal.studentNumber,
        userPassword: this.userPersonal.userPassword,

        regionId: this.userPersonal.region.id,
        regionName: this.userPersonal.region.name,
        regionParentId: this.userPersonal.region.parentId,

        gender: this.userPersonal.gender,
        otherName: this.userPersonal.otherName,

        klassId: this.userPersonal.klass.id,
        klassName: this.userPersonal.klass.name,
        klassSchool: this.userPersonal.klass.school,
        klassGrade: this.userPersonal.klass.grade,
        klassTeacher: this.userPersonal.klass.teacher,

        phoneNumber: this.userPersonal.phoneNumber,
        email: this.userPersonal.email,
        idNumber: this.userPersonal.idNumber,
        ifBinding: this.userPersonal.ifBinding
      };
      console.log('DB', '首次保存用户信息', this.userPersonal.display())
      UserDBService.insert(userDB)

    }

    //(已登录/有账号）
    console.log('this.userPersonal.id', this.userPersonal.id)
    if (this.userPersonal!= null && this.userPersonal.id != 0 && this.userPersonal.id != undefined) {
      console.log('ifLogin', 'true');
      this.ifLogin = true
    }

    await Promise.all([
      this.getShowKnowledge(),
      this.getShowVideo(),
      this.getShowCompetition()
    ]);
  }





  /**
   * Tabs_HomePage
   */
  //获取展示的书法知识
  async getShowKnowledge(){
    console.log('HomePage', 'knowledge')

    await InformationService.getKnowledgeShow()
      .then((knowledge: KnowledgeInfo[]) => {
        console.log('Tags', '获取书法知识成功')

        this.knowledgeShow = knowledge

        console.log('Result', this.knowledgeShow[0].cover)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取书法知识失败')
        this.ifConnect = false
      })

  }

  //获取展示的书法教学视频
  async getShowVideo(){
    console.log('HomePage', 'video')

    await InformationService.getVideoShow()
      .then((video: VideoListInfo[]) => {
        console.log('Tags', 'show', '获取书法教学视频成功')

        this.videoShow = video

        console.log('Result', this.videoShow[0].cover)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', 'show', '获取书法教学视频失败', error)
        this.ifConnect = false
      })

  }


  //获取竞赛通知
  async getShowCompetition(){
    console.log('HomePage', 'competition')

    await InformationService.getCompetitionShow()
      .then((competitionInform: CompetitionInformInfo[]) => {
        console.log('Tags', '获取竞赛通知成功')

        this.competitionInformShow = competitionInform

        console.log('Result', this.competitionInformShow[0].cover)
        this.ifConnect = true
      })
      .catch((error: string) => {
        console.log('Tags', '获取竞赛通知失败')
        this.ifConnect = false

      })

  }


  /**
   * Tabs_Mine
   */
  //获取个人信息
  async getPersonalInformation(){

    UserService.getPersonal()
      .then((user) => {
        console.log('Tags', '获取个人信息成功')

        this.userPersonal = user

      })
      .catch((error: string) => {
        console.log('Tags', '获取个人信息失败')
      })
  }

}


// 声明接受参数的类型
interface PARAMS {
  user: UserInfo
  ifSuccess: number
  login: boolean
  ifLogin: number
}

