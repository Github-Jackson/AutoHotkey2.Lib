/************************************************************************
 * @description 
 * @file TestTool.ahk
 * @author Jackson
 * @date 2023/09/01
 * @version 0.0.1
 ***********************************************************************/

/** 测试工具类 */
class TestTool {

  /** @prop {Array} Queue Array\<Call\> 测试计时队列 */
  static Queue := []
  /** @prop {Number} TickCount A_TickCount */
  static TickCount := A_TickCount

  /** @prop {()=>Void} Exec 目标测试对象 */
  Exec := unset
  /** 创建用于测试目标函数(fn)的工具对象
   * @param {()=>Void} Call 用于测试的目标执行对象
   */
  __New(Call) {
    this.exec := Call
  }

  /** 测试(Call)执行用时
   * @param {()=>Void} Call 测试的执行对象
   * @returns {Number} 执行用时(毫秒)
   */
  static RunTime(Call) {
    startTime := A_TickCount, Call()
    return A_TickCount - startTime
  }
  /** 测试(this.exec)执行用时
   * @returns {Number} 执行用时(毫秒)
   */
  RunTime() {
    return TestTool.RunTime(this.Exec)
  }

  /** 开始测试计时, 并返回用于结束计时的闭包函数
   * 该函数会自行维护计时队列, 可通过(End)函数获取最近一次Begin的计时
   * @returns {()=>Number} 闭包函数, 执行函数终止本次计时并返回执行用时(毫秒)
   */
  static Begin() {
    /** 语句末尾使用,并联能够略微提高执行效率 */
    this.TickCount := startTime := A_TickCount,
      result := () => A_TickCount - startTime,
        this.Queue.Push(result)
    return result
  }
  /** 返回最近一次计时结果, 并重置计时起点(该重置仅影响本函数)
   * @returns {Number} 返回最近一次的Begin创建的计时结果(毫秒); 
   * 若此前没有开始计时, 则返回类初始化至今的TickCount(毫秒)
   */
  static Continue() {
    return (result := A_TickCount - this.TickCount)
    && (this.TickCount := A_TickCount)
    && result
  }
  /** 将最近一次Begin创建的计时移除队列并返回计时结果(毫秒), 若队列为空返回0
   * @returns {Number} 最近一次Begin创建的计时结果(毫秒), 若队列为空返回0
   */
  static End() {
    return this.Queue.Length ? this.Queue.Pop()() : 0
  }

  /** 创建一个Continue计时器, 可供重复调用获取计时结果并重置计时中间量.
   * @returns {()=>Number} 返回一个Continue计时函数, 调用函数会返回计时结果并重置计时量 
   */
  static CreateContinue() {
    (startTime := A_TickCount)
    return () => (result := A_TickCount - startTime)
      && (startTime := A_TickCount)
      && result
  }


  /** 根据(Count:=1)次数循环执行(Call)，然后返回执行用时(毫秒)
   * @param {()=>Void} Call 
   * @param {Number} Count 循环的次数
   */
  static Loop(Call, Count := 1) {
    startTime := A_TickCount
    loop Count {
      Call()
    }
    return A_TickCount - startTime
  }
}