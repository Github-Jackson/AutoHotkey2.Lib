/************************************************************************
 * @description 
 * @file Chaining.ahk
 * @author Jackson
 * @date 2023/09/25
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\lang\Proxy>
/** 构建链式调用-> 每次调用返回this  */
class Chaining extends Proxy {
  /** 代理目标对象以支持链式调用
   * @param Target 代理目标对象,使其每次方法调用都返回this.
   * @param {Class} Class 代理目标对象所属的类
   * @return {Class} 目标对象的代理
   */
  __New(Target,Class?) {
    this.DefineProp('__Get', {
      Call: (this, Key, Params) {
        return Target.%Key%[Params*]
      }
    })
    this.DefineProp('__Set', {
      Call: (this, Key, Params, Value) {
        Target.%Key%[Params*] := Value
      }
    })
    this.DefineProp('__Call', {
      Call: (this, Name, Params) {
        Target.%Name%(Params*)
        return this
      }
    })
  }
}