#Include <ahk\native\Native>
#Include <ahk\native\NativeThread>

Await(Action) {
  result := unset
  ; threadId := Native.GetCurrentThreadId()
  ; thread := Native.OpenThread(threadId)
  thread := NativeThread(() {
    result := Action()
    ; Native.ResumeThread(thread)
  })
  /** 可能存在还未执行Suspend, 新的线程就已经Resume */
  ; Native.SuspendThread(thread)
  Native.WaitForSingleObject(thread)
  return result
}