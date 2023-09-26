/************************************************************************
 * @description 
 * @file Task.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

/** @async 封装SetTimer实现的异步任务类, 异步执行函数并根据执行状态回调状态监听
 * ```
 * Start -> OnStart? -> Throw|Success(Result)
 *      Throw -> OnCatch(Error)? Success::Error
 *      Success -> OnSuccess(Result) -> Finally
 *      Error -> OnError(Error) -> Finally
 * Finally -> OnFinally
 * ```
 */
class Task {
  /** @prop {Func} Action 执行对象 */
  Action := unset
  /** @prop {Number} Priority 任务优先级, -2147483648~2147483647之间 */
  Priority := unset

  ;#region 事件回调函数属性列表
  /** @prop {()=>Boolean} _HandleStart */
  _HandleStart := unset
  /** @prop {(Error)=>Any} _HandleCatch */
  _HandleCatch := unset
  /** @prop {(Result)=>Void} _HandleSuccess */
  _HandleSuccess := unset
  /** @prop {()=>Void} _HandleError */
  _HandleError := unset
  /** @prop {(Error)=>Void} _HandleFinally */
  _HandleFinally := unset
  ;#endregion

  /** 初始化一个Task对象, 用于异步执行(Action)
   * @param {Func} Action 执行对象
   * @param {number} Priority 任务优先级, -2147483648~2147483647
   */
  __New(Action, Priority := 0) {
    this.Initial(Action, Priority)
  }
  /** @param {Func} Action */
  Initial(Action?, Priority?) {
    if (IsSet(Action))
      this.Action := Action
    if (IsSet(Priority))
      this.Priority := Priority
    return this
  }

  /** 于(Delay)延迟(毫秒)后开始任务
   * @param {Number} Delay 延迟开始的时间(毫秒)
   * @returns {Task} this
   */
  Start(Delay := -1) {
    Delay := Delay == 0 ? -1 : -Abs(Delay)
    SetTimer(this, Delay, this.Priority)
    return this
  }
  /** 用于注册SetTimer(this), 由SetTimer调用的函数 */
  Call() {
    state := this._HandleStart?.Call() ?? 1
    if (state) {
      try result := (this.Action)()
      catch Error as exception {
        /** 使用result保存OnCatch结果, 若没有回调OnCatch, result为false */
        result := this._HandleCatch?.Call(exception)??false
        /** 若result为true 表示OnCatch处理了错误, 并将result传入OnSuccess; 否则调用OnError(Error)*/
        result ? this._HandleSuccess?.Call(result)
          : this._HandleError?.Call(exception)
      } else {
        this._HandleSuccess?.Call(result)
      }
    }
    this._HandleFinally?.Call()
  }

  /** @deprecated 复制当前任务, 目前仅复制Action */
  Clone() {
    return Task(this.Action)
  }

  ;#region 事件注册
  /** 注册当任务开始时调用事件回调函数(Callback)
   * @param {()=>Boolean} Callback OnStart回调函数, 返回True将执行任务
   * @returns {Task} this
   */
  OnStart(Callback) {
    this._HandleStart := Callback
    return this
  }
  /** 注册当任务出现错误时事件回调函数(Callback)
   * @param {(Error)=>Any} Callback OnCatch回调函数, Error发生的错误对象, 返回结果为False将流转至OnError；否则OnSuccess(Result)
   * @returns {Task} this
   */
  OnCatch(Callback) {
    this._HandleCatch := Callback
    return this
  }
  /** 注册当任务执行完成时, 或由OnCatch事件成功流转的事件回调函数(Callback)
   * @param {(Result)=>Void} Callback OnSuccess回调函数, 接受一个参数(Result)为(Action|Catch)的执行结果
   * @returns {Task}  this
   */
  OnSuccess(Callback) {
    this._HandleSuccess := Callback
    return this
  }
  /** 注册OnCatch事件的流转失败后的事件回调函数(Callback)
   * @param {(Error)=>Void} Callback OnError回调函数
   * @returns {Task} this
   */
  OnError(Callback) {
    this._HandleError := Callback
    return this
  }
  /** 注册任务最后总是执行的回调函数(Callback)
   * @param {()=>Void} Callback OnFinally回调函数
   * @returns {Task} this
   */
  OnFinally(Callback) {
    this._HandleFinally := Callback
    return this
  }
  ;#endregion

}