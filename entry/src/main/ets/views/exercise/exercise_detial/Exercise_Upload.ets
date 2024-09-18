import type { Permissions } from '@ohos.abilityAccessCtrl';
import ExerciseService from '../../../service/ExerciseService'
import ImageUploadDialog from '../../../common/components/ImageUploadDialog/ImageUploadDialog'
import { promptAction, router } from '@kit.ArkUI'
import SchoolFinishExerciseDetailInfo from '../../../viewmodel/exerciseDetial/SchoolFinishExerciseDetailInfo'
import SubmitWritingInfo from '../../../viewmodel/exerciseDetial/SubmitWritingInfo'

@Component
export default struct Exercise_Upload {
  @Link exerciseId: number
  @Link content: ResourceStr[]

  @State success: boolean = false

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
        }
      }),
      alignment: DialogAlignment.Bottom,//弹窗居于底部
      customStyle: true,//自定义样式
    })
  }

  build() {
    Column({space: 10}){
      Text('上传作品')
        .width('100%')

      Scroll(){
        Column(){
          ForEach(
            this.content,
            (content: ResourceStr) => {
              Column(){
                Image(content)

              }
              .width(250)
              .height(300)
            }
          )
        }


      }
      .width('90%')
      .height(177)



      Row(){

        Row({space: 10}){
          Image($r('app.media.camera'))
            .width(20)
            .margin({left: 8})

          Text('上传图片')
        }
        .width(110)
        .height(32)
        .border({ width: 1, color: $r('app.color.text_gray'), radius: 5, style: BorderStyle.Solid })
        .onClick(async() => {
          await this.dialogController?.open()

        })

      }
      .margin({top: 30})
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)

    }
    .width('90%')
    .margin({top: 30, bottom: 60})
  }


}

