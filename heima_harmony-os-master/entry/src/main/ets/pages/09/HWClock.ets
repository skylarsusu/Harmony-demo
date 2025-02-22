import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { ClockItemClass, MyClockStore } from './ClockStore'
import reminderAgentManager from '@ohos.reminderAgentManager'
@Entry
@Component
struct HWClock {
  myStore: MyClockStore = new MyClockStore()
  @State
  list: ClockItemClass[] = []

  async onPageShow() {
    this.list =  await this.myStore.getClockList()
  }
  build() {
    Stack({ alignContent: Alignment.Bottom }){
      Column({ space: 15 }) {
        Text('闹钟')
          .fontSize('24')
          .width('100%')

        CanvasClock()  // 放置表盘

        // 放置N个的闹钟任务

        List({ space: 10 }) {
          ForEach(this.list,  (item: ClockItemClass) => {
            ListItem() {
              ClockItem({ item, changeClockEnable: async (id: string) => {
                // 有id找索引
                const index = this.list.findIndex(item => item.id === id)

                if(item.enabled) {
                  // 取消
                  reminderAgentManager.cancelReminder(item.reminderId)
                }else {
                  // 新建
                  let reminderObj:  reminderAgentManager.ReminderRequestAlarm = {
                    hour: item.hour,
                    minute: item.minute,
                    daysOfWeek: [],
                    ringDuration: 60,
                    // 提醒类型为闹钟类型
                    reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM
                  }
                  const reminderId =  await reminderAgentManager.publishReminder(reminderObj)
                  item.reminderId = reminderId // 再把标识赋值
                }
                item.enabled = !item.enabled // 需要把值变一下
                this.list.splice(index, 1)  // 删除这个选项
                this.list.splice(index, 0, item) // 添加这个选项
                this.myStore.setClockList(JSON.stringify(this.list)) // 写入首选项

              }})
                .onClick(() => {
                   router.pushUrl({
                     url: 'pages/09/AddClock',
                     params: {
                       id: item.id
                     }
                   })
                })
            }
          })
        }
      }
      .padding(15)
      .height('100%')
      .width('100%')
      .backgroundColor('#f5f5f5')


      // 添加
      Text('+')
        .width(50)
        .aspectRatio(1)
        .backgroundColor('#06f')
        .fontSize(40)
        .fontWeight(100)
        .fontColor('#fff')
        .borderRadius(25)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 50 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/09/AddClock'
          })
        })
    }
  }
}


// 时钟组件  主要的目的是 画表盘 画针

@Component
struct CanvasClock {
  // 直接用canvas画
  canvasSize: number = 252
  panImage: ImageBitmap = new ImageBitmap("/images/ic_clock_pan.png")
  // 时针
  hourImage: ImageBitmap = new ImageBitmap("/images/ic_hour_pointer.png")
  // 分针
  minImage: ImageBitmap = new ImageBitmap("/images/ic_minute_pointer.png")
  // 秒针
  secondImage: ImageBitmap = new ImageBitmap("/images/ic_second_pointer.png")

  timer: number = 0

  context: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  drawClock () {

   this.timer = setInterval(() => {
      this.context.clearRect(0,0, this.canvasSize, this.canvasSize)
      this.context.drawImage(this.panImage, 0, 0, this.canvasSize, this.canvasSize)
      // 画时针 分针 秒针
      const currentTime = new Date() // 拿到当前时间
      const hour = currentTime.getHours() % 12 / 12 * 360 + currentTime.getMinutes() / 60 * 30 // 21 9     % 12 / 12 * 360
      const min = currentTime.getMinutes() / 60 * 360 + currentTime.getSeconds() / 60 * 6
      const second = currentTime.getSeconds() / 60 * 360

      this.drawPointer(this.hourImage, hour )
      this.drawPointer(this.minImage, min)
      this.drawPointer(this.secondImage, second)
    }, 1000)

    // this.context.drawImage(this.minImage, this.canvasSize / 2 - 4,0, 8, this.canvasSize)
    // this.context.drawImage(this.secondImage, this.canvasSize / 2 - 4,0, 8, this.canvasSize)
  }
  // 专门画针
  drawPointer (img: ImageBitmap, angle: number) {
    // 如何让我们的时针正确的指向12点
    // 0,0
    this.context.save() // 保存路径
    this.context.translate(this.canvasSize / 2, this.canvasSize / 2) // 原点 挪到了表盘中心
    this.context.rotate((angle + 180) * Math.PI / 180) // 旋转的不是角度 而是弧度 Math.PI / 180
    // 此时还不能画
    this.context.translate(-this.canvasSize / 2, -this.canvasSize / 2)
    this.context.drawImage(img, this.canvasSize / 2 - 4,0, 8, this.canvasSize)
    this.context.restore() // 恢复画布的设置
  }
  aboutToDisappear() {
    clearInterval(this.timer)
  }
  build() {
    Canvas(this.context)
      .width(252)
      .aspectRatio(1)
      .onReady(() => {
        this.drawClock()
      })

  }
}


@Component
export struct ClockItem {
  item: Partial<ClockItemClass>  = {}
  changeClockEnable: (id: string) => void = () => {}
  build() {
    Row(){
      Column({ space: 5 }) {
        Row({ space: 5 }){
          Text(`${this.item.hour > 12 ? '下午' : '上午'}`)
            .fontColor('#666')
          Text(`${this.item.hour}:${this.item.minute}`)
            .fontWeight(600)
            .fontSize(18)
        }
        Row({ space: 15 }){
          Text('闹钟')
            .fontColor('#999')
            .fontSize(14)
          Text('不重复')
            .fontColor('#999')
            .fontSize(14)
        }
      }
      .alignItems(HorizontalAlign.Start)

      // 开关
      Toggle({ type: ToggleType.Switch , isOn: this.item.enabled })
        .onChange(() => {
          // 只有值发生变化 就应该有所动作
          this.changeClockEnable(this.item.id)
        })
    }
    .height(64)
    .padding({ left: 20, right: 15 })
    .width('100%')
    .backgroundColor('#fff')
    .borderRadius(30)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}