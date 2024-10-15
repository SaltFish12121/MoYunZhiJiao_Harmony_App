
import { copyFileToCache } from '../../utils/index'
import { request } from '@kit.BasicServicesKit';
import camera from '@ohos.multimedia.camera';
import camerapicker from '@ohos.multimedia.cameraPicker';
import { BusinessError } from '@ohos.base';
import { common } from '@kit.AbilityKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { ReceiveRes, DialogProps } from '../../../viewmodel/interface/DialogProps'

@Extend(Text)
function custText() {
  .width('100%')
  .height('48')
  .fontColor('#39364D')
  .textAlign(TextAlign.Center)
}

@CustomDialog
export default struct ImageUploadDialog {
  dialogController: CustomDialogController
  @Prop props: DialogProps

  private context = getContext(this) as common.UIAbilityContext; //UIAbilityContext

  build() {
    Column() {
      //拍照
      Text('拍照').custText().onClick(async () => {

        try {
          let pickerProfile: camerapicker.PickerProfile = {
            cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK
          };
          let pickerResult: camerapicker.PickerResult = await camerapicker.pick(this.context,
            [camerapicker.PickerMediaType.PHOTO, camerapicker.PickerMediaType.PHOTO], pickerProfile);
          if (pickerResult?.resultUri) {
            //关闭弹窗
            this.dialogController.close()
            //复制图片到缓存目录（缓存目录才有读写权限）
            let filePath = await copyFileToCache(pickerResult.resultUri, this.context)
            if (filePath) {
              this.props.cacheComplete(filePath) // 调用缓存完成回调
            }

          }
        } catch (error) {
          let err = error as BusinessError;
          console.error('ImageFile', `the pick call failed. error code: ${err.code}`);
        }
      })

      Divider().color('#F7F9FA').width('100%').strokeWidth(1)

      //从手机相册选择
      Text('从手机相册选择').custText().onClick(async () => {
        const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        photoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
        photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
        const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
        photoViewPicker.select(photoSelectOptions).then(async(photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
          if (photoSelectResult.photoUris.length) {
            //复制图片到缓存目录（缓存目录才有读写权限）
            const filePath = photoSelectResult.photoUris[0];
            // let filePath = await copyFileToCache(photoSelectResult.photoUris[0],this.context)
            if (filePath) {
              this.props.cacheComplete(filePath) // 调用缓存完成回调
              this.dialogController.close() //关闭弹窗
            }
          }
        }).catch((err: BusinessError) => {
          console.error('ImageFile', "选择照片失败", err);
        })
      })
      Button('取消', { type: ButtonType.Capsule })
        .backgroundColor('#F7F7F7')
        .fontSize('16fp')
        .fontColor('#333333')
        .width('100%')
        .margin({ top: '30' })
        .onClick(() => {
          this.dialogController.close()
        })
    }
    .width('100%')
    .padding({
      left: '16',
      top: '11',
      right: '16',
      bottom: '16'
    })
    .backgroundColor(Color.White)
    .borderRadius({
      topLeft: '24',
      topRight: '24'
    })
  }
}

