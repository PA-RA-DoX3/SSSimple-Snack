import { Game } from "./Game";
import { Snack } from "./Snack";
import { HashSet, TreeSet } from "@kit.ArkTS";


export class AISnack extends Snack{
  AI_type : number = 1
  chance : number[] = [0,1,2,3]
  //传送门机制，初始长度始终为1
  constructor( facing? :number ,index = 10,tail = 0,AI_type = 1) {
    super(1,facing,index,tail)
    this.AI_type = AI_type
  }
  get_facing(current_game : Game){
    //最开始有所有方向
    this.chance = [0,1,2,3]
    switch (this.AI_type){
      //类型1 随机蛇，只会保证不自然死亡
      case 1:{
        this.keep_alive()
        this.random_choose()
        break;
      }
      //类型2 会优先选择吃掉苹果
      case 2:{
        this.keep_alive()
        this.want_apple(current_game)
        this.random_choose()
        break;
      }
      default :{
        this.facing = -1
      }
    }

  }


  keep_alive(){
    //不允许自杀
    if(this.facing >1){
      this.chance.splice(this.facing-2,1)
    }else {
      this.chance.splice(this.facing+2,1)
    }
    //遍历所有剩余方向,如果会自然死亡则排除
    //用wrong_facing记录错误下标
    let wrong_facing :number[] = []
    this.chance.forEach((temp_facing,index)=>{
      this.move(20 , temp_facing)
      if(Game.detect_hit_wall(this.new_head,temp_facing,20) || this.detect_hit_self()){
        //在前面添加以保障从大到小排列   保证删去时不会影响后面index值
        wrong_facing.unshift(index)
      }
    })
    //删去所有错误下标
    if(wrong_facing.length!=0){
      wrong_facing.forEach((wrong_facing)=>{
        this.chance.splice(wrong_facing,1)
      })
    }
  }
  want_apple(current_game : Game){
    let new_chance : number[] = []
    this.chance.forEach((temp_facing)=>{
      this.move(20 , temp_facing)
      if(current_game.detect_eat_apple(this.new_head)){
        new_chance.push(temp_facing)
      }
    })
    if(new_chance.length != 0){
      this.chance =new_chance
    }
  }


  //对剩下的方向随机选择
  random_choose(){
    if (this.chance.length != 0){
      this.facing = this.chance[Math.floor(Math.random()*this.chance.length)]
    }else {
      this.facing =this.facing
    }
  }
}