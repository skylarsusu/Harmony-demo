
import router from '@ohos.router'

let user: Record<string, UserInfoClass> = {
  "user": {
    username: '老高',
    age: 34
  }
}
const local = new LocalStorage(user)

export { local }
@Entry(local)
@Component
struct LocalStorageCase {
 @LocalStorageProp("user")
 myUser: Partial<UserInfoClass> = {}

  @LocalStorageLink("user")
  myUser2: Partial<UserInfoClass> = {}
  build() {
    Row() {
      Column() {
        Row() {
          Text(this.myUser.username)
          Text(this.myUser.age.toString())
        }
        Button("跳转")
          .onClick(() => {
             router.pushUrl({
               url: 'pages/04/LocalStorageCase2'
             })
          })
        Button("更改数据")
          .onClick(() => {
              this.myUser2.username = "老高好难"
          })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Pink)
  }
}

export  class UserInfoClass {
  username: string = ""
  age: number = 0
}