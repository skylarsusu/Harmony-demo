import router from '@ohos.router'
@Entry
@Component
struct HmDetail {
  @State
  currentId: number = 0
  aboutToAppear() {
   const params = router.getParams()  as RouterParamsClass
    if(params?.id) {
      this.currentId = params.id
    }
  }
  build() {
    Column({ space: 20 }) {
      Text("详情页" + this.currentId).fontSize(50)
      Button("返回上一页")
        .onClick(() => {
          AppStorage.SetOrCreate<number>("myId", Date.now())
          router.back({
            url: 'pages/06/HmList',
            params: {
              detailId: Date.now()
            }
          })
        })
      Button("跳到列表页")
        .onClick(() => {
          router.pushUrl({
            url: 'pages/06/HmList'
          })
        })
      Button("单例模式跳到列表页")
        .onClick(() => {
          router.pushUrl({
            url: 'pages/06/HmList'
          }, router.RouterMode.Single)
        })
    }

  }
}

class RouterParamsClass {
  id: number = 0
}