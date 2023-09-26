/************************************************************************
 * @description 
 * @file NativeCall.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/

#Include <ahk\native\types\NativeType>
#Include <ahk\native\types\NativePointer>
#Include <ahk\native\types\NativeReturnType>

/** 对DllCall的封装, 通过{NativeType}类型包装参数方便调用
 * @param {DllFile_Function|String} Name [DllFile\]Function -- 需要带反斜杠(\) 的路径. 不支持正斜杠(/).
 * 当调用位于 User32.dll, Kernel32.dll, ComCtl32.dll 或 Gdi32.dll 中的函数时, 可以省略 DllFile. 
 * @param {Array} NativeTypes Array<NativeType|NativePointer|NativeReturnType>
 * 调用的参数列表, 可在最后一位参数使用{NativeReturnType}描述返回值类型
 * @returns {Boolean|Number|String|Pointer}
 */
NativeCall(Name ,NativeTypes*){
  if(NativeTypes.Length){
    params := []
    /**
     * @var {Number} index 数组下标
     * @var {NativeType|NativePointer} value
     */
    index :=unset , value := unset
    for (index,value in NativeTypes) {
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