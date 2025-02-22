import reminderAgentManager from '@ohos.reminderAgentManager'
@Entry
@Component
struct ClockCase {
@State
reminderId: number = 0
  build() {
    Row() {
      Column() {
        Button("发布闹铃")
          .onClick(async () => {
            let obj: reminderAgentManager.ReminderRequestAlarm  = {
              reminderType:  reminderAgentManager.ReminderType.REMINDER_TYPE_ALARM, // 代理提醒类型
              hour: 20,
              minute: 39,
              daysOfWeek: [],
              ringDuration: 80
            }
           this.reminderId = await reminderAgentManager.publishReminder(obj)
            // 没响铃之前 是可以取消的
            // reminderAgentManager.cancelReminder(reminderId)
          })

        Button("取消闹铃")
          .onClick(() => {
            reminderAgentManager.cancelReminder(this.reminderId)
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}