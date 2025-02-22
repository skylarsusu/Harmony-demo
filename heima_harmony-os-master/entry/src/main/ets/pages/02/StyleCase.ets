@Entry
@Component
struct StyleCase {
  @State message: string = 'Hello World'

  build() {
    Row() {

      Column() {

      }
      .width('50%')
      .aspectRatio(1)
      .backgroundColor(Color.Red)
      // Column() {
        // 背景色设置Pink'
        // 字体大小设置成 40
        // 对其方式设置成居右
        // 宽度设置200
        // 高度设置100
        // Text(this.message)
        //   .backgroundColor(Color.Pink)
        //   .fontSize(40)
        //   .width(200)
        //   .height(100)
        //   .textAlign(TextAlign.End)
        // Text("像素VP测试")
        //   .fontSize("50") // 1080的像素密度  1 vp相当于3px  375  - 1080- 360
      // }
      // .width('100%')
      // .justifyContent(FlexAlign.SpaceBetween)
      // Row() {
      //   Text("左侧内容")
      //   Row()
      //     .backgroundColor(Color.Red)
      //     .height(50)
      //     .layoutWeight(1)
      //   Row()
      //     .backgroundColor(Color.Blue)
      //     .height(50)
      //     .layoutWeight(10)
      // }.width('100%')
    }
    .height('100%')
  }
}