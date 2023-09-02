/************************************************************************
 * @description 
 * @file NativeCall.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\native\types\NativeType>
#Include <ahk\native\types\NativePointer>

/** 对DllCall的封装
 * @param {DllFile_Function|String} Name [DllFile\]Function -- 需要带反斜杠(\) 的路径. 不支持正斜杠(/).
 * 当调用位于 User32.dll, Kernel32.dll, ComCtl32.dll 或 Gdi32.dll 中的函数时, 可以省略 DllFile. 
 * @param {Array} NativeTypes {NativeType|NativePointer} 参数列表
 */
NativeCall(Name ,NativeTypes*){
  if(NativeTypes.Length){
    params := []
    for (key,value in NativeTypes) {
      /** 
       * @var {Number} key 数组下标
       * @var {NativeType|NativePointer} value
       */
      if(value is NativePointer){
        params.Push(value.Type, value.Pointer)
      }else if(value is NativeType){
        params.Push(value.Type, value.Value)
      }else {
        params.Push(value)
      }
    }
    return DllCall(Name,params*)
  }else {
    return DllCall(Name)
  }
}