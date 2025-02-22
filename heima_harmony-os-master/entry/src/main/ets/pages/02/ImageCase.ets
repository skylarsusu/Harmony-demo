@Entry
@Component
struct ImageCase {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column({ space: 20 }) {
        // 1. 使用本地图片
        Image("assets/test.jpeg")
          .width(100)
          .height(100)
          .borderRadius(50)
        // 2.使用资源引入  Resource类型
        // Image($r("app.media.handsome"))
        //   .width(200)
        //   .height(200)
        //   .borderRadius(100)
        // 3. 采用原始文件引用
        Image($rawfile("github.jpg"))
          .width(200)
          .height(200)
          .borderRadius(100)

        // 4. 引用网络图片
        Image("https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F62627729-e947-4a05-a7b5-687b32d8cff2%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1705061879&t=d3bfa87d007a9071385ceba9f1c40f10")
          .width(200)
          .height(200)
          .borderRadius(100)
      }
      .width('100%')
    }
    .height('100%')
  }
}