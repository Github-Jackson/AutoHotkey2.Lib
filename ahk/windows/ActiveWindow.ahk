
/** 该类总是对当前激活(活动)的窗口操作 */
class ActiveWindow {
  WindowQueue := unset
  __New() {
    ; super.__New('A')
    ; Timer(() {
    this.WindowQueue := WindowQueue := []
    NativeThread((){
      SetWinDelay(-1)
      
      loop {
        currentTitle := WinGetTitle(WinActive('A'))
        ; currentHwnd := WinActive('A')
        ; hwnd := WinWaitActive('', , ,'ahk_id ' currentHwnd)
        ; MsgBox(WinGetTitle(hwnd),currentHwnd)
        hwnd := WinWaitActive('', , ,currentTitle)
        WindowQueue.Push(hwnd)
        Timer((){
          FileAppend(WinGetProcessName(hwnd) ':' WinGetTitle(hwnd) '`n','log.txt')
        },-1)
      }
    })
  }
}

#Include <ahk\async\Timer>
#Include <ahk\native\NativeThread>
