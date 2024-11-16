@Component
export struct  Block {
  @Prop board_size: number = 0;
  @Prop status: number = 0;
  @Prop index: number = 0;
  @State zoom: string = this.get_init_zoom();
  //颜色
  @State b_color:Resource =$r("app.color.deep_background");

  //显示之前确定颜色，之后改为图片
  image(): Resource{
    switch (this.status){
      case 0 :{
        return $r("app.color.deep_background")
      }
      case 1 :{
        return $r("app.color.apple_normal")
      }
      case 11 :{
        return $r("app.color.accent")
      }
      case 21:{
        return $r("app.color.accent")
      }
      default :{
        return $r("app.color.apple_normal")
      }
    }
  }

  build() {
    Row() {
    }
    .width(this.zoom)
    .height(this.zoom)
    .animation({ duration: 200, delay: this.index * 3, curve: Curve.ExtremeDeceleration })
    .backgroundColor(this.image())
    .borderRadius(this.board_size * 4)
    .onAreaChange(()=>{
      this.zoom = "100%"
    })
  }

  get_init_zoom() {
    if (this.board_size == 0) {
      return "1%"
    }
    return "100%"
  }

}