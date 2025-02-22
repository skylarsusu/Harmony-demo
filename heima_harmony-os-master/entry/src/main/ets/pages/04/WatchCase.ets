import promptAction from '@ohos.promptAction'
@Entry
@Component
struct WatchCase {
  @State
  @Watch("updateMessage")
  message: string = 'Hello World'
  @State
  @Watch('updateNum')
  num: number  = 0
  updateMessage() {
    //
  }
  updateNum() {
    promptAction.showToast({ message: '数据变了' })
  }
  build() {
    Row() {
      Column({ space: 20 }) {
        // Text(this.message)
        //   .fontSize(50)
        //   .fontWeight(FontWeight.Bold)
        //   .onClick(() => {
        //     this.message = "Hello Harmony" + Math.random().toFixed(5)
        //   })
        Text(this.num.toString()).fontSize(30)
          .onClick(() => {
            this.num++
          })

        Divider().strokeWidth(6)
        // ChildComp({ num: this.num })

        ChildComp2({ num: $num })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct ChildComp {
  @Prop
  @Watch('updateNum')
  num: number

  updateNum() {
    AlertDialog.show({ message: '当前的值是'+ this.num.toString() })
  }
  build() {

  }
}

@Component
struct ChildComp2 {
  @Link
  num: number

  build() {
    Text(this.num.toString())
      .fontSize(40)
      .fontColor(Color.Red)
      .onClick(() => {
        this.num++
      })
  }
}