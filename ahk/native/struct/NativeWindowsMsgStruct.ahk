/************************************************************************
 * @description 
 * @file NativeWindowsMsgStruct.ahk
 * @author Jackson
 * @date 2023/09/21
 * @version 0.0.1
 ***********************************************************************/

/** Windows 消息结构体 -> {WindowsTagStruct}
 * @example
 * DllCall('GetMessage',
 * 'ptr',NativeWindowsMsgStruct()
 * ,'int',0,'int',0,'uint',0x312-1)
 */
class NativeWindowsMsgStruct {
  HWND: u64
  message: u32
  wParam: u32
  lParam: u32
  time: u64
  point: u64
}