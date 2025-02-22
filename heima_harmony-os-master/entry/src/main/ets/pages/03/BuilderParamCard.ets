@Entry
@Component
struct BuilderParamCard {
  @State message: string = 'Hello World'


  @Builder
  getCardItem () {
    HmCardItem({ leftTitle: '员工姓名', rightValue: '张三' })
    HmCardItem({ leftTitle: '员工编号', rightValue: '张三' })
    HmCardItem({ leftTitle: '员工权限', rightValue: '张三' })
    HmCardItem({ leftTitle: '员工组织', rightValue: '张三' })
    HmCardItem({ leftTitle: '员工上级', rightValue: '老高', showBottomBorder: false })
  }

  build() {
    Row() {
      Column() {
         HmCard2({ CardFn: this.getCardItem })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}

@Component
struct HmCard2 {
  @BuilderParam
  CardFn: () => void = () => {}
  build() {
    Column() {
      Column(){
         //  传插槽内容
        this.CardFn()
      }.backgroundColor(Color.White)
      .width('100%')
      .borderRadius(8)

    }.margin({
      top: 10
    }).padding({
      left: 15,
      right: 15
    })
  }
}

@Component
struct HmCardItem {
  leftTitle: string = ""
  rightValue: string = ""
  showBottomBorder: boolean = true
  build() {
    Row() {
      Text(this.leftTitle)
      Text(this.rightValue).fontColor("#ccc")
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: 10,
      right: 10
    })
    .height(50)
    .border({
      color: '#f4f5f6',
      width: {
        bottom: this.showBottomBorder ?  1 : 0
      }

    })
  }
}