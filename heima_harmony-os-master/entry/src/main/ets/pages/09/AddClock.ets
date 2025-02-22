import promptAction from '@ohos.promptAction'
import util from '@ohos.util'
import reminderAgentManager from '@ohos.reminderAgentManager'
import { MyClockStore, ClockItemClass } from './ClockStore'
import router from '@ohos.router'
@Entry
@Component
struct AddClock {
  myStore: MyClockStore  = new MyClockStore()

  // @State如果直接修饰Date类型的参数 直接报错
  // 如果修饰的是一个class class里面有date 不报错
  @State
  currentClock: Partial<ClockItemClass>  = {}
  @State
  currentTime: CurrentTime = { time: new Date() }
   // 添加闹钟
  async addClock () {
    const hour = this.currentTime.time.getHours()
    const minute =  this.currentTime.time.getMinutes()
    // 系统代理一个闹钟之后 才会返回一个id
    let reminderObj:  reminderAgentManager.ReminderRequestAlarm = {
      hour,
      minute,
      daysOfWeek: [],
      ringDuration: 60,
      // 提醒类型为闹钟类型
      reminderType: reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM
    }
    const list = await this.myStore.getClockList()

    // 如何判断
    if(this.currentClock.id) {
      if(this.currentClock.reminderId) {
        // 取消闹钟
        reminderAgentManager.cancelReminder(this.currentClock.reminderId)
      }
      // 新增闹钟
      const reminderId = await reminderAgentManager.publishReminder(reminderObj)
      this.currentClock.reminderId = reminderId
      this.currentClock.hour = hour
      this.currentClock.minute = minute
      const index = list.findIndex(item => item.id === this.currentClock.id)
      list.splice(index,1, this.currentClock as ClockItemClass)
      // 写入磁盘
      this.myStore.setClockList(JSON.stringify(list))
      router.back()
      // 存储首选项
      // 编辑
      return
    }

    let obj: ClockItemClass = {
      hour,
      minute,
      id: util.generateRandomUUID(),
      enabled: true,
      // reminderId:
    }

    const reminderId = await reminderAgentManager.publishReminder(reminderObj)
    obj.reminderId = reminderId // 拿到代理之后id就可以 写入我们的首选项
    list.push(obj)  // 将闹铃数据加入首选项
    this.myStore.setClockList(JSON.stringify(list)) // 写入首选项
    router.back()
  }
  async aboutToAppear() {
    // 坑点-如果不传参数 params是个undefind
   const obj = router.getParams() as ClockParams
    if(obj && obj.id) {
      // 传进来id
      this.myStore.getClockList()
      const list = await this.myStore.getClockList()
      this.currentClock = list.find(item => item.id === obj.id)
      // 记录它的目的是为了存储
      // 要把当前的闹钟的时分设置给当前的时间选择器
      // arkts 所有的更新都只能感知到第一层
      const date = new Date()
      date.setHours(this.currentClock.hour)
      date.setMinutes(this.currentClock.minute)
      this.currentTime.time = date // 只更新第一层数据
    }
  }
  // 只有编辑情况下才可以删除
 async delClock () {
    if(this.currentClock.id) {
      // 删除闹钟-首选项-取消闹铃
      if(this.currentClock.reminderId) {
        reminderAgentManager.cancelReminder(this.currentClock.reminderId)
      }
      let list =  await this.myStore.getClockList()
      const index = list.findIndex(item => item.id === this.currentClock.id)
      list.splice(index, 1)
      this.myStore.setClockList(JSON.stringify(list))
      router.back()
      // list = list.filter(item => item.id !== this.currentClock.id)
    }
  }
  build() {
    Navigation() {
      TimePicker({ selected: this.currentTime.time })
        .borderRadius(16)
        .onChange((result) => {
          this.currentTime.time.setHours(result.hour)
          this.currentTime.time.setMinutes(result.minute)

        })

      Text("删除闹铃")
        .width(100)
        .height(40)
        .borderRadius(20)
        .backgroundColor("#c3c4c5")
        .textAlign(TextAlign.Center)
        .fontColor("#f00")
        .opacity(0.4)
        .margin({
          top: 30
        })
        .onClick(() => {
           this.delClock()
        })

    }
    .title(this.currentClock.id ? '编辑闹钟' : "新建闹钟")
    .titleMode(NavigationTitleMode.Mini)
    .menus([
      {
        value: '',
        icon: '/images/ic_confirm.png',
        action: () => {
          // 处理逻辑
          this.addClock()
        }
      }
    ])
  }
}


class  CurrentTime {
  time: Date = new Date()
}

class ClockParams {
  id: string = ""
}