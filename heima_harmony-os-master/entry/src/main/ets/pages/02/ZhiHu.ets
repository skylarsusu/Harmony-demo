@Entry
@Component
struct ZhiHu {
  @State commentList: ReplyItem[] = [
    {
      id: 1,
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      author: '偏执狂-妄想家',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '11-30',
      area: '海南',
      likeNum: 34
    },
    {
      id: 2,
      avatar: 'https://pic1.zhimg.com/v2-5a3f5190369ae59c12bee33abfe0c5cc_xl.jpg?source=32738c0c',
      author: 'William',
      content: '当年希腊可是把1：0发挥到极致了',
      time: '11-29',
      area: '北京',
      likeNum: 58
    },
    {
      id: 3,
      avatar: 'https://picx.zhimg.com/v2-e6f4605c16e4378572a96dad7eaaf2b0_l.jpg?source=06d4cd63',
      author: 'Andy Garcia',
      content: '欧洲杯其实16队球队打正赛已经差不多，24队打正赛意味着正赛阶段在小组赛一样有弱队。',
      time: '11-28',
      area: '上海',
      likeNum: 10
    },
    {
      id: 4,
      avatar: 'https://picx.zhimg.com/v2-53e7cf84228e26f419d924c2bf8d5d70_l.jpg?source=06d4cd63',
      author: '正宗好鱼头',
      content: '确实眼红啊，亚洲就没这种球队，让中国队刷',
      time: '11-27',
      area: '香港',
      likeNum: 139
    },
    {
      id: 5,
      avatar: 'https://pic1.zhimg.com/v2-eeddfaae049df2a407ff37540894c8ce_l.jpg?source=06d4cd63',
      author: '柱子哥',
      content: '我是支持扩大的，亚洲杯欧洲杯扩到32队，世界杯扩到64队才是好的，世界上有超过200支队伍，欧洲区55支队伍，亚洲区47支队伍，即使如此也就六成出现率',
      time: '11-27',
      area: '旧金山',
      likeNum: 29
    },
    {
      id: 6,
      avatar: 'https://picx.zhimg.com/v2-fab3da929232ae911e92bf8137d11f3a_l.jpg?source=06d4cd63',
      author: '飞轩逸',
      content: '禁止欧洲杯扩军之前，应该先禁止世界杯扩军，或者至少把亚洲名额一半给欧洲。',
      time: '11-26',
      area: '里约',
      likeNum: 100
    }
  ]
  changeLike (obj: ReplyItem) {
    if(obj.likeFlag) {
      obj.likeFlag = false
      obj.likeNum--
    }else {
      obj.likeFlag = true
      obj.likeNum++
    }
    // State数据只能监听到第一层的变化
    // 怎么让数据具备驱动性
    const index = this.commentList.findIndex(item => item.id === obj.id)
    // obj.id
    // this.commentList[index] = { ...obj } 禁用 ！！！！！ 虽然4.0可以 但是Next不行
    this.commentList.splice(index,1)
    this.commentList.splice(index, 0, obj)
  }
  // 新增一条评论
  addComment (item: ReplyItem) {
    this.commentList.unshift(item)
  }
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Scroll 只能放置一个子组件
      Scroll() {
        Column () {
          HmNavBar()
          HmCommentItem({
            item: {
              id: 999,
              avatar: $r('app.media.handsome'),
              author: '老高',
              time: "12-15",
              content: '老高说你们都是大神，我们的训练营搞得人压力好大',
              area: '北京',
              likeNum: 100,
              likeFlag: false
            }
          })
          // 分割线
          Divider()
            .strokeWidth(6)
            .color("#f4f4f4")
          Row() {
            Text("回复7")
              .width('100%')
              .fontWeight(FontWeight.Bold)
          }
          .height(40)
          .padding({
            left: 20
          })
          //     循环渲染多个评论项
          ForEach(this.commentList, (obj: ReplyItem) => {
            // N个评论项
            HmCommentItem({ item: obj, changeLike: (obj: ReplyItem) => {
              this.changeLike(obj)
            }})
          })
        }
      }
      .padding({
        bottom: 60
      })
     // 回复组件
      ReplyInput({ add: (item: ReplyItem) => {
        this.addComment(item)
      }})
    }


  }
}

// 回复评论组件
@Component
struct ReplyInput {
  @State
  commentStr: string = ""
  add: (item: ReplyItem) => void = () => {}
  // 在回复组件声明了一变量 add 他的类型是函数 给了一个初始值是函数
  build() {
   Row() {
     TextInput({ placeholder: '回复～', text: this.commentStr})
       .layoutWeight(1)
       .backgroundColor("#f4f5f6")
       .onChange((value) => {
         this.commentStr = value
       })
     Text("发布")
       .fontColor("#6ecff0")
       .margin({
         left: 10
       })
       .onClick(() => {
         // 告诉父组件 我拿到值了你给我个方法我来调一下
         // 要传入一个新的评论对象
         if(this.commentStr !== "") {
           let obj: ReplyItem = {
             id: Date.now(),
             content: this.commentStr,
             avatar: $r("app.media.handsome"),
             likeNum: 0,
             likeFlag: false,
             author: '坏坏的老高',
             time: `${new Date().getMonth() + 1 }-${ new Date().getDate() }`,
             area: '北京'
           }
           this.add(obj)
           this.commentStr = ""
         }

       })
   }
    .border({
      color: '#f4f5f6',
      width: {
        top: 1
      }
    })
    .height(50)
    .backgroundColor(Color.White)
    .width('100%')
    .padding({
      left: 10,
      right: 10
    })
  }
}

@Component
struct HmNavBar {
  build() {
    Row(){
      Row() {
        Image($r("app.media.ic_public_arrow_left"))
          .width(16)
          .height(16)
          .fillColor('#848484')
      }
      .justifyContent(FlexAlign.Center)
      .width(24)
      .aspectRatio(1)
      .backgroundColor("#f5f5f5")
      .borderRadius(12)
      .margin({
        left: 15
      })
      Text("评论回复")
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(18)
        .padding({
          right: 39
        })
    }
    .height(40)
    .border({
      color: '#f4f4f4',
      width: {
        bottom: 0.5
      }
    })
  }
}

@Component
struct HmCommentItem {
  item: Partial<ReplyItem>  = {}  // 非响应式数据
  changeLike: (params: ReplyItem) => void = () => {}
  build() {
    Row() {
      // 左侧头像
      Image(this.item.avatar)
        .width(32)
        .aspectRatio(1)
        .borderRadius(16)
      // 评论区
      Column({ space: 10 }) {
        Text(this.item.author)
          .fontWeight(FontWeight.Bold)
        Text(this.item.content)
          .lineHeight(20)
        .fontSize(16)
        .fontColor('#565656')
        // 底部内容
        Row() {
          Text(`${this.item.time} .ip属地${this.item.area}`)
            .fontSize(12)
            .fontColor("#c3c4c5")
          Row() {
           Image($r("app.media.favorite_block"))
             .width(12)
             .aspectRatio(1)
             .fillColor(this.item.likeFlag ? 'red' : '#c3c4c5')  // 填充颜色
             .margin({
               right: 5
             })
            Text(this.item.likeNum?.toString())
              .fontSize(12)
              .fontColor("#c3c4c5")
          }
          .onClick(() => {
            // 点赞
            // this.item 属性都是可选的
            this.changeLike(this.item as ReplyItem)
          })
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({
        left: 10
      })
    }.padding(15)
    .alignItems(VerticalAlign.Top)
  }
}


// 导出
