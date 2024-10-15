import { request } from '@kit.BasicServicesKit';

//上传回调数据类型
export interface ReceiveRes {
  body: string
  headers: object
}

export interface DialogProps {
  uploadURL: string;
  success: (res: ReceiveRes) => void;
  fail: (res: request.TaskState[]) => void;
  complete: (res: request.TaskState[]) => void;
  cacheComplete: (path: string) => void;
}
