import { Game } from "./Game";
import { Snack } from "./Snack";
import { HashSet, TreeSet } from "@kit.ArkTS";
import { speechRecognizer } from "@kit.CoreSpeechKit";


export class AISnack extends Snack{
  AI_type : number = 1
  chance : number[] = [0,1,2,3]
  //目标位置
  target_loc :number = -1
  //传送门机制，初始长度始终为1
  constructor(facing? :number ,index = 10,tail = 0,AI_type = 1) {
    let init_length :number = 3
    switch (AI_type){
      case 1: {
        init_length = 4
        break
      }
      case 2: {
        init_length = 4
        break
      }
      case 3: {
        init_length = 3
        break
      }
    }
    super(init_length,facing,index,tail)
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
      //类型3，全局搜索蛇速度稍快
      case 3:{
        this.refresh_time = 300
        this.keep_alive()
        //获得target
        this.target_want_apple_plus(current_game)
        this.go_target()
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
  target_want_apple_plus(current_game:Game){
    let temp_target = -1
    let old_distance = -1
    //如果苹果已经被吃了才会全局搜索
    if(this.target_loc == -1 || !this.is_apple(current_game, temp_target) ){
      current_game.game.forEach((label , index)=>{
        if(label != 0 && label <10){
          let distance = AISnack.cul_distance(index , this.new_head)
          if(temp_target == -1){
            temp_target = index
            old_distance = distance
          }else {
            if(distance<old_distance){
              temp_target = index
              old_distance = distance
            }
          }
        }
      })
    }
    this.target_loc =temp_target

  }

  //对剩下的方向随机选择
  random_choose(){
    if (this.chance.length != 0){
      this.facing = this.chance[Math.floor(Math.random()*this.chance.length)]
    }else {
      this.facing =this.facing
    }
  }

  //计算两点距离
  static cul_distance(loc1:number,loc2:number,size = 20){
    let loc1_x = loc1 % size + 1
    let loc1_y = Math.floor(loc1 / size )
    let loc2_x = loc2 % size + 1
    let loc2_y = Math.floor(loc2 / size )

    return Math.pow((loc1_x - loc2_x) , 2) + Math.pow((loc1_y - loc2_y) , 2)
  }

  is_apple(current_game :Game , index :number){
    if(current_game.game[index] !=0 && current_game.game[index] <10){
      return true
    }else return false
  }

  go_target(size = 20){
    let target_x = this.target_loc % size + 1
    let target_y = Math.floor(this.target_loc / size )
    let head_x = this.get_head() % size + 1
    let head_y = Math.floor(this.get_head() / size )
    let temp_facing :number[]= []

    if((target_x - head_x) > 0 ){
      temp_facing.push(0)
    }else if((target_x - head_x) < 0 ){
      temp_facing.push(2)
    }else {}

    if((target_y - head_y) > 0 ){
      temp_facing.push(3)
    }else if((target_y - head_y) < 0 ){
      temp_facing.push(1)
    }else {}


    let temp_chance :number[] = []
    temp_facing.forEach((facing,index)=>{
      if (this.chance.includes(facing)){
        temp_chance.push(facing)
      }
    })
    //如果可选项中包含该方向则更新
    if(temp_chance.length!=0){
      this.chance = temp_chance
    }
  }
}