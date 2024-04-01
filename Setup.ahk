#Include <ahk>
#Include <application\Application>

/** 使用默认设置创建{Application}配置对象, 初始化应用程序 */
class Setup {
  /** @type {String} 配置文件路径 */
  config:= '.config'

  __New() {
    
  }

  /** 根据(config)配置文件初始化
   * @param {Number} state 初始化状态
   * @param {String} [config] 配置文件路径
   */
  Init(state,config:='.config'){
    ahk.Setup()
  }
}