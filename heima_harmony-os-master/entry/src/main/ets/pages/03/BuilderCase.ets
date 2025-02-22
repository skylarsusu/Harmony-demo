@Builder
function getCellContent(leftTitle: string, rightValue: string) {
  Row() {
    Row() {
      Text(leftTitle)
      Text(rightValue)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 15,
      right: 15
    })
    .borderRadius(8)
    .height(40)
    .backgroundColor(Color.White)
  }.padding({
    left: 10,
    right: 10
  })

}

class CardClass {
  time: string = ""
  location: string = ""
  type: string = ""
}
class CellParams {
  leftTitle: string = ""
  rightValue: string = ""
}
@Entry
@Component
struct BuilderCase {
  @State
  formData: CardClass = {
    time: "2023-12-12",
    location: '回龙观',
    type: '漏油'
  }
  @Builder
  getCellContent(Obj: CellParams) {
    Row() {
      Row() {
        Text(Obj.leftTitle)
        Text(Obj.rightValue)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        left: 15,
        right: 15
      })
      .borderRadius(8)
      .height(40)
      .backgroundColor(Color.White)
    }.padding({
      left: 10,
      right: 10
    })

  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(JSON.stringify(this.formData))
        this.getCellContent({ leftTitle: '异常类型', rightValue: this.formData.type })
        this.getCellContent({ leftTitle: '异常地址', rightValue: this.formData.location })
        this.getCellContent({ leftTitle: '异常时间', rightValue: this.formData.time })

       Button("修改异常位置")
         .onClick(() => {
           this.formData.location = "顺义"
         })

      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor('#ccc')
  }
}