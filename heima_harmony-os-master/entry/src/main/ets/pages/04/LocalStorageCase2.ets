import { local, UserInfoClass } from './LocalStorageCase'
@Entry(local)
@Component
struct LocalStorageCase2 {
 @LocalStorageProp("user")
   myUser: Partial<UserInfoClass> = {}
  build() {
    Row() {
      Column() {
        Row() {
          Text(this.myUser.username)
          Text(this.myUser.age.toString())
        }
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(Color.Brown)
  }
}