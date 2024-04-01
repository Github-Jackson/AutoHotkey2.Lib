/************************************************************************
 * @description 
 * @file Assert.ahk
 * @author Jackson
 * @date 2023/09/23
 * @version 0.0.1
 ***********************************************************************/
#Include AssertionError.ahk

/** 用于仅在非编译脚本中剩下的结果断言工具类 */
class Assert {

  /*@Ahk2Exe-Keep
  __Call(Name, Params) {
    return this
  }
  static __Call(Name, Params) {
    if(Params.Length == 1){
      return Params[1]
    }
    return this
  }
  */

  ;@Ahk2Exe-IgnoreBegin
  Target := unset
  __New(Value) {
    this.Target := Value
  }

  IsZero(){
    if(this.Target != 0){
      throw(AssertionError('目标不是0'))
    }
    return this
  }

  Is(Value){
    if(this.Target == Value){
      return this
    }
    throw(AssertionError('目标不想等'))
  }
  ;@Ahk2Exe-IgnoreEnd
}