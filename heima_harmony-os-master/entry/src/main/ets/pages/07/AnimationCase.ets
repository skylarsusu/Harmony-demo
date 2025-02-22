@Entry
@Component
struct AnimationCase {
  @State
  widthSize: number = 100
  @State
  heightSize: number  = 40

  @State
  scaleValue: number = 1

  @State
  animateObj: AnimateParam = {
    duration: 500,
    playMode: PlayMode.Alternate,
    iterations: -1
  }
  build() {
    Row() {
      Column({ space: 20 }) {
        Button("属性动画")
          .width(this.widthSize)
          .height(this.heightSize)
          .animation({
            duration: 1000,
            iterations: -1,
            curve: Curve.Ease,
           // delay: 2000 延时事件
            playMode: PlayMode.Alternate
          })


        Button("按钮变化")
          .onClick(() => {
            this.widthSize = 200
            this.heightSize = 80
          })

        Image($r("app.media.favorite_block"))
          .width(60)
          .height(60)
          .scale({
            x: this.scaleValue,
            y: this.scaleValue
          })
          .fillColor(Color.Red)
          .animation(this.animateObj)

        Button(this.scaleValue === 1 ? "开始心跳" : '停止心跳')
          .onClick(() => {
             if(this.scaleValue === 1) {
               this.scaleValue = 3
               this.animateObj = {
                 duration: 100,
                 playMode: PlayMode.Alternate,
                 iterations: -1
               }
             }else {
               this.animateObj = {
                 duration: 0
               }
               this.scaleValue = 1
             }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}