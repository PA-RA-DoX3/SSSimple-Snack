import { Snack } from "./Snack"
import App from "@system.app"

//棋盘类
export class Game {
  game: number[] = []
  apple_num : number = 0
  f: boolean = false

  upgrade(index: number, value: number) {
    this.game[index] = value
    return true
  }

  //刷新组件 改变一级成员变量
  rf() {
    this.f = !this.f
  }

  //棋盘刷新
  refresh(game_size: number, snack_arr: Snack[]): number[] {
    //定义一个返回的数组  初始化为空
    let key_num: number[] = []
    snack_arr.forEach((snack) => {
      if (Game.detect_hit_wall(snack.new_head, snack.facing, game_size) || this.is_hit_something(snack)) {
        //如果不是玩家则执行生成apple
        if (snack.index != 10) {
          this.snack_death(snack)
        }
        //回传参数
        key_num.push(snack.index)
      } else if (this.detect_eat_apple(snack.new_head)) {
        //如果有蛇吃到苹果
        //在棋盘上生成一个新的
        this.new_apple()
        //将长度增加一格   即直接将蛇头加入其身体但是不去掉尾部
        //将之前的头设定为身体
        //将该格设置为编号 + 类型码(头方向为0-3,身体为9)
        this.game[snack.get_head()] = snack.index + 9
        this.game[snack.new_head] = snack.index + snack.facing
        //刷新
        this.rf()
        //将每条蛇的结果加入到
        key_num.push(snack.index + 2)
      } else {
        //都没有则是正常行走
        this.game[snack.get_head()] = snack.index + 9
        this.game[snack.new_head] = snack.index + snack.facing
        this.game[snack.get_tail()] = 0
        this.rf()
        key_num.push(snack.index + 1)
      }

    })
    return key_num
  }


  //判断是否撞墙
  static detect_hit_wall(new_head: number, facing: number, size = 10): boolean {
    if (facing == 0) {
      if (new_head % size == 0) {
        return true
      }
    } // Right
    if (facing == 1) {
      if (new_head < 0) {
        return true
      }
    } // Up
    if (facing == 2) {
      if (new_head % size == size -1 || new_head < 0) {
        return true
      }
    } // Left
    if (facing == 3) {
      if (new_head > size * size - 1) {
        return true
      }
    } // Down
    return false
  }

  //判断是否撞自己(弃用)
  static detect_hit_self(snack: Snack) {
    if (snack.body.includes(snack.new_head)) {
      return true
    }
    return false
  }

  //判断是否吃到apple
  detect_eat_apple(new_head :number) {
    if (this.game[new_head] == 1) {
      this.apple_num--
      return true
    }
    return false
  }

  //指定范围内创建n个分数为type的苹果(可优化？)
  new_apple(num = 1, range?: number[], type = 1) {
    //判断是否超过数量
    if(this.apple_num < 11){
      //没有指定范围
      if (range == undefined) {
        for (let i = 0; i < num; i++) {
          let index: number
          do {
            index = Math.floor(Math.random() * this.game.length)
          } while (this.game[index] != 0)
          this.upgrade(index, type)
        }
      } else {
        //如果指定范围  从范围中选择
        for (let i = 0; i < num; i++) {
          let index: number
          do {
            index = Math.floor(Math.random() * range.length)
          } while (this.game[range[index]] != 0)
          this.upgrade(range[index], type)
        }
      }
    }
    //在棋盘中增加苹果数量
    this.apple_num += num;

  }

  //在棋盘中新建蛇
  new_snack(snack: Snack) {
    snack.body.forEach((item) => {
      this.upgrade(item, snack.index + 1)
    })
  }

  //棋盘中的蛇死亡（可优化）
  snack_death(snack: Snack) {
    //先在棋盘中删除蛇
    snack.body.forEach((item) => {
      this.upgrade(item, 0)
    })
    //再根据蛇的长度生成 1? 个 的苹果
    //数量为小数
    this.new_apple(snack.body.length / 5, snack.body)
  }

  //以蛇为保护对象可能生成一个合法空位置
  find_safe_space(protect_snack: Snack, length: number) {
    let game_size = 20
    //随机找一个位置
    let x =Math.floor(Math.random() * game_size)
    let y =Math.floor(Math.random() * game_size)
    let index = x*20 +y
    if(y+length >18){
      return -1
    }
    //验证
    if (index > protect_snack.get_head() - 43 && index < protect_snack.get_head() + 43) {
      return -1
    }
    for (let i = index; i < index + length; i++) {
      if (this.game[i] != 0) {
        return -1
      }
    }
    return index
  }


  is_hit_something(snack:Snack){
    let label = this.game[snack.new_head]
    if(label != 0 && label > 9){
      return true
    }
    return false
  }
}