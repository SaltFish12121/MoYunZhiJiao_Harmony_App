import Device from '@system.device'
import Finish_Self from './Finish_Self'
import New_Self from './New_Self'
import Unfinish_Self from './Unfinish_Self'
import ExerciseInfo from '../../../viewmodel/ExerciseInfo'

@Component
export default struct Self_Exercise {
  @State currentIndex: number = 0
  @State currentIndex2: number = 0

  @Link selfFinishExercise: ExerciseInfo[]
  @Link selfUnfinishExercise: ExerciseInfo[]

  //自定义组件实现tabs组件拥有图片
  @Builder TabBarBuilder(title: ResourceStr, index: number){
    Column({space: 8}){
      Text(title)
        .fontSize(14)
        .fontColor(this.selectColor2(index))
    }
    .border({ width: 1 ,color: $r('app.color.blue')})
    .width('90%')
    .height(29)
    .backgroundColor(this.selectColor1(index))
    .justifyContent(FlexAlign.Center)
  }

  selectColor1(index: number){
    return this.currentIndex === index ? $r('app.color.blue') : $r('app.color.start_window_background')
  }

  selectColor2(index: number){
    return this.currentIndex2 === index ? $r('app.color.start_window_background') : $r('app.color.blue')
  }


  build() {
    Column(){
      //1.分类：已完成，未完成
      Tabs({barPosition: BarPosition.Start}){
        //1.已完成
        TabContent(){
          // Text('已完成')
          Finish_Self({ exercise: $selfFinishExercise })
        }
        .tabBar(this.TabBarBuilder('已完成', 0))

        //2.未完成
        TabContent(){
          // Text('未完成')
          Unfinish_Self({ exercise: $selfUnfinishExercise })
        }
        .tabBar(this.TabBarBuilder('未完成', 1))

        //3.新建
        TabContent(){
          // Text('新建')
          New_Self()
        }
        .tabBar(this.TabBarBuilder('新建', 2))

      }
      .width('100%')
      .height('100%')
      .onChange(index => {
        this.currentIndex = index
        this.currentIndex2 = index
      })

    }
  }
}