@Entry
@Component
struct VideoCase {
  controller: VideoController = new VideoController()
  @State
  speed: number  = 1
  build() {
    Tabs() {
      TabContent() {
        Column({ space: 20 }) {
          Video({
            currentProgressRate: this.speed,  // 最低 0.75  1 1.25 。15 1.75 2
            controller: this.controller,
            src: 'https://vd3.bdstatic.com/mda-pme763a17skxb7wp/hd/cae_h264/1702633992276043095/mda-pme763a17skxb7wp.mp4?v_from_s=hkapp-haokan-hbe&auth_key=1703260178-0-0-09b4d977569d0e4fb896fcbf2c46d516&bcevod_channel=searchbox_feed&pd=1&cr=1&cd=0&pt=4&logid=2978095068&vid=12131372018733013374&abtest=all'
          })
            .width('100%')
            .aspectRatio(1.2)
            .controls(false)

          Row() {
            Slider({
              value: this.speed,
              min: 0.75,
              max: 2,
              step: 0.25
            }).showSteps(true)
              .onChange(value => {
                 this.speed = value
              })
          }
           Text("当前倍速：" + this.speed)
          Row({ space: 20 }) {
            Button("播放")
              .onClick(() => {
                this.controller.start()
              })
            Button("暂停")
              .onClick(() => {
                this.controller.pause()
              })
            Button("快进到1分钟")
              .onClick(() => {
                this.controller.setCurrentTime(60)
              })
            Button("停止")
              .onClick(() => {
                this.controller.stop()
              })
          }
        }

      }.tabBar("在线视频")
      TabContent() {
        Video({
          src: $rawfile("local.mp4")
        })
          .width('100%')
          .aspectRatio(1.2)
      }.tabBar("本地视频")
      TabContent() {
        Video({
          src: 'https://m701.music.126.net/20231222212224/f33140d889f25347df0d6757a685748c/jdyyaac/030e/0e0e/0e5a/4d783dbca09d7c4c7a39903bbfd0ffe8.m4a'
        })
          .width('100%')
          .aspectRatio(1.2)
      }.tabBar("音频")
    }.animationDuration(500)

  }
}