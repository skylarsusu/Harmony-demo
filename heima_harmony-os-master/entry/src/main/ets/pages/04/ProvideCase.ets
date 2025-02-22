import promptAction from '@ohos.promptAction'
@Entry
@Component
struct ProvideCase {
  @State message: string = 'Hello World'
  @Provide('aa')
  @Watch("updateMoney")
  money: number = 1000
  updateMoney() {
    promptAction.showToast({ message: '谁动了我的钱包' })
  }
  build() {
    Row() {
      Column({ space: 20 }) {
        Text(`老夫有碎银${this.money.toString()}两`).fontSize(40)
        Divider().strokeWidth(6).color(Color.Red)
        Father()
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct Father {
  @Consume
  money: number
  build() {
    Column () {
      Text("父亲组件").fontSize(30)
        .onClick(() => {
          this.money+=2
        })
      Divider().strokeWidth(6).color(Color.Green)
      Son()
    }
  }
}

@Component
struct Son {
  @Consume('aa')
  money: number
  build() {
    Text(`接收到爷爷的钱${this.money.toString()}`)
      .fontSize(40)
      .onClick(() => {
        this.money-=10
      })
  }
}

// 层级更高的组件进行Provide 层级低的组件进行consume