/************************************************************************
 * @description 
 * @file Subroutine.ahk
 * @author Jackson
 * @date 2023/09/01
 * @version 0.0.1
 ***********************************************************************/

/** @async 封装SetTimer实现异步函数执行类, 用于异步执行函数,并返回结果
 */
class Subroutine {
  /** @type {Func} 异步执行的目标函数 */
  Action := unset
  /** 创建一个SetTimer实现的异步函数执行对象, 异步执行函数将结果传入回调函数
   * @param {Func} Action 子程序要执行的函数对象
   */
  __New(Action) {
    this.Action := Action
  }
  /** 传入参数异步执行子程序, 并返回一个回调函数.
   * @param {Array} Params 参数列表
   * @returns {Subroutine.Callback} 回调函数
   */
  Call(Params*) {
    callback := Subroutine.Callback()
    SetTimer(() {
      callback.Result := (this.Action)(Params*)
      if (callback.HasProp('Functions'))
        loop callback.Functions.Length{
          callback.Functions.Pop()(callback.Result)
        }
    }, -1, -1)
    return callback
  }

  class Callback {
    /** @type {Any} Subroutine的执行结果 */
    Result := unset
    /** @type {Array<Subroutine>} 回调函数队列 */
    Functions := []
    /** Subroutine的回调, 被调用的函数具有一个参数(Result), 为Subroutine执行结果
     * @param {Array<(Result)=>void>} Functions `Array<(Result)=> Void>` 回调函数列表
     * @returns {Subroutine.Callback} this
     */
    Call(Functions*) {
      if (this.HasProp('Result')){
        loop Functions.Length
          Functions[A_Index](this.Result)
      }else {
        this.HasProp('Functions')
          ? this.Functions.Push(Functions*)
          : this.Functions := Functions
      }
       return this
    }
  }
}