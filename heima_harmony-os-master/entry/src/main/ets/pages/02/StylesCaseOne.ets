// 全局样式没啥用 不能导出 导出也没办法用
@Styles function  textStyle () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
}



@Entry
@Component
struct StylesCaseOne {
 // 局部样式复用
  @Styles
  textStyle () {
    .width(120)
    .height(60)
    .borderRadius(30)
    .backgroundColor(Color.Gray)
  }
  build() {
    Row() {
      Column({ space: 20 }) {
         Text("测试")
           .textStyle()
           .textAlign(TextAlign.Center)
           .fontSize(20)
        Text("测试2")
          .textStyle()
          .textAlign(TextAlign.Center)
          .fontSize(20)
      }
      .width('100%')
    }
    .height('100%')
  }
}