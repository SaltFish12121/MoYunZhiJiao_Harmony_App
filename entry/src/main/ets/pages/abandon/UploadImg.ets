import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import fs from '@ohos.file.fs';
import { http } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';
@Entry
@Component struct UploadImg {
  @State message: string = 'Hello World'
  private appContext: common.Context = getContext(this);
  private atManager = abilityAccessCtrl.createAtManager();

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("保存图片")
          .margin({ top: 10 })
          .onClick(async (event: ClickEvent) => {
            //申请权限并保存图片到图库
            try {
              //申请相册管理模块权限'ohos.permission.WRITE_IMAGEVIDEO'
              this.atManager.requestPermissionsFromUser(this.appContext, [ 'ohos.permission.WRITE_IMAGEVIDEO' ]).then(async () => {
                //权限申请成功，保存到图库
                let context = getContext();
                //获取相册管理模块的实例，用于访问和修改相册中的媒体文件
                let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
                // onClick触发后10秒内通过createAsset接口创建图片文件，10秒后createAsset权限收回
                let uri = await phAccessHelper.createAsset(photoAccessHelper.PhotoType.IMAGE, 'jpg');
                // 创建媒体文件
                console.info('createAsset successfully, uri: ' + uri);
                let file = fs.openSync(uri, fs.OpenMode.READ_WRITE || fs.OpenMode.CREATE);
                let totalSize = 0;
                let httpRequest = http.createHttp();
                httpRequest.on("dataReceive", (data: ArrayBuffer) => {
                  let writeLen = fs.writeSync(file.fd, data);
                  totalSize = totalSize + writeLen; });
                httpRequest.requestInStream('https://developer.huawei.com/allianceCmsResource/resource/HUAWEI_Developer_VUE/images/homeNew/next- pc.png',
                  { method: http.RequestMethod.GET, connectTimeout: 3000, }, httpCode => {
                    console.info('requestInStream HTTP CODE is', httpCode) })
                httpRequest.on("dataEnd", () => {
                  fs.close(file);
                  promptAction.showDialog({ title: "下载图片结束，并保存至相册", message: `图片大小:${totalSize}字节` }) }) })
            } catch (err) {
              console.error(`requestPermissionsFromUser call Failed! error: ${err.code}`); } }) }
      .width('100%')
    }
    .height('100%')
  }
}
