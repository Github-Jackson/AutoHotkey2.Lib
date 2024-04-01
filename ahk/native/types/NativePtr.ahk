/************************************************************************
 * @description 
 * @file NativePtr.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.1
 ***********************************************************************/
#Include <ahk\native\types\NativeType>

/** 表示Native调用中的指针类型
 * @classdesc 等同于Int或Int64, 具体取决于运行脚本的位数.
 * Ptr应该用于指向数组和结构(如RECT*和LPPOINT)
 * 以及几乎所有的句柄(如HWND, HBRUSH 和 HBITMAP)的指针.
 * 如果参数是指向简单数值的指针(如 LPDWORD 或 Int*), 通常应该使用*或P后缀类型.
 * @extends {NativeType}
 */
class NativePtr extends NativeType {
  /** @type {String} Ptr */
  static Type := NativeType.Ptr
  /** 
   * @param {Number} Value 等同于Int或Int64, 要传递NULL句柄或指针, 请指定整数 0
   */
  __New(Value:= 0) {
    super.__New('Ptr',Value)
  }
}