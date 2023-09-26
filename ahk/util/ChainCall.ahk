/************************************************************************
 * @description 
 * @file ChainCall.ahk
 * @author Jackson
 * @date 2023/09/25
 * @version 0.0.1
 ***********************************************************************/

class ChainCall {

  /** 构建链式调用, 需要先实现一个Proxy对象才能处理已经具备Call方法的对象
   * @param {Object|()=>Void} Value 
   * @returns {ChainCall} 
   */
  static Call(Value) {
    Value := HasMethod(Value) ? Value() : Value
    Call(this, Call) {
      return ChainCall.Call(Call.Bind(this))
    }
    CallProxy(this){
      /** ? 看起来需要一个Proxy对象 */
    }
    if (HasMethod(Value, 'Call')) {
      if(Value.Call != CallProxy){

      }
    }
    Value.Base.Call := Call
    return Value
  }
  /** 链式调用
   * @param {(Result)=>Any} Call 链式调用的目标函数, 参数{Result}为上一次链式调用的结果
   * @return {ChainCall}
   */
  Call(Call) {
  }
}