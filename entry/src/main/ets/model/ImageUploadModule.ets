import { fileIo, picker } from '@kit.CoreFileKit'
import { request } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';
import { Http } from '../common/constants/Http'
import PreferencesUtil from '../common/utils/PreferencesUtil'

// 图片上传的基地址,按需求更改
const Url_Base = `${Http.BaseURL}`

class ImageUploadModule {
  private selectedPhotoUris: string[] = [];
  Authorization: string = Http.Token

  async getUserToken(){
    this.Authorization = await PreferencesUtil.getPreferenceValue('MyPreferences', 'Token', '') as string
    if (this.Authorization == null) {
      this.Authorization = Http.Token
    }
    console.log('token', 'Init', this.Authorization)
  }


  // 选择图片,返回选择图片的地址
  async pickerAvatar(selectNum: number = 1): Promise<string[]> {
    if (selectNum < 1) {
      selectNum = 1;
    } else if (selectNum > 9) {
      selectNum = 9;
    }

    const options = new picker.PhotoSelectOptions();
    options.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE;
    options.maxSelectNumber = selectNum;

    const pickerView = new picker.PhotoViewPicker();
    const ImgResults = await pickerView.select(options);

    if (ImgResults.photoUris.length > 0) {
      this.selectedPhotoUris = ImgResults.photoUris;
      return Promise.resolve(ImgResults.photoUris);
    } else {
      return Promise.reject("用户取消了图片选择");
    }
  }

  // 拿到地址, 拷贝到应用的缓存目录. 然后上传图片
  fileCopies(ImagePath: string, name: string): request.File {
    const file = fileIo.openSync(ImagePath, fileIo.OpenMode.READ_ONLY);
    const filename = `${Date.now()}_${Math.floor(Math.random() * 1000)}`;
    const extension = ImagePath.slice(ImagePath.lastIndexOf(".") + 1);
    const copyThePath = `${getContext().cacheDir}/${filename}.${extension}`;
    console.log(copyThePath);
    fileIo.copyFileSync(file.fd, copyThePath);

    return {
      filename: `${filename}.${extension}`,
      type: extension,
      name: name,
      uri: `internal://cache/${filename}.${extension}`
    };
  }

  // 上传图片
  async uploadAnImage(url: string, fileArr: request.File[]) {
    const files: Array<request.File> = fileArr;
    console.log('ImageFile', files[0].filename, files[0].name, files[0].uri, files[0].type);
    console.log('ImageFile', "FileUpload:", JSON.stringify("开始准备文件上传"));
    const res = await request.uploadFile(getContext(), {
      url: Url_Base + url,
      method: http.RequestMethod.POST,
      header: {
        "Authorization": this.Authorization,
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Content-Type': 'multipart/form-data'
      },
      files: files,
      data: [],
    });

    res.on("progress", async (progress, totalSize) => {
      console.info('ImageFile', "当前上传进度为:", `${progress / totalSize * 100}%`);
      if (progress === totalSize) {
        promptAction.showToast({ message: "图片上传成功" });
      }
    });

    res.on("headerReceive", (header) => {
      console.log('ImageFile', "FileUpload:", JSON.stringify(header));
    });
  }

  // 上传图片的方法，传入文件路径
  async prepareUpload(url: string, name: string, paths: string[]): Promise<string[]> {
    if (!paths.length) {
      return Promise.reject("没有选择图片");
    }

    const files: request.File[] = [];
    for (let i = 0; i < paths.length; i++) {
      files.push(this.fileCopies(paths[i], name));
      console.log('ImageFile', files[i].filename, files[i]);
    }

    await this.uploadAnImage(url, files);
    return paths;
  }
}


// 实例化图片上传实例,然后导出
export const imageUploadModule = new ImageUploadModule()

/*

  // 选择图片,返回选择图片的地址
  async pickerAvatar(selectNum: number = 1) {
    // 规范选择的合法数量
    if (selectNum < 1) {
      selectNum = 1
    } else if (selectNum > 9) {
      selectNum = 9
    }
    // 实例化选择参数的对象
    const options = new picker.PhotoSelectOptions()
    // 设定需要选择的文件类型, 这里只选择图片
    options.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE
    // 设定选择的数量, 这里只需要选择一张
    options.maxSelectNumber = selectNum

    // 实例化选择器, 然后选入设定好的对象
    const pickerView = new picker.PhotoViewPicker
    // 调用选择器, 并且接受返回的结果
    const ImgResults = await pickerView.select(options)

    // 判断是否选择了图片,如果取消了图片选择,则使用Promise抛出异常
    if (ImgResults.photoUris.length > 0) {
      return Promise.resolve(ImgResults.photoUris)
    } else {
      // console.warn("取消了图片选择")
      return Promise.reject("用户取消了图片选择")
    }
  }

  // 拿到地址, 拷贝到应用的缓存目录. 然后上传图片
  // 注意, 这里处理单张图片路径! name的参数为后端规定的图片name格式!!! 常见为:img/image/file等...
  fileCopies(ImagePath: string, name: string): request.File {
    // 使用文件管理模块打开,拿到源文件
    const file = fileIo.openSync(ImagePath, fileIo.OpenMode.READ_ONLY)

    // 设置一下需要拷贝到缓存目录的图片名字
    const filename = `${Date.now()}_${Math.floor(Math.random() * 1000)}`
    // 动态取到文件名的格式后缀, 一般是jpg/png格式
    const extension = ImagePath.slice(ImagePath.lastIndexOf(".") + 1)

    // 把路径和文件名组合
    const copyThePath = `${getContext().cacheDir}/${filename}.${extension}`
    // 打印一下准备复制的路径做确认
    console.log(copyThePath)
    // 拿到源文件的唯一表示,和准备复制的路径,把相册中的图片复制到应用自身的沙箱中
    fileIo.copyFileSync(file.fd, copyThePath)

    return {
      filename: `${filename}.${extension}`,
      type: extension,
      name: name,
      uri: `internal://cache/${filename}.${extension}`
    }
  }

  // 上传图片
  async uploadAnImage(url: string, fileArr: request.File[]) {

    const files: Array<request.File> = fileArr
    console.log('ImageFile', files[0].filename, files[0].name, files[0].uri, files[0].type)

    // const file: request.File = fileArr
    // console.log('ImageFile', file.filename, file.name, file.uri, file.type)

    console.log('ImageFile', "FileUpload:", JSON.stringify("开始准备文件上传"))
    // 开始准备上传图片,需要两个参数,一个是上下文对象,一个是上传的配置
    const res = await request.uploadFile(getContext(), {
      url: Url_Base + url,
      method: http.RequestMethod.POST,
      header: {
        "Authorization": `${Http.Token}`,  //看需求,是否需要携带token

'Connection': 'keep-alive',
'Content-Type': 'multipart/form-data'
},
files: files,
data: [],
})

// 这里是监听上传的进度
res.on("progress", async (progress, totalSize) => {
  console.info('ImageFile', "当前上传进度为:", `${progress / totalSize * 100}%`)
  // 如果上传大小等于总大小,则说明上传完成
  if (progress === totalSize) {
    promptAction.showToast({ message: "图片上传成功" })
  }
})

// 这里是监听上传响应的标头
res.on("headerReceive", (header) => {
  // 打印标头信息, 这里包含上传的图片访问地址
  console.log('ImageFile', "FileUpload:", JSON.stringify(header))
})
}

// 对上传图片的全部步骤完成函数封装
async imageUpload(url: string, path: string[], name: string, selectNum = 1): Promise<string[]> {
  try {
  // 拉起图片选择器, 如果用户取消选择则进入catch,代码不会往下执行
  // 默认选择图片为一张
  //1
  // const photoUris = await this.pickerAvatar(selectNum)
  //2
  const photoUris = path

  // 拿到拷贝到应用沙箱的文件配置对象列表
  //1
  // const files = photoUris.map(v => this.fileCopies(v, name))
  // const file = this.fileCopies(photoUris[0], name)

  //2
  const files: request.File[] = [];
  for (let i = 0; i < path.length; i++) {
  files.push(this.fileCopies(path[i], name));
  console.log('ImageFile', files[i].filename, files[i])
}

// 开始准备上传图片
this.uploadAnImage(url, files)

// 返回选择的图片路径
return photoUris;
} catch (e) {
  // 打印错误
  console.log('ImageFile', "ImgUpload:", JSON.stringify(e))
  return e
}
}
 */