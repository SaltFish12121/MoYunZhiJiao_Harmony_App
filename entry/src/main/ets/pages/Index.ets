import ImageUploadDialog from '../common/components/ImageUploadDialog/ImageUploadDialog'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct Index {
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
    Column(){
      Button('上传').onClick(()=>{
        this.dialogController?.open()
      })

    }.width('100%')
  }
}
