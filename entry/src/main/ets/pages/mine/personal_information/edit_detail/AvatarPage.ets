import router from '@ohos.router'
import { Header_close_2 } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'
import { imageUploadModule } from '../../../../model/ImageUploadModule'

//修改头像
@Entry
@Component
struct AvatarPage {
  @State userId: number = 0
  @State avatar: string = ''
  @State success: boolean = false //使用中请修改为false
  @State success2: boolean = false

  @State selectedPaths: string[] | null = null

  build() {
    Scroll(){
      Column(){
        //1头部
        Header_close_2({ avatar: $avatar})

        //2头像
        if (this.avatar) {
          Image(/*$r('app.media.userhead_example2')*/this.avatar)
            .width('300')
            .height(400)
            .margin({top: 100, bottom: 50})
        } else {
          Image($r('app.media.userhead_example2'))
            .width('300')
            .height(400)
            .margin({top: 100, bottom: 50})
        }


        Column({space: 25}){
          //3更换头像
          Column(){
            Text('更换头像')
              .fontSize(20)
              .fontColor($r('app.color.start_window_background'))
          }
          .borderRadius(10)
          .width(250)
          .height(55)
          .backgroundColor($r('app.color.gray'))
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .onClick(async () => {
            try {
              // 选择图片
              const selectedPaths = await imageUploadModule.pickerAvatar(1);
              console.log('ImageFile', '选择的图片路径:', selectedPaths);
              this.selectedPaths = selectedPaths;

              // 显示已选择的图片
              if (this.selectedPaths) {
                this.avatar = this.selectedPaths[0]
              }

              // 上传图片
              const uploadedPaths = await imageUploadModule.prepareUpload("/UserService/alterAvatar", "image", this.selectedPaths);
              console.log('ImageFile', '上传的图片路径:', uploadedPaths);

              // // 通过后台获取新的头像
              // await this.alterAvatar();
              // if (this.success2) {
              //   AlertDialog.show({
              //     message: '更改头像成功',
              //     confirm: {
              //       value: '确定',
              //       action: ()=>{
              //         router.back();
              //       }
              //     }
              //   })
              // } else {
              //   AlertDialog.show({
              //     message: '更改头像失败',
              //     confirm: {
              //       value: '确定',
              //       action: ()=>{
              //       }
              //     }
              //   })
              // }
            } catch (error) {
              console.error('ImageFile', '选择或上传图片出错:', error);
            }

          })


          //4保存图片-----未实现
          Column(){
            Text('保存图片')
              .fontSize(20)
              .fontColor($r('app.color.start_window_background'))
          }
          .borderRadius(10)
          .width(250)
          .height(55)
          .backgroundColor($r('app.color.gray'))
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {

          })


        }



      }
      .width('100%')
      // .height('100%')
      .backgroundColor($r('app.color.black'))
    }



  }

  async onPageShow() {
    this.userId = await PreferencesUtil.getPreferenceValue('MyPerferences', 'UserId', 0) as number

    const param = router.getParams() as PARAMS

    if (param.avatar == '') {
      this.avatar = 'https://dummyimage.com/120x240'
    } else {
      this.avatar = param.avatar
    }

    console.log('param', this.avatar)
  }


  // //修改头像
  // async alterAvatar(){
  //   await UserService.alterAvatar(this.userId, this.avatar)
  //     .then((success) => {
  //       console.log('Tags', '修改头像成功')
  //
  //       this.success2 = success
  //
  //       console.log('Result', 'ifsuccess', this.success2)
  //     })
  //     .catch((error: string) => {
  //       console.log('Tags', '修改头像失败')
  //     })
  // }
}

// 声明接受参数的类型
interface PARAMS {
  avatar: string
}
