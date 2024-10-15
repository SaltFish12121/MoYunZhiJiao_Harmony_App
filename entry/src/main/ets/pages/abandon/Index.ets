
import { common } from '@kit.AbilityKit'
import { imageUploadModule } from '../../model/ImageUploadModule'

@Entry
@Component
struct Index {
  private context = getContext(this) as common.UIAbilityContext; // UIAbilityContext

  @State selectedPaths: string[] | null = null
  @State filesPaths: string[] = []

  build() {
    Column() {

      Button("选择图片")
        .onClick(async () => {
          try {
            const selectedPaths = await imageUploadModule.pickerAvatar(2);
            console.log('ImageFile', '选择的图片路径:', selectedPaths);
            this.selectedPaths = selectedPaths
            this.filesPaths = selectedPaths
          } catch (error) {
            console.error('ImageFile', '选择图片出错:', error);
          }
        });


      // 显示已选择的图片
      if (this.selectedPaths) {
        Column({ space: 10 }){
          Text('选择的图片')

          List(){
            ListItem().height(20)


            ForEach(
              this.selectedPaths,
              (selectedPath: string) => {
                ListItem(){
                  Image(selectedPath) // 使用 URI 显示图片
                    .width('100%')
                    .height('200')
                    .margin({ top: '10' })
                }
              }
            )
          }
          .height(100)
          .borderWidth(2)


        }
      }

      Button("上传图片")
        .onClick(async () => {
          try {
            const uploadedPaths = await imageUploadModule.prepareUpload("/ExerciseService/uploadImage", "image", this.filesPaths);
            console.log('ImageFile', '上传的图片路径:', uploadedPaths);
          } catch (error) {
            console.error('ImageFile', '上传图片出错:', error);
          }
        });

    }.width('100%')
  }


}
