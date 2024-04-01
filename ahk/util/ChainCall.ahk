/************************************************************************
 * @description 
 * @file ChainCall.ahk
 * @author Jackson
 * @date 2023/09/25
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\lang\Proxy>
/** 构建链式调用,
 * 链式调用会构建对象的Call函数;
 * 若对象具备Call方法, 则创建目标对象的代理, 通过Proxy.this.Call调用原对象的Call方法
 */
class ChainCall {
  /** 链式调用的中间结果代理 */
  class Proxy extends Proxy {
    /** @type {*} 代理的目标对象 */
    this := unset
    __New(Target) {
      this.this := this
      super.__New(Target)
    }
    /** 代理目标的Call方法用于链式调用, 返回一个链式调用代理对象
     * @param {(Result)=>Any} Call 链式调用的方法
     * @returns {ChainCall.Proxy}
     */
    Call(Call) {
      result := Call(this.this)
      return ChainCall.Call(result)
    }
  }

  /** 构建链式调用
   * @param {Object|()=>Void} Value 
   * @returns {ChainCall.Proxy} Vlaue的代理对象或为{Primitive}基础类型设置.Base.Call
   */
  static Call(Value) {
    Call(this, Call) {
      return ChainCall.Call(Call(this))
    }
    if (Value is Primitive) {
      Value.Base.Call := Call
    } else if (HasMethod(Value, 'Call')) {
      if (Value.Call != Call) {
        if (!(Value is ChainCall.Proxy)) {
          return ChainCall.Proxy(Value)
        }
      }
    } else {
      Value.Call := Call
    }
    return Value
  }
}

