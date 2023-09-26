/************************************************************************
 * @description 
 * @file Mutex.ahk
 * @author Jackson
 * @date 2023/09/08
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\Native>

/** 原生实现用于并发同步的互斥锁
 */
class Mutex {
  /** @prop {String} Name 互斥对象的名称 */
  Name := unset
  /** @prop {Number} Handle 互斥对象初始化时的句柄 */
  Handle := unset

  /** 创建互斥对象
   * @param {string} Name 互斥对象的名称
   * @param {number} InitialOwner 调用方是否获取互斥体的初始所有权
   */
  __New(Name := '',InitialOwner := false) {
    this.Name := Name
    this.Handle := Native.CreateMutex(InitialOwner,Name)
  }

  /** 打开现有的命名互斥对象。
   * @returns {Number} Handle 互斥对象的句柄 
   */
  Open(){
    return Native.OpenMutex(this.Name)
  }

  /** 关闭目标句柄
   * @param {Number} Handle 目标句柄, 若省略则关闭当前Mutex句柄
   * @returns {Boolean} 
   */
  Close(Handle := this.Handle){
    return Native.CloseHandle(Handle)
  }

  /** 等待指定的对象处于信号状态或超时间隔已过。
   * @param {Number} Milliseconds 超时间隔(毫秒)
   * @returns {Number} DWORD 函数返回的事件
   * WAIT_ABANDONED(0x00000080L): 
   * 指定的 对象是一个互斥对象，在拥有的线程终止之前，拥有互斥对象对象的线程未释放该互斥对象。 互斥对象的所有权授予调用线程，互斥体状态设置为非签名。
   * 如果互斥体正在保护永久性状态信息，则应检查它以确保一致性。
   * 
   * WAIT_OBJECT_0(0x00000000L):
   * 指定对象的状态已发出信号。
   * 
   * WAIT_TIMEOUT(0x00000102L):
   * 超时间隔已过，并且对象的状态未对齐。
   * 
   * WAIT_FAILED((DWORD) 0xFFFFFFFF):
   * 函数失败。 要获得更多的错误信息，请调用 GetLastError。
   */
  Wait(Milliseconds:=-1){
    return Native.WaitForSingleObject(this.Handle,Milliseconds)
  }
  /** 等待指定的对象处于信号状态或超时间隔已过。
   * @param {Number} Milliseconds 超时间隔(毫秒)
   * @returns {Number} DWORD 函数返回的事件
   * WAIT_ABANDONED(0x00000080L): 
   * 指定的 对象是一个互斥对象，在拥有的线程终止之前，拥有互斥对象对象的线程未释放该互斥对象。 互斥对象的所有权授予调用线程，互斥体状态设置为非签名。
   * 如果互斥体正在保护永久性状态信息，则应检查它以确保一致性。
   * 
   * WAIT_OBJECT_0(0x00000000L):
   * 指定对象的状态已发出信号。
   * 
   * WAIT_TIMEOUT(0x00000102L):
   * 超时间隔已过，并且对象的状态未对齐。
   * 
   * WAIT_FAILED((DWORD) 0xFFFFFFFF):
   * 函数失败。 要获得更多的错误信息，请调用 GetLastError。
   */
  Call(Milliseconds:=-1,*){
    this.Wait(Milliseconds)
  }
  /** 释放指定互斥对象的所有权。
   * @param {Number} Handle Mutex对象句柄
   * @returns {Boolean} 
   */
  Release(Handle := this.Handle){
    return Native.ReleaseMutex(Handle)
  }
}