/************************************************************************
 * @description 
 * @file NativeCallback.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativePtr>

/** 表示Native调用中的回调函数类型
 * @extends {NativePtr}
 */
class NativeCallback extends NativePtr {
  /**
   * @param {Func} Callback 函数对象
   * @param {Number} ParamCount 如果未设置或省略, 
   * 则它默认为 Function.MinParams, 这通常是 Function 定义中强制参数的数目.
   * 否则, 请指定 Address 的调用者会传递给它的参数数目. 
   * 在这两种情况中, 必须确保调用者准确传递此数目的参数.
   */
  __New(Callback, ParamCount?) {
    super.__New(CallbackCreate(Callback, , ParamCount))
  }
}