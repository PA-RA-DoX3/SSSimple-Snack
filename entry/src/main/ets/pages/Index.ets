import { router } from '@kit.ArkUI';

@Entry
@Component
struct Main {
  @State message: string = 'Hello World';

  build() {
    Tabs({ barPosition: BarPosition.End }){
      TabContent(){
        Column({space:10}){
          Text('首页内容')
          Button('简单模式')
            .width(200)
            .height(40)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/SimpleMode'
              })
            })
          Button('普通模式')
            .width(200)
            .height(40)
            .onClick(()=>{
              router.pushUrl({
                url:'pages/NormalMode'
              })
            })
        }
      }
      .tabBar("首页")
      TabContent(){
        Text('装备界面').fontSize(30)
      }
      .tabBar('装备')
      TabContent(){
        Text('我的界面').fontSize(30)
      }
      .tabBar("我的")
    }
    .barMode(BarMode.Fixed)//设置为固定导航栏
    .scrollable(false)//限制底部导航栏滑动
    //先限制装备页面不可选中
    .onContentWillChange((currentIndex,comingIndex)=>{
      if (comingIndex == 1) {
        return false
      }
      return true
    })
  }
}