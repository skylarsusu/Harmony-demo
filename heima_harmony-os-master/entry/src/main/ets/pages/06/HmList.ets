import router from '@ohos.router'
@Entry
@Component
struct HmList {
  @State
  list: ListInfo[] = Array.from(Array(100), (_, index: number) => ({ title: `我是第${index + 1}个`, id: index + 1 }))
  // 只要页面显示就会执行一次
  onPageShow() {
   const params = router.getParams() as BackParamsClass
   const num = AppStorage.Get<number>("myId")
    if(num) {
      AlertDialog.show({
        message: num.toString()
      })
    }

    // if(params?.detailId) {
    //   AlertDialog.show({
    //     message: params?.detailId.toString()
    //   })
    // }
  }
  build() {
    Column({ space: 20 }){
      Row() {
        Text("列表数据")
          .width('100%')
          .textAlign(TextAlign.Center)
          .height(40)
      }
      .border({
        color: '#f3f4f5',
        width: {
          bottom: 1
        }
      })

      // List渲染数据
      List({ space: 10 }) {
        ForEach(this.list, (item: ListInfo) => {
          ListItem () {
            Row() {
              Text(item.title)
              Button("查看详情")
                .height(30)
                .onClick(() => {
                  router.pushUrl({
                     url: 'pages/06/HmDetail',
                     params: {
                       id: item.id
                     }
                  })
                })
            }.padding({
              left: 20,
              right: 20
            }).justifyContent(FlexAlign.SpaceBetween)
            .width('100%')
          }
        })

      }
    }
  }
}

class ListInfo {
  title: string = ""
  id: number = 0
}
class BackParamsClass {
  detailId: number = 0
}