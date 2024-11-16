import { Apples } from '../common/utils/Apples';
import { Block } from '../common/utils/Block'
import { Game } from '../common/utils/Game';
import { Snack } from '../common/utils/Snack';

@Entry
@Component
struct SimpleMode {
  @State board_size: number = 0;
  //棋盘
  @State simple_g: Game = new Game();
  // facing 0→ 1↑ 2← 3↓

  @State length_score: number = 1;
  @State now_playing: boolean = false;
  @State player: Snack = new Snack()
  @State dead: boolean = false;
  @State hd_mode: boolean = false;
  @State screen_width: number = 0;
  @State screen_height: number = 0;

  // 0: not start yet; 1: hit wall; 2: hit self

  aboutToAppear(): void {
    //是第一次重置，不用给出apple位置
    this.reset(true)

    setInterval(() => {
      if (this.now_playing) {
        this.refresh_game()
      }
    }, 500); // Refresh Game
  }

  build() {
    RelativeContainer() {
      //每个组件间距为20
      Column({ space: 20 }) {

        Grid() {
          ForEach(this.simple_g.game, (item: number, index) => {
            GridItem() {
              Row() {
                // Text(index.toString()) {
                // }
                Block({
                  board_size: this.board_size,
                  status: item,
                  index: index
                })
              }
              .width("100%")
              .height("100%")
            }
            .margin(this.board_size * 2)
          })
        }
        // Grids
        .height(this.board_size * 340)
        .columnsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")
        .rowsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")

        Row() {
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

        // Info
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
              Text(this.get_start_status())
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
              this.reset()
              this.now_playing = true
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
    .onAreaChange((o, n) => {
      this.get_board_size(n.width as number, n.height as number)
    })
    .padding(45)
  }

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

  get_start_status() {
    if (this.now_playing) {
      return $r('app.string.Button_Text_Playing')
    } else {
      if (this.dead == true) {
        return $r('app.string.Button_Text_1')
      }
      return $r('app.string.Button_Text_0')
    }
  }

  refresh_game() {
    //首先移动玩家的蛇
    this.player.move()

    //执行棋盘的自动检测功能
    //0游戏失败   1蛇正常行走  2蛇吃到苹果
    //refresh里更新棋盘，外边更新蛇
    switch (this.simple_g.refresh(this.player)) {
      case 0: {
        //不关心怎么死的
        this.dead = true
        this.now_playing = false
        break;
      }
      case 1: {
        this.player.body.push(this.player.new_head)
        this.player.body.shift()
        break;
      }
      case 2: {
        this.player.body.push(this.player.new_head)
        this.length_score++
        break;
      }
      default: {

      }
    }

    return true
  }

  reset(isFirst = false) {
    //重置棋盘
    this.simple_g.game = []
    for (let index = 0; index < 100; index++) {
      this.simple_g.game.push(0) //将所有格子重置为空
    }
    //重置分数 和 死亡状态
    this.length_score = 0
    this.dead = false
    //重置玩家蛇属性
    this.player.body = []
    this.player.facing = 0
    this.player.add_body(0)
    //生成一个临时apple将其加入到apple数组中
    if (!isFirst) {
      //将棋盘中随机一格置为苹果
      this.simple_g.upgrade(Math.floor(Math.random() * 101), 11)
      //手动将第一格位置设置为蛇
      this.simple_g.upgrade(0, 1)
    }

  }

  get_board_size(width: number, height: number) {
    let height_zoom = height / 650
    let width_zoom = width / 400

    this.screen_width = width
    this.screen_height = height

    let board_size = Math.min(height_zoom, width_zoom)
    this.board_size = board_size

    if (this.width > this.height) {
      this.hd_mode = true
    } else {
      this.hd_mode = false
    }

    return board_size
  }

  // //获取所有苹果的坐标
  // get_all_des(total_apples: Apples[]): number[] {
  //   let a: number[] = []
  //   total_apples.forEach((item, index) => {
  //     a.push(item.get_destination())
  //   })
  //   return a
  // }


}




