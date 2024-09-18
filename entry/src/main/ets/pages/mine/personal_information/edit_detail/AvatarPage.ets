import router from '@ohos.router'
import { Header_close_2 } from '../../../../common/components/CommonComponents'
import UserService from '../../../../service/UserService'
import ImageUploadDialog from '../../../../common/components/ImageUploadDialog/ImageUploadDialog'
import { promptAction } from '@kit.ArkUI'
import UserDBService from '../../../../DBservice/UserDBService'
import PreferencesUtil from '../../../../common/utils/PreferencesUtil'

@Entry
@Component
struct AvatarPage {
  @State userId: number = 0
  @State avatar: ResourceStr = ''
  @State success: boolean = false //使用中请修改为false
  @State success2: boolean = false

  @State dialogController: CustomDialogController | null = null //选择上传类型弹窗控制器
  aboutToAppear(): void {
    this.dialogController= new CustomDialogController({
      builder: ImageUploadDialog({
        uploadURL: 'http://xxxxxxxxx',//上传地址
        success:e=>{//上传成功回调，e上传成功接口返回数据
          let res= JSON.parse(e.body) as object //接口上传成功返回数据
          console.log(JSON.stringify(res),'上传成功')
          //根据实际接口返回字段获取图片url
          //url=res['data']
        },
        fail:e=>{//上传失败回调
          console.log(JSON.stringify(e))
          promptAction.showToast({message:'上传失败'})
        },
        complete:e=>{//上传完成回调
          console.log(JSON.stringify(e),'complete')
          this.success = this.success
        }
      }),
      alignment: DialogAlignment.Bottom,//弹窗居于底部
      customStyle: true,//自定义样式
    })
  }

  build() {
    Scroll(){
      Column(){
        //1头部
        Header_close_2()

        //2头像
        Image(/*$r('app.media.userhead_example2')*/this.avatar)
          .width('300')
          .margin({top: 100, bottom: 50})

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
            await this.dialogController?.open() //使用请用这个

            if (this.success) {
              await this.alterAvatar()

              if (this.success2) {
                let avatar2 = this.avatar as string
                UserDBService.updateUserColumnById(this.userId, 'otherName', avatar2/*'https://dummyimage.com/120x140'*/)
                console.log('DB', 'update', this.userId, 'otherName', this.avatar)
                AlertDialog.show({
                  message: '更改头像成功',
                  confirm: {
                    value: '确定',
                    action: ()=>{
                      router.back()
                    }
                  }
                })
              }  else {
                AlertDialog.show({
                  message: '更改头像失败',
                  confirm: {
                    value: '确定',
                    action: ()=>{
                    }
                  }
                })
              }
            }
          })



          //4保存图片
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
      this.avatar = $r('app.media.userhead_example2')
    } else {
      this.avatar = param.avatar
    }

    console.log('param', this.avatar)
  }


  //修改头像
  async alterAvatar(){
    await UserService.alterAvatar(this.userId, this.avatar)
      .then((success) => {
        console.log('Tags', '修改头像成功')

        this.success2 = success

        console.log('Result', 'ifsuccess', this.success2)
      })
      .catch((error: string) => {
        console.log('Tags', '修改头像失败')
      })
  }
}

// 声明接受参数的类型
interface PARAMS {
  avatar: string
}
