import {Block} from '../common/utils/Block'
import {Apples} from '../common/utils/Apples'
import { Snack } from '../common/utils/Snack';
import App from '@system.app';

@Entry
@Component
struct NormalMode {
  @State board_size: number = 0;
  @State game: number[] = [];
  @State now_playing: boolean = false;
  @State screen_width: number = 0;
  @State screen_height: number = 0;
  @State total_apples:Apples[]=[]

  aboutToAppear(): void {
    this.reset()

    setInterval(() => {
      if (this.now_playing) {
        // this.refresh_game()
      }
    }, 500); // Refresh Game
  }

  build() {
    RelativeContainer() {
      Column({space:10}){
        Grid() {
          ForEach(this.game, (item: boolean, index) => {
            GridItem() {
              Row() {
                // Text(index.toString()) {
                // }
                // Block({
                //   board_size: this.board_size,
                //   status: item,
                //   index: index,
                //   // apple: index == this.apple
                // })
              }
              .width("100%")
              .height("100%")
            }
            .margin(this.board_size * 2)
          })
        }
        // Grids
        .height(this.board_size * 340)
        .columnsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")
        .rowsTemplate("1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr")
      }
    }
    .height('100%')
    .width('100%')
  }

  reset() {
    //新建玩家蛇
    let player:Snack=new Snack()
    //重置棋盘
    this.game = []
    for (let index = 0; index < 400; index++) {
      this.game.push(0)//将所有格子重置为空
    }
    //重置玩家蛇属性
    player.facing = 0
    player.add_body(-1)
    let apple = new Apples( 1, Math.floor(Math.random()*400))
    this.total_apples.push(apple)
  }
}