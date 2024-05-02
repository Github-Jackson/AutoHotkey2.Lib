#SingleInstance Force
#Warn VarUnset, Off

#Include <ahk>
#Include <ahk\debug\Debug>
#Include <ahkx\debug\Assert>
#Include <ahkx\test\TestTool>

#Include <Setup>
#Include <application\Application>
#Include <application\Log>

#Include <ahk\async\Timer>
#Include <ahk\io\FileProxy>
#Include <ahk\windows\Window>
#Include <ahk\windows\WinTitle>
#Include <ahk\windows\WinMatcher>
#Include <ahk\async\Subroutine>
#Include <ahk\async\Task>
#Include <ahk\util\ChainCall>
#Include <ahk\collection\Arrays>
#Include <ahk\async\Async>
#Include <ahk\lang\Proxy>

/**
 * promise
 * application -> ini
 * ArraySuper StringSuper Array.Prototype.xx := xx
 * Async
 * chaincall
 */


; #SingleInstance Off
(() {
  ; ahk.Setup()
  /** @type {ahk.Array} */
  arr := [1,2,3,4,5,6,7,8,9]
  /** @type {ahk.Array} */
  MsgBox(arr.Filter(v=>v>5?v:unset).Join())
  arr := []
  MsgBox(arr.Shift())
  ; ChainCall(100)(Value=>Value++)(Msgbox)
  ChainCall((*)=> 1000).Call(v=> ++v)(MsgBox)
  
  t:={
    Test : '1oji2'
  }
  p:=Proxy(t)
  res := p.this
  ; MsgBox(arr.Join())
  ; TestExecTime()
})()
/**
 * @returns {Array|ahk.Array} 
 */
Test(){
  return []
}

TestExecTime() {
  /** @type {ahk.Array} */
  arr := [1,2,3,4,5]

  TestTool.Begin()
  loop 10000 * 40 {
    ; WinMatcher.DetectHidden(() => 100)
    ; arr.Foreach((*)=>100)
    arr.Join()
    ; arr.Join(';')
  }
  LOG(TestTool.End() '`t')
}

#SuspendExempt true
#P:: Suspend()
#R:: Reload()
