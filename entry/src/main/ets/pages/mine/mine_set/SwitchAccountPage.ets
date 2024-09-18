import { Header } from '../../../common/components/CommonComponents'
import UserInfo from '../../../viewmodel/user/UserInfo'
import KlassInfo from '../../../viewmodel/user/KlassInfo'
import RegionInfo from '../../../viewmodel/user/RegionInfo'

@Extend(Row) function switch_List(){
  .width(330)
  .height(96)
  .borderRadius(10)
  .backgroundColor($r('app.color.start_window_background'))
}

@Entry
@Component
struct SwitchAccountPage {
  // private arr: number[] = [0 , 1]
  @State userId: number = 1
  @State ifManagement: boolean = false

  //搜索数据库，查看记录
  @State userPersonal: UserInfo[] = [
    new UserInfo( 1, '用户1', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com'),
    new UserInfo( 12, '用户2', '202283290123', '123456', new RegionInfo(1, '南京'), '男', '', new KlassInfo(0, '（1）', '盘城小学', '一年级', '李梅'), '18912345678', '123456789@qq.com')
  ]

  build() {
    Column(){
      //1头部
      Stack({alignContent: Alignment.TopEnd}){
        if (this.ifManagement == false){
          Header()
            .width('100%')

        }

        Row(){
          if (this.ifManagement == false){
            Text('管理')
              .fontSize(18)
              .fontColor($r('app.color.blue'))
          } else {
            Text('完成')
              .fontSize(18)
              .fontColor($r('app.color.blue'))
          }

        }
        .height(59)
        .onClick(() => {
          this.ifManagement = !this.ifManagement
        })

      }
      .width('95%')


      //2
      Column({space: 20}){

        if (this.ifManagement == false) {
          Text('点击头像以切换账号')
            .fontSize(30)
            .margin({bottom: 50})
        } else {
          Text('点击头像以切换账号')
            .fontSize(30)
            .margin({bottom: 50})
        }


        List({space: 20}){

          ForEach(this.userPersonal, (user: UserInfo) => {
            ListItem(){

              if (this.ifManagement == false) {
                //当前使用+正常
                Row(){
                  Column(){
                    Image($r('app.media.userhead_example2'))
                      .clip(true)
                      .borderRadius(53)
                      .width(53)
                  }
                  .width('25%')


                  Column(){
                    Text(user.name)
                      .fontSize(16)


                    Text(user.phoneNumber)
                      .fontSize(16)
                      .fontColor($r('app.color.text_gray'))

                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(HorizontalAlign.Start)
                  .height('50%')
                  .width('53%')

                  if (user.id == this.userId){
                    Column(){
                      Text('当前使用')
                        .fontColor($r('app.color.blue'))
                    }
                    .width('20%')
                    .height('80%')
                  }

                }
                .switch_List()

              }
              else if (this.userId == user.id){
                //当前使用+管理
                Row(){
                  Column(){
                    Image($r('app.media.userhead_example2'))
                      .clip(true)
                      .borderRadius(53)
                      .width(53)
                  }
                  .width('25%')


                  Column(){
                    Text(user.name)
                      .fontSize(16)


                    Text(user.phoneNumber)
                      .fontSize(16)
                      .fontColor($r('app.color.text_gray'))

                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(HorizontalAlign.Start)
                  .height('50%')
                  .width('53%')

                  if (user.id == this.userId){
                    Column(){
                      Text('当前使用')
                        .fontColor($r('app.color.blue'))
                    }
                    .width('20%')
                    .height('80%')
                  }

                }
                .switch_List()
                .opacity(0.6)

              }
              else {
                //非当前使用+删除
                Row(){
                  Column(){
                    Image($r('app.media.userhead_example2'))
                      .clip(true)
                      .borderRadius(53)
                      .width(53)
                  }
                  .width('25%')


                  Column(){
                    Text(user.name)
                      .fontSize(16)


                    Text(user.phoneNumber)
                      .fontSize(16)
                      .fontColor($r('app.color.text_gray'))

                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(HorizontalAlign.Start)
                  .height('50%')
                  .width('53%')

                  //删除
                  Column(){
                    Column(){
                      Text('删除')
                        .fontColor($r('app.color.tips_red'))
                    }
                    .width('90%')
                    .border({ width: 1, color: $r('app.color.tips_red'), radius: 10, style: BorderStyle.Solid })


                  }
                  .justifyContent(FlexAlign.Center)
                  .width('20%')
                  .height('80%')

                }
                .switch_List()
              }

            }
            .width('100%')

          })


        }


        if (this.ifManagement == false) {
          //添加账号
          Row(){
            Column(){
              Image($r('app.media.account_head'))
                .width(53)
            }
            .width('25%')


            Column(){
              Text('添加账号')
                .fontColor($r('app.color.text_gray'))
                .fontSize(16)

            }
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Start)
            .height('50%')
            .width('53%')

            /*
            Column(){
              Text('当前使用')
                .fontColor($r('app.color.blue'))
            }
            .width('20%')
            .height('80%')
            */

          }
          .switch_List()
        } else {

        }

      }
      .margin({top : 50})
      .width('100%')


    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.mid_gray'))

  }
}