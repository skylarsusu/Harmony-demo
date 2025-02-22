import { MatchPattern } from '@ohos.UiTest'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World3'

  build() {
    // 它的子组件都会以纵向方式排列
    Column() {
      Header()
      Main()
      Footer()
    }
  }
}

@Component
struct Header {
  build() {
    Row(){
      Text("Header")
    }
      .width('100%')
      .height(50)
      .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Main {
  build() {
    Row(){
      Text("Main")
        .fontColor(Color.White)
    }
    .width('100%')
    .height(200)
    .backgroundColor(Color.Blue)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct Footer {
  build() {
    Row(){
      Text("Footer")
        .fontColor(Color.White)
    }
    .width('100%')
    .height(50)
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
  }
}