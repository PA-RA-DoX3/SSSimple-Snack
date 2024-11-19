import {Block} from '../common/utils/Block'
import {Apples} from '../common/utils/Apples'
import { Snack } from '../common/utils/Snack';
import { Game } from '../common/utils/Game';
import { AISnack } from '../common/utils/AISnack';
import { it } from '@ohos/hypium';

@Entry
@Component
struct NormalMode {
  @State board_size: number = 0;
  @State normal_g : Game = new Game()
  @State now_playing: boolean = false;
  @State player : Snack = new Snack(3,0)
  @State screen_width: number = 0;
  @State screen_height: number = 0;
  @State length_score: number = 0
  @State dead :boolean = false
  @State total_apples:Apples[]=[]

  //主时间
  current_time :number = 0
  //AI蛇
  ai_snack :AISnack[] = []

  aboutToAppear(): void {
    this.reset(true)

    let main_clock = setInterval(() => {
      if(this.now_playing){
        //计时器增加
        if(this.current_time < 1200 ){
          this.current_time += 100
        }else {
          this.current_time = 100
        }
        if((this.current_time % 400) == 0){
          this.ai_snack_create()
        }
        //刷新每一个存在的ai蛇
        this.ai_snack.forEach((snack,index)=>{
          if((this.current_time % snack.refresh_time) == 0){
            snack.get_facing(this.normal_g)
            this.refresh_snack(snack)
          }
        })
        //玩家刷新
        if((this.current_time % this.player.refresh_time) == 0){
          this.refresh_snack(this.player)
        }
      }



    },100); // Refresh Game
  }

  build() {
    RelativeContainer() {
      Column({space:20}){
        Grid() {
          ForEach(this.normal_g.game, (item: number, index) => {
            GridItem() {
              Row() {
                // Text(index.toString()) {
                // }
                Block({
                  board_size: this.board_size,
                  status: item,
                  index: index,
                  // apple: index == this.apple
                })
              }
              .width("100%")
              .height("100%")
            }
            .margin(this.board_size )
          })
        }
        // Grids
        .height(this.board_size * 340)
        .columnsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")
        .rowsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")



        Row(){
          Text(this.length_score.toString())
            .opacity(this.board_size == 0 ? 0 : 1)
            .animation({ duration: 500, delay: 400, curve: Curve.ExtremeDeceleration })

            .fontSize(this.board_size * 50)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
            .textAlign(TextAlign.Start)
            .fontColor($r('app.color.accent'))

          Text(this.get_facing_string())
            .opacity(this.board_size == 0 ? 0 : 1)
            .animation({ duration: 500, delay: 450, curve: Curve.ExtremeDeceleration })

            .fontSize(this.board_size * 50)
            .fontWeight(FontWeight.Bold)
            .fontColor($r('app.color.accent'))
        }
      }
      .width(this.board_size * 340)
      .alignRules({
        top: { anchor: '__container__', align: VerticalAlign.Top },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })

      Row() {
        Grid() {
          GridItem()
            .margin(this.board_size * 2)
          GridItem() {
            Button() {
              Text("↑")
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              this.player.facing = 1
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.5 })
          }

          GridItem()
            .margin(this.board_size * 2)

          GridItem() {
            Button() {
              Text("←")
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              this.player.facing = 2
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.5 })
          }

          GridItem() {
            Button() {
              Text("　")
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              // Speed Up?
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.5 })
          }

          GridItem() {
            Button() {
              Text("→")
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              this.player.facing = 0
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.5 })
          }

          GridItem()
            .margin(this.board_size * 2)
          GridItem() {
            Button() {
              Text("↓")
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              this.player.facing = 3
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.5 })
          }

          GridItem()
            .margin(this.board_size * 2)
        }
        // Gamepad
        .opacity(this.board_size == 0 ? 0 : 1)
        .animation({ duration: 500, delay: 500, curve: Curve.ExtremeDeceleration })

        .width(this.board_size * 150)
        .height(this.board_size * 150)
        .columnsTemplate("1fr 1fr 1fr")
        .rowsTemplate("1fr 1fr 1fr")

        Blank()

        Grid() {
          GridItem()
            .margin(this.board_size * 2)
          GridItem() {
            Button() {
              Text(this.get_button_text())
                .textAlign(TextAlign.Center)
                .fontWeight(FontWeight.Bold)
                .fontSize(this.board_size * 30)
                .fontColor($r('app.color.start_window_background'))
                .backgroundColor($r('app.color.accent'))
                .borderRadius(this.board_size * 4)
                .width("100%")
                .height("100%")
            }
            .margin(this.board_size * 2)
            .backgroundColor("transparent")
            .type(ButtonType.Normal)
            .onClick(() => {
              this.key_button()
            })
            .clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.7 })
          }
          .margin(this.board_size * 2)

          GridItem()
            .margin(this.board_size * 2)

        }
        // Control
        .opacity(this.board_size == 0 ? 0 : 1)
        .animation({ duration: 500, delay: 550, curve: Curve.ExtremeDeceleration })

        .width(this.board_size * 150)
        .height(this.board_size * 150)
        .rowsTemplate("1fr 1fr 1fr")

      }
      // Buttons
      .width(this.board_size * 340)
      .alignRules({
        bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
        middle: { anchor: '__container__', align: HorizontalAlign.Center }
      })


    }
    .backgroundColor($r("app.color.start_window_background"))
    .height('100%')
    .width('100%')
    .onAreaChange((o,n) => {
      this.get_board_size(n.width as number, n.height as number)
    })
    .padding(45)
    //手势识别方向
    .gesture(
      PanGesture({direction : PanDirection.Right })
        .onActionEnd(()=>{
          if(this.player.facing!= 2){
            this.set_player_facing(0)
          }
        })
    )
    .gesture(
      PanGesture({direction : PanDirection.Up })
        .onActionEnd(()=>{
          if(this.player.facing != 3){
            this.set_player_facing(1)
          }
        })
    )
    .gesture(
      PanGesture({direction : PanDirection.Left })
        .onActionEnd(()=>{
          if(this.player.facing != 0){
            this.set_player_facing(2)
          }
        })
    )
    .gesture(
      PanGesture({direction : PanDirection.Down })
        .onActionEnd(()=>{
          if(this.player.facing != 1){
            this.set_player_facing(3)
          }
        })
    )
    .gesture(
      TapGesture({count:2})
        .onAction(()=>{
          this.key_button()
        })
    )

  }

  //设置玩家facing
  set_player_facing(n :number) {
    this.player.facing = n
  }
  //重置棋盘
  reset(is_first = false) {
    //重置棋盘
    this.normal_g = new Game()
    for (let index = 0; index < 400; index++) {
      this.normal_g.game.push(0) //将所有格子重置为空
    }
    //重置AI蛇状态
    this.ai_snack = []
    //重置分数 和 死亡状态
    this.length_score = 0
    this.dead = false
    //重置玩家蛇属性
    this.player = new Snack(3,0,10,0)
    //将新的蛇置于棋盘中
    //在棋盘中生成一个apple
    if (!is_first) {
      //将棋盘中随机两格置为苹果
      this.normal_g.new_apple(2)
      this.normal_g.new_snack(this.player)
    }

  }
  //取得玩家方向
  get_facing_string() {
    if (this.player.facing == 0) {
      return "→"
    }
    if (this.player.facing == 1) {
      return "↑"
    }
    if (this.player.facing == 2) {
      return "←"
    }
    if (this.player.facing == 3) {
      return "↓"
    }
    return "?"
  }
  //获得棋盘应该有的宽高
  get_board_size(width: number, height: number) {
    let height_zoom = height / 650
    let width_zoom = width / 400

    this.screen_width = width
    this.screen_height = height

    let board_size = Math.min(height_zoom, width_zoom)
    this.board_size = board_size

    return board_size
  }
  //获得功能按键文字
  get_button_text() {
    if (this.now_playing) {
      return $r('app.string.button_text_speedup')
    } else {
      if (this.dead == true) {
        return $r('app.string.button_text_died')
      }
      return $r('app.string.button_text_start')
    }
  }
  //蛇刷新
  refresh_snack(snack:Snack) {
    //首先移动玩家的蛇
    let snack_arr :Snack[] = [snack]
    snack.move(20)
    //执行棋盘的自动检测功能
    //0游戏失败   1蛇正常行走  2蛇吃到苹果
    this.normal_g.refresh(20,snack_arr).forEach((key_num,index)=>{
      switch (key_num % 10) {
        case 0: {
          if(snack_arr[index].index == 10 ){
            //注释掉后无敌
            // this.dead = true
            // this.now_playing = false
          }else{
            //然后删除这条ai蛇
            this.ai_snack.splice((snack_arr[index].index / 10)-2 ,1)
          }
          break;
        }
        case 1: {
          snack_arr[index].body.push(snack_arr[index].new_head)
          snack_arr[index].body.shift()
          break;
        }
        case 2: {
          snack_arr[index].body.push(snack_arr[index].new_head)
          if(snack_arr[index].index == 10 ){
            this.length_score++
          }

          break;
        }
        default: {

        }
      }
    })
    return true
  }
  //判断是否生成AI蛇
  ai_snack_create() {
    //百分之30生成
    if (Math.floor(Math.random() * 10) > 6) {
      //如果数量小于 x
      if (this.ai_snack.length < 4) {
        let tail = this.normal_g.find_safe_space(this.player, 1)
        let type = Math.floor(Math.random() * 3) +1
        if (tail > -1) {
          this.ai_snack.push(new AISnack(undefined, this.ai_snack.length * 10 + 20, tail, type))
        }
      }
    }
  }
  //蛇加速
  speed_up(snack:Snack){
    snack.refresh_time /= 2
    let speed_up_interval = setInterval(()=>{
      snack.refresh_time *= 2
      clearInterval(speed_up_interval)
    }, 2000)
  }
  //功能键函数
  key_button(){
    if(this.now_playing == false){
      this.reset()
      this.now_playing = true
    }else {
      this.speed_up(this.player)
    }
  }

}