import promptAction from '@ohos.promptAction'
@Entry
@Component
struct GuessCanvas {
  // 画笔对象
  context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  guessContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  drawIng: boolean = false
  lastX: number = 0  // 上面画布的上一个点
  lastY: number = 0

  gLastX: number = 0  // 下面画布的x和y
  gLastY: number = 0

  pointList: PointClass[] = [] // 用来记录上方的canvas的坐标点的

  @State
  imgUrl: string = ""  // 用来存储签字的图片

  timer: number = -1
  // 画线
  drawLine (x: number, y: number) {
    this.context.moveTo(this.lastX, this.lastY)  // 先把点移动到上一次的位置
    this.context.lineTo(x, y)
    this.lastX = x  // 记录这一次的位置
    this.lastY = y
    this.context.stroke()

  }

  // drawGuess开始绘制下面的猜的画布
  drawGuess () {
    if(this.pointList.length && this.timer === -1) {

      // 一个点一个点去拿 每个点有间隔时间
      this.timer = setInterval(() => {
        if(this.pointList.length === 0) {
          // 所有的坐标点都画完了
          clearInterval(this.timer)
          this.timer = -1 // 回置定时器为-1
          return
        }
        // 取做坐标点画线
        let p: PointClass = this.pointList.shift() // 取出数组的第一个内容
        // 画线
        this.guessLine(p)  // 开始画线
      }, 10)
    }
  }
  // 实现画线
  guessLine (p: PointClass) {
    // p x y  reset
    if(p.reset) {
      // 关闭上一次的绘画路径
      // 打开下一次的绘画路径
      this.guessContext.closePath()
      this.guessContext.beginPath()
      this.gLastX = p.x
      this.gLastY = p.y
    }else {
      this.guessContext.moveTo(this.gLastX, this.gLastY)
      this.guessContext.lineTo(p.x, p.y)
      this.gLastX = p.x
      this.gLastY = p.y
      this.guessContext.stroke()
    }
  }
  build() {
    // 1.放置两块画板
    Scroll() {
      Column ({ space: 20 }) {
        Canvas(this.context)
          .width('100%')
          .aspectRatio(1.2)
          .backgroundColor(Color.Gray)
          .onTouch((event: TouchEvent) => {
            if(event.type === TouchType.Down) {
              // 开始绘画
              this.drawIng = true
              // 开始作画 是从这个点开始的
              this.lastX = event.touches[0].x
              this.lastY = event.touches[0].y
              this.context.beginPath()  // 开始绘画
              // 开始记录坐标点
              this.pointList.push({
                x:  this.lastX,
                y: this.lastY,
                reset: true  // 按下去意味着重新开始一段路径
              })
            }
            if(event.type === TouchType.Up) {
              // 结束绘画
              this.drawIng = false
              this.context.closePath()
              // 让下方的画布开始从PointList中拿一个个的坐标点 开始作图了
              this.drawGuess()
            }
            if(event.type === TouchType.Move) {
              // 绘画
              if(this.drawIng) {
                // 拿到移动的x和 y
                // promptAction.showToast({ message: '绘画' })
                this.drawLine(event.touches[0].x, event.touches[0].y)
                // 记录移动的坐标点
                this.pointList.push({
                  x: event.touches[0].x,
                  y: event.touches[0].y,
                  reset: false
                })
              }

            }
          })
          .onReady(() => {
            this.context.lineWidth =  4
            this.context.strokeStyle = 'blue'
          })
        // 下面的画布
        Canvas(this.guessContext)
          .width('100%')
          .aspectRatio(1.2)
          .backgroundColor(Color.Red)
          .onReady(() => {
            this.guessContext.lineWidth = 4
            this.guessContext.strokeStyle = "#fff"
          })

        Row({ space: 20 }) {
          Button("清空画布")
            .onClick(() => {
              this.context.clearRect(0,0, 360, 300)
              this.guessContext.clearRect(0,0, 360, 300)
              this.pointList = []
            })
          Button("签字板保存")
            .onClick(() => {
              this.imgUrl = this.context.toDataURL("image/png")
            })
        }
        if(this.imgUrl) {
          //Image(this.imgUrl).width('100%').aspectRatio(1.2)
        }

      }
    }

  }
}

// 定义一个对象类型
class  PointClass {
  x: number = 0
  y: number = 0
  reset?: boolean = false  // 是否重新开始一段路径
}