/************************************************************************
 * @description 
 * @file Timer.ahk
 * @author Jackson
 * @date 2023/09/02
 * @version 0.0.0
 ***********************************************************************/
/** 对SetTimer的封装, 支持以指定时间定期异步执行函数的机制
 * @async
 */
class Timer {

  /** @type {Function} 回调函数: SetTimer以该对象标识唯一性用于管理和删除Timer, 请不要修改该属性 */
  Callback := unset
  /** @type {Number} 计时器的优先级 -2147483648~2147483647 */
  Priority := unset
  /** @type {Number} 执行周期(毫秒) */
  Period := unset
  /** @type {Number} 设置启动延迟(毫秒) */
  Delay := 0

  /** 初始化Timer并注册(SetTimer)定时器
   * @param {Number} Period 执行周期(毫秒)
   * @param {Number} Delay 启动延迟(毫秒)
   * @param {Number} Priority 计时器的优先级,-2147483648~2147483647
   * @returns {Timer} this
   */
  __New(Callback, Period := 250, Delay := 0,  Priority:= 0) {
    this.Callback := Callback
    this.Initial(Period, Delay, Priority)
  }
  /** 初始化Timer并注册(SetTimer)定时器
   * @param {Number} Period 执行周期(毫秒)
   * @param {Number} Delay 启动延迟(毫秒)
   * @param {Number} Priority 计时器的优先级
   * @returns {Timer} this
   */
  Initial(Period := 250, Delay := 0, Priority := 0) {
    this.Priority := Priority
    this.Period := Period
    this.Delay := Delay
    if(Delay){
      SetTimer(this.Register.Bind(this),-Abs(Delay),Priority)
    }else{
      this.Register()
    }
    this.DefineProp('Priority',{
      Get:(this)=>Priority,
      Set:(this,Value){
        SetTimer(this,,Priority := Value)
      }
    })
    return this
  }
  /** 注册(SetTimer)定时器
   *  @returns {Timer} this
   */
  Register(){
    SetTimer(this,this.Period,this.Priority)
    return this
  }

  Call(){
    return (this.Callback)()
  }

  Dispose() {
    SetTimer(this,0)
  }
  Stop(){
    this.Dispose()
  }
}