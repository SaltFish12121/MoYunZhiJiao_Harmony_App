import router from '@ohos.router'
import {  HeaderTitle } from '../../../common/components/CommonComponents'
import Exercise_Top_Self from '../../../views/exercise/exercise_detial/Exercise_Top_Self'
import Exercise_Upload from '../../../views/exercise/exercise_detial/Exercise_Upload'
import SelfUnfinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SelfUnfinishExerciseDetailInfo'
import ExerciseService from '../../../service/ExerciseService'
import PreferencesUtil from '../../../common/utils/PreferencesUtil'

@Entry
@Component
struct SelfUnfinishPage {

  @State title: string = '基础笔画练习'
  @State ifCollect: boolean = false

  @State uerId: number = 0
  @State exerciseId: number = 0
  @State selfUnfinish: SelfUnfinishExerciseDetailInfo = new SelfUnfinishExerciseDetailInfo(0, '笔画练习（一）', false,
    '行书',
    '际传存论青常照采照再八算何机话元。', /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1'),
    [
      /*'https://dummyimage.com/120x240'*/$r('app.media.exercise_test1')
    ])

  @State success2: boolean = false
  @State content: ResourceStr[] = ['https://dummyimage.com/120x240']

  @State success: boolean = false

  build(){
    Scroll(){
      Column(){
        //1 头部
        HeaderTitle({ title: $title })

        //2 内容
        if (this.success) {
          Exercise_Top_Self({ selfExercise: $selfUnfinish })
        }


        //3上传作品
        Exercise_Upload({ exerciseId: this.exerciseId, content: $content })

        //4关闭
        Row({space: 20}){
          // 1关闭
          Column(){
            Text('关闭')
              .fontSize(20)
              .onClick((event: ClickEvent) => {
                router.back()
              })
          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .width(120)
          .height(45)
          .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })


          // 2提交
          if (true) {
            Column(){
              Text('提交')
                .fontSize(20)
                .onClick(async () => {

                  //上传服务器
                  await this.uploadExercise()

                  if (this.success2) {
                    AlertDialog.show({
                      message: '作业提交成功',
                      confirm: {
                        value: '确定',
                        action: ()=>{
                          router.back()
                        }
                      }
                    })

                  } else {
                    AlertDialog.show({
                      message: '作业提交失败，请重新尝试',
                      confirm: {
                        value: '确定',
                        action: ()=>{
                        }
                      }
                    })
                  }


                })
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .width(120)
            .height(45)
            .border({ width: 1, color: $r('app.color.text_gray'), radius: 10, style: BorderStyle.Solid })

          }

        }

        Column(){

        }
        .height(50)

      }

    }
    .width('100%')
    .height('100%')
  }

  async onPageShow(){
    console.log('show')
    this.uerId = await PreferencesUtil.getPreferenceValue('MyPreferences', 'UserId', 0) as number

    const get = router.getParams() as PARAMS

    if (get.ifSuccess == 1) {
      this.title = get.title
      this.exerciseId = get.id
    }

    console.log('Tabs_Exercise', this.exerciseId, this.title)

    if (get.ifSuccess == 1) {
      //获取学校完成练习
      await this.getSelfUnfinish()
    }
  }

  //获取自我未完成练习
  async getSelfUnfinish(){

    await ExerciseService.getMineUnfinish(this.uerId, this.exerciseId)
      .then((selfUnfinish: SelfUnfinishExerciseDetailInfo) => {
        console.log('Tags', '获取自我完成练习成功')

        this.selfUnfinish = selfUnfinish

        this.success = true

        this.content = this.selfUnfinish.submit

        console.log('Result', this.selfUnfinish.title)

      })
      .catch((error: string) => {
        this.success = true
        console.log('Tags', '获取自我完成练习失败')
      })

    this.title = this.selfUnfinish.title

    this.ifCollect = this.selfUnfinish.ifCollect

  }

  //上传练习
  async uploadExercise(){
    console.log('id',this.exerciseId)
    await ExerciseService.uploadExercise(this.uerId, this.exerciseId, this.content)
      .then((success) => {
        console.log('Tags', '上传练习成功')

        this.success2 = success

        console.log('Result', this.success2)

      })
      .catch((error: string) => {

        console.log('Tags', '获取书法知识失败')
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  ifSuccess: number
  title: string
  id: number
}