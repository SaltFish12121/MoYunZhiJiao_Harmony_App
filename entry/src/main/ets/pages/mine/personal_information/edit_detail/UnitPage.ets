import router from '@ohos.router'
import { HeaderTitle } from '../../../../common/components/CommonComponents'
import KlassInfo from '../../../../viewmodel/user/KlassInfo'

@Extend(Row) function unit_row(){
  .height(64)
  .width('90%')
  .justifyContent(FlexAlign.SpaceBetween)
}

@Entry
@Component
struct UnitPage {
  @State klass: KlassInfo = new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅')
  @State studentNumber: string = '202283290123'

  @State title: string = '绑定单位'

  build() {
    Column(){
      Column(){
        //1头部
        HeaderTitle({ title: $title })

        Divider()


        //2内容
        Column(){
          //学校
          Row(){
            Text(this.klass.school)
              .fontSize(20)
          }
          .unit_row()

          Divider()

          //学号
          Row(){
            Text('学号：')
              .fontSize(20)

            Text(this.studentNumber)
              .fontSize(20)
          }
          .unit_row()

          Divider()

          //年级
          Row(){
            Text('年级：')
              .fontSize(20)

            Text(this.klass.grade)
              .fontSize(20)
          }
          .unit_row()

          Divider()

          //班级
          Row(){
            Text('班级：')
              .fontSize(20)

            Text(this.klass.name+'班')
              .fontSize(20)
          }
          .unit_row()

          Divider()

          //教师
          Row(){
            Text('教师：')
              .fontSize(20)

            Text(this.klass.teacher)
              .fontSize(20)
          }
          .unit_row()

          Divider()

        }
        .width('100%')

      }
      .width('100%')
      .backgroundColor($r('app.color.start_window_background'))

    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))

  }


  onPageShow(){
    const klass = router.getParams() as PARAMS

    console.log(`klass = ${klass.klass}`)
    console.log(`klass = ${klass.studentNumber}`)

    if (klass.klass != null) {
      this.klass = klass.klass
      this.studentNumber = klass.studentNumber
    }

  }
}

// 声明接受参数的类型
interface PARAMS {
  klass: KlassInfo
  studentNumber: string
}