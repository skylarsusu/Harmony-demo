import http from '@ohos.net.http'
@Entry
@Component
struct HttpCase {
  aboutToAppear() {
    this.getData()
  }
  async getData () {
    try {
      const req = http.createHttp()
      const res = await req.request("https://zhoushugang.gitee.io/fe2022/takeaway.json")
      // 执行成功的代码
      // res.result
      // await 会强制等待后面的promise进行resolve
      // 让我们用同步的方式去写异步
      // async和await必须配套使用
      AlertDialog.show({
        message: res.result as string
      })
    }catch (error) {
       // 处理失败的情况
    }

  }
  build() {
    Row() {
      Column() {

      }
      .width('100%')
    }
    .height('100%')
  }
}