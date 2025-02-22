@Entry
@Component
struct CanvasCase {
  // 显示声明 画笔对象
  context: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  build() {
   Column ({ space: 20 }) {
     // 1 放置画布 给宽高
     Canvas(this.context)
       .width('100%')
       .aspectRatio(1.2)
       .backgroundColor(Color.Grey)
       .onReady( () => {
         // canvas已经准备好了
         // this.context.lineWidth = 4
         // this.context.strokeStyle = "#fff"
         // this.context.rect(0,0, 100, 100)
         // this.context.stroke() // 完成绘制框的渲染
       })
     .onAreaChange((old: Area, newArea: Area) => {
       // AlertDialog.show({ message: JSON.stringify(newArea) })
     })
     Row({ space: 20 }) {
       Button("画线")
         .onClick(() => {
           // 闭环隔离  开始绘制-结束绘制
           this.context.beginPath()
            this.context.lineWidth = 4 // 线的宽度
            this.context.strokeStyle = 'blue'
            this.context.moveTo(50, 50)
            this.context.lineTo(250, 200)
            this.context.stroke()  //
           this.context.closePath() // 结束绘制

           this.context.beginPath()
            // 绘制红线
           this.context.strokeStyle = "red"
           this.context.moveTo(50, 240)
           this.context.lineTo(250, 240)
           this.context.stroke()
           this.context.closePath() // 结束绘制
         })
       Button("画圆")
         .onClick(() => {
           // 画圆
           this.context.beginPath()
           this.context.lineWidth = 6
           this.context.strokeStyle = "blue"
           this.context.fillStyle = "red"
           this.context.arc(180, 150, 140, 0, 90)
           this.context.stroke()  // 绘制线框

           // this.context.fill()
           this.context.closePath()
         })
       Button("绘制矩形")
         .onClick(() => {
           this.context.beginPath()
           this.context.lineWidth = 6
           this.context.strokeStyle = "blue"
           this.context.rect(90,75,150, 150)
           this.context.stroke()
           this.context.fill()
           this.context.closePath()
         })
       Button("清除面板")
         .onClick(() => {
           this.context.clearRect(0,0,360, 300)
         })
     }
   }
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}