@Entry
@Component
struct PropCase {
  @State message: string = 'Hello World'
  @State num: number  = 0
  build() {
    Row() {
      Column({ space: 20 }) {
        Text(this.num.toString()).fontSize(50).fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.num++
            console.log("laogao","测试"+ this.num)
          })
        Divider()
          .strokeWidth(6)
        Child({ num: $num })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Child {
  @Link
  num: number
  build() {
    Text(this.num.toString()).fontColor(Color.Red).fontSize(40)
      .onClick(() => {
        this.num++
      })
  }
}