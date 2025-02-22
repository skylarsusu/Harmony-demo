@Entry
@Component
struct LinkCase {
  @State message: string = 'Hello World'
  @State
  list: FoodClass[] = [{
    order_id: 1,
    food_name: '鱼香肉丝',
    food_price: 18.8,
    food_count: 1
  },{
    order_id: 2,
    food_name: '粗溜丸子',
    food_price: 26,
    food_count: 2
  },{
    order_id: 3,
    food_name: '杂粮煎饼',
    food_price: 12,
    food_count: 1
  }]
  build() {
    Row() {
      Column({ space: 20 }) {
         ForEach(this.list, (item: FoodClass) => {
           FoodItem({ item: item, list: $list  })
         })

        BottomCart({ myList: $list  })
      }
      .width('100%')
    }
    .height('100%')
  }
}
@Extend(Text)
function TextStyle () {
  .layoutWeight(1).textAlign(TextAlign.Center).fontSize(20)
}

@Component
struct FoodItem {
  item: Partial<FoodClass> = {}
  @Link
  list: FoodClass[]
  build() {
    Row() {
      Text(this.item.food_name).TextStyle()
      Text(this.item.food_price.toFixed(2)).TextStyle()
      Text(this.item.food_count.toString()).TextStyle()
    }
    .width('100%')
    .height(40)
  }
}


// 底部组件
@Component
struct BottomCart {
  @Link
  myList: FoodClass[]
  build() {
     Button("更改菜品的数量")
       .onClick(() => {
         this.myList = this.myList.map(item => {
           item.food_count++
           return item
         })
       })
  }
}

// 食品类
class FoodClass {
  order_id: number = 0
  food_name:  string = ""
  food_price: number = 0
  food_count: number = 0
}