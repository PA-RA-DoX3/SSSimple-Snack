
import { Snack } from "./Snack"

//棋盘类
export class Game {
  game: number[] = []
  f : boolean = false
  upgrade(index: number, value: number) {
    this.game[index] = value
    return true
  }
  //刷新组件 改变一级成员变量
  rf(){
    this.f = !this.f
  }

  //单人刷新
  //如果撞墙了或者自杀了就返回f
  refresh(snack:Snack) : number{
    if(this.detect_hit_wall(snack)||this.detect_hit_self(snack)){
      return 0
    }
    //如果吃到苹果
    else if (this.detect_eat_apple(snack)){
      //生成一个新的
      this.upgrade(Math.floor(Math.random() * 101), 11)
      this.game[snack.new_head] = 1
      this.rf()
      return 2
    }
    //正常执行
    else {
      this.game[snack.new_head] = 1
      this.game[snack.get_tail()] = 0
      this.rf()
      return 1
    }

  }

  //判断是否撞墙
  detect_hit_wall(snack:Snack) {
    if (snack.facing == 0) {
      if (snack.new_head % 10 == 0) {
        return true
      }
    } // Right
    if (snack.facing == 1) {
      if (snack.new_head < 0) {
        return true
      }
    } // Up
    if (snack.facing == 2) {
      if (snack.new_head % 10 == 9 ||snack.new_head < 0) {
        return true
      }
    } // Left
    if (snack.facing == 3) {
      if (snack.new_head > 99) {
        return true
      }
    } // Down
    return false
  }

  //判断是否撞自己
  detect_hit_self(snack:Snack) {
    if (snack.body.includes(snack.new_head)) {
      return true
    }
    return false
  }

  //判断是否吃到apple
  detect_eat_apple(snack:Snack) {
    if (this.game[snack.new_head] == 11) {

      return true
    }
    return false
  }
}