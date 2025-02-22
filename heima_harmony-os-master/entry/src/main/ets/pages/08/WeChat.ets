import preferences from '@ohos.data.preferences'
import util from '@ohos.util'
import promptAction from '@ohos.promptAction'
import http from '@ohos.net.http'
import notificationManager from '@ohos.notificationManager'
import wantAgent from '@ohos.app.ability.wantAgent'
@Entry
@Component
struct WeChat {
  myHttp: http.HttpRequest = http.createHttp()
  @State
  contentStr: string = "" // 用来记录我们的输入内容
  messStore: MessageStore = new MessageStore()
  @State
  topY: number = 0
  @State
  @Watch("updateMessage")
  messList: MessageItem[] = []
  // 获取一下首选项的数据
  aboutToAppear() {
    this.getMess()
  }
  // 写入首选项
  updateMessage () {
    this.messStore.setMessageList(JSON.stringify(this.messList))
  }
  async getMess () {
   this.messList = await this.messStore.getMessageList()
  }
  // 发送消息的方法
  async sendMessage () {
    // 1.将当前的用户的消息加入到消息列表中
    let selfMessage: MessageItem = {
      avatar: $r("app.media.my"),
      username: '老高',
      content: this.contentStr,
      timestamp: Date.now(),
      self: true,
      id: util.generateRandomUUID()
    }
    this.messList.push(selfMessage) // 数组会更新 => 首选项
    // 2. 发请求this.contentStr}
    const url = `http://api.qingyunke.com/api.php?key=free&appid=0&msg=${encodeURI(this.contentStr)}`
    this.contentStr = "" // 我发我的 我清我的话
    const res = await this.myHttp.request(url)
    // 拿到机器人回复的结果
    const result = JSON.parse(res.result as string) as ResultClass
    if(result.result === 0) {
      // 再加一条聊天记录
       // 需要声明wantAgent的对象

      let want =  await wantAgent.getWantAgent({
        wants: [{
          bundleName: 'com.itheima.heima_harmony', // 包名
          abilityName: 'HeimaPayAbility', // 能力名称
          moduleName: 'HeimaPay', // 模块名称
          parameters: {
            order_id: Date.now()
          }
        }],
        // 点击通知 会启动ability
        operationType: wantAgent.OperationType.START_ABILITY,
        requestCode: 0
      })

      // 给手机应用发送一条通知
      let req: notificationManager.NotificationRequest = {
        id: Date.now(),
        content: {
          contentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,   // 基本文本 长文本
          normal: {
            title: '您的老婆给你发来一条新的消息',
            text: result.content,
            additionalText: '如花的信息'
          }
        },
         wantAgent: want // 为通知添加行为意图
      }
      notificationManager.publish(req)

      let wifeMessage: MessageItem = {
        avatar: $r("app.media.wife"),
        username: '母老虎',
        content: result.content,
        timestamp: Date.now(),
        self: false,
        id: util.generateRandomUUID()
      }
      this.messList.push(wifeMessage) // 加入到列表中

    }else {
      promptAction.showToast({ message: '机器人回复失败' })
    }
  }

  // 聊天对话框
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column () {
        Row() {
          Text("🐶老婆大人")
        }
        .height(50)
        // 聊天对话框
        List({ space: 20 }) {
          // 循环生成聊天对话
           ForEach(this.messList, (item: MessageItem) => {
             // 聊天组件
             ListItem() {
               MessageChat({
                 item,
                 delMessage: (id: string) => {
                   // 调用删除逻辑
                  const index =  this.messList.findIndex(item => item.id === id)
                  this.messList.splice(index, 1)
                 }

               })
             }

           })
        }
        .layoutWeight(1)
        .padding({
          bottom: 80
        })
      }
      .height('100%')
      .position({
        y: this.topY
      })

      // 下面的元素
      Row({ space: 20 }) {
        TextInput({
          text: this.contentStr
        })
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .borderRadius(2)
          .height(40)
          .onChange(value => {
            this.contentStr = value
          })
        Button("发送")
          .height(30)
          .width(60)
          .enabled(!!this.contentStr)
          .onClick(() => {
            // 发送消息-先将我们的消息放在消列表里面
            this.sendMessage()
          })

      }
      .width('100%')
      .height(70)
      .padding({
        left: 20,
        right: 20
      })
    }
    .height('100%')
    .backgroundColor("#ededed")
    .onAreaChange((oldArea: Area, newArea: Area) => {
      this.topY = Math.abs(parseFloat(newArea.globalPosition.y.toString()))
    })
  }
}
// 聊天组件
@Component
struct MessageChat {
  item: Partial<MessageItem>  = {}

  @State
  showDel: boolean = false

  delMessage: (id: string) => void = () => {}

  @Builder
  getDelContent () {
    Button("删除")
      .onClick(() => {
       // this.item.id  // 删除首选项中的内容
         this.delMessage(this.item.id)
      })
  }

  build() {
     Row() {
       Image(this.item.avatar)
         .width(40)
         .height(40)
         .borderRadius(6)
       Row () {
         Text(this.item.content)
           .backgroundColor(this.item.self ? "#8bec73" : Color.White)
           .lineHeight(24)
           .fontColor("#0c2803")
           .padding(10)
           .margin({
             left: 10,
             right: 10
           })
           .gesture(LongPressGesture()
             .onAction(() => {
               // 触发长按回调
                 this.showDel = true
             }))
           // .bindPopup(true, abc{
           //   placement: Placement.Top,
           //   builder: this.getDelContent
           // })

         // popup-系统弹窗 可以针对每个组件设置弹窗
         if(this.showDel) {
           this.getDelContent()  // 调用
         }
       }
       .layoutWeight(5)
       .justifyContent(this.item.self ? FlexAlign.End : FlexAlign.Start)
       Text().layoutWeight(1)
     }
     .padding({
       left: 20,
       right: 20
     })
    .width('100%')
    .direction(this.item.self ? Direction.Rtl : Direction.Ltr)
  }
}




// 数据- 能够读写首选项的 工具或者是class

// 定义一条消息的类型
class MessageItem {
  content: string = "" // 聊天内容
  avatar: ResourceStr = "" // 用户头像
  username: string = "" // 用户昵称
  id: string = "" // 消息id
  timestamp: number = 0
  self: boolean = false // 是否是自身的消息
}
// 首选项来读取或者设置消息
// 工具的class
class MessageStore {
  // 获取首选项示例
  async getStore () {
    return await preferences.getPreferences(getContext(this), "message_store") // 仓库的名称
  }
  // 设置消息
  async setMessageList (json: string) {
    const store = await this.getStore() // 得到对象
    await store.put("message_list", json) // 设置数据
    // 通过put设置之后，需要调用flush方法 才可以将数据存入
    await store.flush()
  }
  // 读取消息
  async getMessageList () {
     // 获取首选项的对象
    const store = await this.getStore() // 得到对象
    const data = await store.get("message_list", "[]") as string
    return JSON.parse(data) as MessageItem[]
  }
}

class ResultClass {
  content: string = ""
  result: number =  0
}