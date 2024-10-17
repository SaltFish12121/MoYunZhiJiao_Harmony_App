import { imageUploadModule } from '../../../model/ImageUploadModule'

@Component
export default struct Exercise_Upload {
  @Link exerciseId: number
  @Link content: string[]
  ifCutOFF: boolean = false

  @State success: boolean = false

  @State selectedPaths: string[] | null = null

  build() {
    Column({space: 10}){
      Text('上传作品')
        .width('100%')

      if (this.content.length != 0) {
        List(){
          ListItem().height(20)

          ForEach(
            this.content,
            (content: string) => {
              ListItem(){
                Image(content) // 使用 URI 显示图片
                  .width(250)
                  .height(300)
                  .margin({ top: '10' })
              }
            }
          )
        }
        .width('90%')
        .height(177)
      }

      if (!this.ifCutOFF) {
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
          .onClick(async () => {
            try {
              // 选择图片
              const selectedPaths = await imageUploadModule.pickerAvatar(2);
              console.log('ImageFile', '选择的图片路径:', selectedPaths);
              this.selectedPaths = selectedPaths;

              this.content = selectedPaths
              console.log('ImageFile', 'content:', this.content);

            } catch (error) {
              console.error('ImageFile', '选择或上传图片出错:', error);
            }

          })

        }
        .margin({top: 30})
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
      }

    }
    .width('90%')
    .margin({top: 30, bottom: 60})
  }


}

