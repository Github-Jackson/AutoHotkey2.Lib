/************************************************************************
 * @description 
 * @file Native.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.0
 ***********************************************************************/
#Include <ahk\native\NativeCall>
#Include <ahk\native\types\NativePtr>
#Include <ahk\native\types\NativeUInt>
#Include <ahk\native\types\NativeUIntP>
#Include <ahk\native\types\NativeCallback>

/** 封装Native函数调用 */
class Native {

  /** 创建一个线程执行(Callback)
   * @param {Func} Callback 线程启动的入口函数
   * @param {VarRef} ThreadId VarRef<Number> : 线程ID
   * @returns {Number} 线程句柄
   */
  static CreateThread(Callback, &ThreadId?) {
    result := NativeCall('CreateThread',
      NativePtr(0), NativeUInt(0),
        NativeCallback(Callback, 0),
          NativePtr(0), NativeUInt(0),
            lpThreadId := NativeUIntP(0)
    )
    ThreadId := lpThreadId.Value
    return result
  }

  /** 关闭打开的对象句柄
   * @param {Number} Handle 对象的有效句柄
   * @returns {Boolean} 
   */
  static CloseHandle(Handle){
    return NativeCall('CloseHandle',NativePtr(Handle))
  }

}