@Entry
@Component
struct AnimateToCase {
  @State
  showCom: boolean = false

  @State
  showImg: boolean = false
  build() {
    Row() {
      Column({ space: 20 }) {
        Row() {
          if(this.showCom) {
            Row(){
              Text("元素进场").fontColor(Color.White).fontSize(40)
            }
            .justifyContent(FlexAlign.Center)
            .width(280)
            .height(100)
            .backgroundColor(Color.Blue)
            .transition({
              type: TransitionType.Insert,  // 插入时的动画
              translate: {
                x: '-100%'
              },
              opacity: 0
            })
            .transition({
              type: TransitionType.Delete,
              translate: {
                x: '100%'
              },
              opacity: 0
            })
          }
        }.width(280)
        .height(100)

        Button("显示/隐藏")
          .onClick(() => {
            animateTo({
              duration: 500
            }, () => {
              this.showCom = !this.showCom
            })

          })
        Row() {
          if(this.showImg) {
            Image($r("app.media.handsome"))
              .width(150)
              .height(150)
              .borderRadius(75)
              .transition({
                type: TransitionType.Insert,
                rotate: {
                  angle: -360
                },
                opacity: 0,
                translate: {
                  x: '-100%'
                },
                scale: {
                  x: 0.2,
                  y: 0.2
                }
              })
              .transition({
                type: TransitionType.Delete,
                rotate: {
                  angle: 360
                },
                opacity: 0,
                translate: {
                  x: '100%'
                },
                scale: {
                  x: 0.2,
                  y: 0.2
                }
              })
          }
        }.height(150).width('100%').justifyContent(FlexAlign.Center)

        Button("滚进来/滚出去")
          .onClick(() => {
            animateTo({ duration: 1000 }, () => {
              this.showImg = !this.showImg
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}