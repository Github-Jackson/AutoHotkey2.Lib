/** 用于应用程序初始化的配置对象 */
class Application {
  static CONFIG := "App.config"
  static __New(config := Application.CONFIG) {
    
  }

  __New() {
    static SINGLE := this.Initila()
    MsgBox()
    return SINGLE
  }
  /** 测试方法
   * 
   */
  Test(){
    MsgBox("Application.Test")
  }

  Initila(){
    MsgBox("initial")
    return "init"
  }
}

