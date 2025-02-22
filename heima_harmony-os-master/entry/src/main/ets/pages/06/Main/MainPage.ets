import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct MainPage {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Button("去支付")
          .onClick(async () => {
            // 拉起另外一个ability
            // 上下文- 当前页面所在的Ability的一些公有的参数和方法
            const context = getContext(this) as common.UIAbilityContext

            let want: Want = {
               bundleName: 'com.itheima.heima_harmony', // 包名
               abilityName: 'HeimaPayAbility',
               moduleName: 'HeimaPay',
               parameters: {
                 order_id: Date.now()
               }
            }
             const  result =  await context.startAbilityForResult(want)
             const params =   result.want.parameters as ResultParams
            if(params.paySuccess) {
              promptAction.showToast({
                message: '支付成功'
              })
            }else {
              promptAction.showToast({
                message: '支付失败'
              })
            }

          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
type  ResultParams = Record<string, boolean>