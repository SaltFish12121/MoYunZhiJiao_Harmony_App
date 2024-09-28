import Tabs_HomePage from '../../views/homepage/Tabs_HomePage'
import Tabs_Exercise from '../../views/exercise/Tabs_Exercise'
import Tabs_Comptition from '../../views/competition/Tabs_Compition'
import Tabs_Message from '../../views/message/Tabs_Message'
import Tabs_Mine from '../../views/mine/Tabs_Mine'

import UserInfo from '../../viewmodel/user/UserInfo'
import KnowledgeInfo from '../../viewmodel/KnowledgeInfo'
import { KnowledgeType } from '../../viewmodel/KnowledgeInfo'
import VideoListInfo from '../../viewmodel/VideoListInfo'
import CompetitionInformInfo from '../../viewmodel/CompetitionInformInfo'
import PreferencesUtil from '../../common/utils/PreferencesUtil'
import InformationService from  '../../service/InformationService'
import UserService from '../../service/UserService'
import UserDBService from '../../DBservice/UserDBService'
import ExerciseService from  '../../service/ExerciseService'

import router from '@ohos.router'
import { UserPO } from '../../common/bean/UserPO'
import { Http } from '../../common/constants/Http'
import Cant_Connect from '../../views/Cant_Connect'


@Entry
@Component
struct HomePage {
  @State currentIndex: number = 0

  //传入的数据
  //Tabs_HomePage
  @State knowledgeShow: KnowledgeInfo[] = [
    /*
    new KnowledgeInfo(1,KnowledgeType.famousWorks, true, '面对与超越', 666, '2024-6-4', $r('app.media.homepage_video')),
    new KnowledgeInfo(2,KnowledgeType.famousWorks, true, '博览旧书法', 666, '2024-6-4', $r('app.media.homepage_knowledge2')),
    new KnowledgeInfo(3,KnowledgeType.famousWorks, true, '上海中国书法院院展', 666, '2024-6-4', $r('app.media.homepage_knowledge3'))
    */
  ]
  @State videoShow: VideoListInfo[] = [
    /*
    new VideoListInfo(1, '合集', '楷书的教学视频1', '2024-4-10', $r('app.media.homepage_video')),
    new VideoListInfo(2, '合集', '楷书的教学视频2', '2024-4-10', $r('app.media.homepage_video2')),
    new VideoListInfo(3, '合集', '楷书的教学视频3', '2024-4-10', $r('app.media.homepage_video3')),
    new VideoListInfo(4, '合集', '楷书的教学视频4', '2024-4-10', $r('app.media.homepage_video4')),
    new VideoListInfo(5, '合集', '楷书的教学视频5', '2024-4-10', $r('app.media.homepage_video')),
    */
  ]


  @State competitionInformShow: CompetitionInformInfo[] = [
    /*
    new CompetitionInformInfo(1,true, '“第一次书法竞赛”', '2024-4-5'),
    new CompetitionInformInfo(2,true, '“第二次书法竞赛”', '2024-4-5'),
    new CompetitionInformInfo(3,true, '“全国大赛”', '2024-4-5'),
    new CompetitionInformInfo(4,true, '“全国大赛（2）”', '2024-4-5'),
    */
  ]

  //Tabs_Mine
  @State userPersonal: UserInfo = new UserInfo()
  @State userType: boolean = false
  @State ifLogin: boolean = true

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
        // Text('首页')
        if (this.ifConnect) {
          Tabs_HomePage({ knowledgeShow: $knowledgeShow, videoShow: $videoShow, CompetitionInformShow: $competitionInformShow })
        } else {
          Cant_Connect()
        }
      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_homepage'), $r('app.media.homepage'), 0))

      //2.书法练习
      TabContent(){
        // Text('书法练习')
        if (this.currentIndex == 1){
          if (this.ifLogin) {
            Tabs_Exercise(/*{ schoolExercise: $schoolExercise, selfExercise: $selfExercise, excellentExercise: $excellentExercise }*/)
          }
          // Tabs_Exercise(/*{ schoolExercise: $schoolExercise, selfExercise: $selfExercise, excellentExercise: $excellentExercise }*/)
        }


      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_exercise'), $r('app.media.read'), 1))

      //3.书法竞赛
      TabContent(){
        // Text('书法竞赛')
        if (this.currentIndex == 2){
          if (this.ifLogin) {
            Tabs_Comptition(/*{ competition: $competition, excellentExercise: $excellentExercise }*/)
          }
          // Tabs_Comptition(/*{ competition: $competition, excellentExercise: $excellentExercise }*/)
        }

      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_competition'), $r('app.media.trophy'), 2))

      //4.消息中心
      TabContent(){
        // Text('消息中心')
        if (this.currentIndex == 3){
          if (this.ifLogin) {
            Tabs_Message()
          }

        }

      }
      .tabBar(this.TabBarBuilder($r('app.string.tab_message'), $r('app.media.message'), 3))

      //5.个人信息
      TabContent(){
        // Text('个人信息')

        if (this.currentIndex == 4){

          Tabs_Mine({ userPersonal: $userPersonal })

        }


        // Tabs_Mine()

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

    // this.loadUserInfo()

    // this.fontSize = await PreferencesUtil.getPreferenceValue('MyPreferences', 'MineFontSize', 16) as number
  }


  async onPageShow(){
    console.log('onPageShow', 'HomePage')
    console.log('Token', Http.Token)
    // this.knowledgeShow[0].cover = $r('app.media.homepage_video3')

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

      /*if (this.userType) {
        this.userPersonal = new UserInfo( 1, '王小明', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com', '', true)
      } else {
        this.userPersonal = new UserInfo( 2, '宋小二', '', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '', '', '未设置年级', ''), '18912345678', '123456789@qq.com', '', false)
      }*/

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
    // let userId = 1
    // let userId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    UserService.getPersonal()
      .then((user) => {
        console.log('Tags', '获取个人信息成功')

        this.userPersonal = user

      })
      .catch((error: string) => {
        console.log('Tags', '获取个人信息失败')
        // this.ifConnect = false
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

