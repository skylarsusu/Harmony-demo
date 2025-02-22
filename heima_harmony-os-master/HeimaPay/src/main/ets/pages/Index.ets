import common from '@ohos.app.ability.common'
@Entry
@Component
struct Index {
  @State message: string = '黑马支付页面'
  @StorageProp("order_id")
  orderId: number = 0
  build() {
    Row() {
      Column({ space: 20 }) {
        Text(this.message )
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text(this.orderId.toString())
          .fontSize(30)
          .fontColor(Color.Red)
        Button("支付")
          .onClick(() => {
            // 销毁当前的ability 将支付结果告诉调用我的人
           const context = getContext(this) as  common.UIAbilityContext
            context.terminateSelfWithResult({
              resultCode: 1,
              want: {
                abilityName: 'EntryAbility',
                bundleName: 'com.itheima.heima_harmony',
                moduleName: 'entry',
                parameters: {
                  paySuccess: true
                }
              }
            })

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}