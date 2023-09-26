/** 用于Debug的调试类
 */
class Debug {
  /** 向Debug控制台打印(text:String)字符串
   * @param {String} text 需要打印的字符串
   * @returns {$Debug} this, 用于链式调用
   */
  static Log(text) {
    OutputDebug(text)
    return this
  }
  /** 显示脚本的变量: 它们的名称和当前的内容.
   * @returns {$Debug} 
   */
  static Vars() {
    ListVars()
    return this
  }
  /** 启用或禁用行日志记录或显示最近执行的脚本行.
   * @param {Boolean|Number} mode 1|True:
   * @returns {$Debug} 
   */
  static Lines(mode := true) {
    ListLines(mode)
    return this
  }
  /** 防止脚本在最后一个线程完成后自动退出, 允许它在空闲状态下运行.
   * @param {Boolean|Number} Persist 
   * @returns {Integer} 这个函数返回全局设置的前一个值; 0(false, 默认值) 或 1(true).
   */
  static Persistent(Persist := true){
    return Persistent(Persist)
  }
}
