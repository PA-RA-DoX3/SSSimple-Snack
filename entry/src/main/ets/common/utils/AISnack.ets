import { Game } from "./Game";
import { Snack } from "./Snack";
import { HashSet, TreeSet } from "@kit.ArkTS";

export class AISnack extends Snack{


  get_facing(){
    switch (this.index){
      case 20:{
        let is_legal =false
        let temp_facing = 0
        let chance : TreeSet<number> = new TreeSet()
        chance.add(0)
        chance.add(1)
        chance.add(2)
        chance.add(3)
        do{
          temp_facing = Math.floor(Math.random()*4)
          if(Math.abs(temp_facing - this.facing) != 2){
            this.move(20 , temp_facing)
            if(!Game.detect_hit_wall(this.new_head,temp_facing,20) && !this.detect_hit_self()){
              is_legal = true
            }
          }
          chance.remove(temp_facing)
        }while(!is_legal && chance.length > 1)
        if(is_legal){
          this.facing = temp_facing
        }else {
          this.facing = chance.getFirstValue()
        }
        break;
      }

      default :{this.facing = 1}
    }
  }
  // ai_constructor(type :number) :number[]{
  //   switch (type){
  //     case 0 :{
  //       let facing =Math.floor(Math.random()*4)
  //
  //     }
  //   }
  // }
}