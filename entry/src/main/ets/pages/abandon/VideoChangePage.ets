import { window } from '@kit.ArkUI';

@Entry
@Component
struct VideoChangePage {
  @State show: boolean = true;
  // XComponent的控制器
  private mXComponentController: XComponentController = new XComponentController();
  // XComponent宽度
  @State xComponentWidth: number | string = 0;
  // XComponent高度
  @State xComponentHeight: number | string = 0;
  @State isFull: boolean = false; // 默认非全屏

  // 设置窗口方向
  setR(orientation: number) {
    window.getLastWindow(getContext(this)).then((win) => {
      win.setPreferredOrientation(orientation).then((data) => {
        console.log('setWindowOrientation: ' + orientation + ' Succeeded. Data: ' + JSON.stringify(data));
      }).catch((err: string) => {
        console.log('setWindowOrientation: Failed. Cause: ' + JSON.stringify(err));
      });
    }).catch((err: string) => {
      console.log('setWindowOrientation: Failed to obtain the top window. Cause: ' + JSON.stringify(err));
    });
  }

  aboutToAppear() {

    this.xComponentWidth = '100%';
    this.xComponentHeight = '40%';
    window.getLastWindow(getContext(this)).then((win) => {
      // 监听屏幕尺寸变化，变化后修改XComponent的宽高
      win.on('windowSizeChange', (size) => {
        console.log('windowSizeChange:' + JSON.stringify(size));
        // 全屏时宽高占满屏幕
        if (this.isFull) {
          this.xComponentWidth = px2vp(size.width);
          this.xComponentHeight = px2vp(size.height);
        } else {
          // 非全屏时宽度100%，高度40%
          this.xComponentWidth = px2vp(size.width);
          this.xComponentHeight = '40%';
        }
      })
    })
  }

  playVideo() {}

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
        XComponent({
          id: 'componentId',
          type: 'surface',
          controller: this.mXComponentController
        })
          .width(this.xComponentWidth)
          .height(this.xComponentHeight)
          .backgroundColor(Color.Black)
          .onLoad(() => {
            this.playVideo();
          })
      }
      Button('横竖屏切换').onClick(() => {
        // 全屏时，横变竖
        if (this.isFull) {
          this.setR(1);
          this.isFull = false;
        } else { // 非全屏时，竖变横
          this.isFull = true;
          this.setR(4);
        }
      }).position({ x: 0, y: 0 }).backgroundColor(Color.Green)
      // 添加自动旋转按钮
      Button('自动旋转').onClick(() => {
        this.setR(5);
      }).position({ x: 100, y: 0 }).backgroundColor(Color.Blue)
    }.width('100%').height('100%').backgroundColor(Color.Red)
  }
}
