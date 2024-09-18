import cloud from '@hw-agconnect/cloud';

// import { add } from '../algorithm/add_ts'

@Entry
@Component
struct AddPage {
  @State message: string = ''
  @State number1: number = 0
  @State number2: number = 0
  @State result: number = 0

  build() {
    Column({ space: 20}){
      Text(`${this.number1}`)
        .onClick(() => {
          this.number1++
        })

      Text(`${this.number2}`)
        .onClick(() => {
          this.number2++
        })

      Button('云函数')
        .onClick(async() => {
          const result = await cloud.callFunction(
            {
              name: 'preprocess', //调用云函数的名称
              version: '$latest', //云函数版本
              params:{} //可选参数，传递给输入参数event
            }
          )
          this.message=result.getValue().message;

          console.log('Cloud',this.message)
        })

      Text(`${this.message}`)
    }
  }
}