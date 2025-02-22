import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
@Entry
@Component
struct LiveCase {
  @State message: string = 'Hello World'
  onPageShow() {
    promptAction.showToast({
      message: '页面显示',
      duration: 5000
    })
  }
  onPageHide() {
    promptAction.showToast({
      message: '页面隐藏',
      duration: 5000
    })
  }
  onBackPress() {
    promptAction.showToast({
      message: '页面返回',
      duration: 5000
    })
  }
  aboutToAppear() {}
  aboutToDisappear() {

  }
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.pushUrl({
              url: "pages/06/HmList"
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}