
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

  //棋盘刷新
  refresh(game_size:number,snack_arr:Snack[]) : number[]{
    //定义一个返回的数组  初始化为空
    let key_num :number[] = []
    snack_arr.forEach((snack,index)=>{
      if(Game.detect_hit_wall(snack.new_head,snack.facing,game_size)||Game.detect_hit_self(snack)){
        //如果有蛇死亡了 ，则将其编号加入数组
        key_num.push(snack.index)
      }else if(this.detect_eat_apple(snack)){
        //如果有蛇吃到苹果
        //在棋盘上生成一个新的
        this.new_apple()
        //将长度增加一格   即直接将蛇头加入其身体但是不去掉尾部
        //将该格设置为编号 + 类型码(普通为1)
        this.game[snack.new_head] = snack.index+1
        //刷新
        this.rf()
        //将每条蛇的结果加入到
        key_num.push(snack.index + 2)
      }else{
        //都没有则是正常行走
        this.game[snack.new_head] = snack.index+1
        this.game[snack.get_tail()] = 0
        this.rf()
        key_num.push(snack.index + 1)
      }

    })
    return key_num
  }


  //判断是否撞墙
  static detect_hit_wall(new_head :number ,facing :number,size = 10) :boolean{
    if (facing == 0) {
      if (new_head % size == 0 ) {
        return true
      }
    } // Right
    if (facing == 1) {
      if (new_head < 0) {
        return true
      }
    } // Up
    if (facing == 2) {
      if (new_head % size == size - 1 || new_head < 0) {
        return true
      }
    } // Left
    if (facing == 3) {
      if (new_head > size*size-1) {
        return true
      }
    } // Down
    return false
  }

  //判断是否撞自己
  static detect_hit_self(snack:Snack) {
    if (snack.body.includes(snack.new_head)) {
      return true
    }
    return false
  }

  //判断是否吃到apple
   detect_eat_apple(snack:Snack) {
    if (this.game[snack.new_head] == 1) {

      return true
    }
    return false
  }

  //创建苹果
  new_apple(){
    let index = Math.floor(Math.random() * this.game.length+1)
    while(this.game[index] != 0 ){
      index = Math.floor(Math.random() * this.game.length+1)
    }
    this.upgrade(index , 1)
  }

  new_snack(snack:Snack){
    snack.body.forEach((item)=>{
      this.upgrade(item ,snack.index+1 )
    })
  }
  //删除一条蛇
  delete_snack(snack:Snack){
    snack.body.forEach((item)=>{
      this.upgrade(item ,0 )
    })
  }
  //找到a个空位置
  find_space(a:number):number{
    // let game_size = Math.sqrt(this.game.length)
    let game_size = 20
    let index :number
    //找到的位置是否合法
    let is_legal =false
    do{
      //随机选择一个可能合法的位置
      let x = Math.floor(Math.random()*game_size)
      let y = Math.floor(Math.random() * (game_size - a - 1))
      index = x*20+y
      //验证
      for(let i = index ; i < index+a ; i++){
        if(this.game[i] != 0){
          break;
        }
        is_legal = true
      }
    }while (!is_legal)
    return index
  }
}