/************************************************************************
 * @description 
 * @file Sound.ahk
 * @author Jackson
 * @date 2023/09/19
 * @version 0.0.1
 ***********************************************************************/

/** Sound系列内置函数的封装,//感觉用不到, 不想封装了 */
class Sound {
  static Volume[Component?, Device?] {
    get {
      return SoundGetVolume(Component?, Device?)
    }
  }
  /** 从PC扬声器发出Beep声
   * @param {Number} Frequency 声音的频率, 介于 37 和 32767 之间的数字.
   * @param {Number} Duration 声音的持续时间(毫秒)
   * @returns {$Sound} this
   * 
   * 脚本会等待声音结束后才继续执行. 此外, 在发出声音时系统的响应可能会减慢. 
   * 如果计算机没有声卡, 则 PC 扬声器将播放标准的哗音.
   * 要生成标准的系统声音而不是 PC 扬声器的哗音, 请参阅 SoundPlay 中的星号模式.
   */
  static Beep(Frequency := 523, Duration := 150) {
    SoundBeep(Frequency, Duration)
    return this
  }
}
