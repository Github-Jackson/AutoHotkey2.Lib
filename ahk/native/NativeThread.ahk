/************************************************************************
 * @description 
 * @file NativeThread.ahk
 * @author Jackson
 * @date 2023/09/01
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\Native>
/** 于操作系统层面实现的原生线程
 * @alias ThreadNative <ahk\lang\ThreadNative>
 * @classdesc 命名为了规避Thread函数, 只能加前后最T_T
 */
class NativeThread {
  /** @prop {Number} Handle 线程句柄 */
  Handle := unset
  /** @prop {Number} ThreadId 线程ID*/
  ThreadId := unset
  /** 创建一个原生线程, 将(Callback)作为入口函数执行
   * @param {Func} Callback
   */
  __New(Callback) {
    this.Handle := Native.CreateThread(Callback,&threadId)
    this.ThreadId := threadId
  }

  /** 关闭线程句柄, 需要注意的是，关闭线程句柄后，相关的系统资源将被释放，
   * 但线程的执行状态和上下文信息将保留一段时间，直到操作系统回收内存。
   * 因此，关闭线程句柄不会立即终止线程的执行，
   * 只有在操作系统回收内存时，线程的上下文信息才会被释放
   * @returns {Boolean} 
   */
  Close(){
    return Native.CloseHandle(this.Handle)
  }
}