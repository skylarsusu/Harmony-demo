@Entry
@Component
struct BuilderParamCase {
  @State message: string = 'Hello World'

  @Builder
  renderBtn () {
    Button("我是一脸懵逼进来的")
      .backgroundColor(Color.Red)
  }
  @Builder
  renderImg () {
    Image($r('app.media.handsome'))
      .width(100)
      .height(100)
      .borderRadius(50)
  }
  @Builder
  renderInput () {
    TextArea().width('80%')
  }
  build() {
    Row() {
      Column({ space: 20}) {
        // HmCard({
        //   getContent: this.renderBtn  // 按钮
        // })
        // HmCard({
        //   getContent: this.renderImg // 图片
        // })
        // HmCard({
        //   getContent: this.renderInput // 输入框
        // })
        HmCard() {
            Text("老高啊 受不了啦")
            Text("老高啊 受不了啦")
            Text("老高啊 受不了啦")
            Text("老高啊 受不了啦")
            Text("老高啊 受不了啦")
        }
        HmCard() {
           Image($r('app.media.handsome'))
             .width(200)
             .height(200)
             .borderRadius(100)
          this.renderBtn()
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct HmCard {
  @BuilderParam
  getContent: () => void = () => {}
  build() {
    Column() {

     Divider()
       .strokeWidth(6)
       .color(Color.Green)

      this.getContent()  // 渲染传入的内容

    }
    .backgroundColor(Color.Gray)
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
  }
}