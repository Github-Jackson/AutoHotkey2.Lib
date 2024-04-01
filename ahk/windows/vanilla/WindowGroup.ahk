/************************************************************************
 * @description 
 * @file WindowGroup.ahk
 * @author Jackson
 * @date 2023/09/22
 * @version 0.0.1
 ***********************************************************************/
/** ahk_group的封装 */
class WindowGroup extends Any{
  static DefaultGroupName {
    get => 'DefaultGroup'
  }
  /** @type {String} 窗口组名称, 组名不区分大小写. */
  Name := unset
  /** 创建一个Window Group 窗口组
   * @param {String} GroupName 窗口组名称, 组名不区分大小写.
   */
  __New(GroupName := WindowGroup.DefaultGroupName) {
    this.Name := GroupName
  }
  /** 增加窗口匹配条件到窗口组
   * @param {String} WinTitle 窗口匹配条件
   * @returns {WindowGroup} this
   */
  Add(WinTitle?) {
    GroupAdd(this.Name, WinTitle?)
    return this
  }
  /** 激活组中的下一个窗口
   * @param {'R'|unset} Mode 空或省略: 函数将激活最早的组内窗口.
   * R: 最新的组内窗口(最近激活的窗口) 被激活
   * @returns {WindowGroup} this
   */
  Activate(Mode?) {
    GroupActivate(this.Name, Mode?)
    return this
  }
  /** 激活不在组中的下一个窗口
   * @param {'R'|unset} Mode 空或省略: 函数将激活最老的非成员窗口.
   * R: 最新的非成员窗口(最近激活的窗口) 被激活
   * @returns {WindowGroup} this
   */
  Deactivate(Mode?) {
    GroupDeactivate(this.Name, Mode?)
    return this
  }
  /** 关闭刚刚被 GroupActivate 或 GroupDeactivate 激活的活动窗口.
   * 接着激活系列中的下一个窗口. 它还可以关闭组中所有窗口.
   * @param {'R'|'A'|unset} Mode 空或省略: 函数关闭活动窗口并激活组中最老的窗口
   * R: 最新的窗口(最近激活的窗口) 被激活
   * A: 关闭组的所有成员.等同于 WinClose "ahk_group GroupName".
   * @returns {WindowGroup} this
   */
  Close(Mode?) {
    GroupClose(this.Name, Mode?)
    return this
  }
  
  ;#region static functions
  /** 增加窗口匹配条件到窗口组
   * @param {String} WinTitle 窗口匹配条件
   * @returns {$WindowGroup} this
   */
  static Add(WinTitle?) {
    GroupAdd(this.DefaultGroupName, WinTitle?)
    return this
  }
  /** 激活(默认组)中的下一个窗口
   * @param {'R'|unset} Mode 空或省略: 函数将激活最早的(默认组)内窗口.
   * R: 最新的(默认组)内窗口(最近激活的窗口) 被激活
   * @returns {$WindowGroup} this
   */
  static Activate(Mode?) {
    GroupActivate(this.DefaultGroupName, Mode?)
    return this
  }
  /** 激活不在(默认组)中的下一个窗口
   * @param {'R'|unset} Mode 空或省略: 函数将激活最老的非成员窗口.
   * R: 最新的非成员窗口(最近激活的窗口) 被激活
   * @returns {$WindowGroup} this
   */
  static Deactivate(Mode?) {
    GroupDeactivate(this.DefaultGroupName, Mode?)
    return this
  }
  /** 关闭刚刚被 GroupActivate 或 GroupDeactivate 激活的活动窗口.
   * 接着激活系列中的下一个窗口. 它还可以关闭(默认组)中所有窗口.
   * @param {'R'|'A'|unset} Mode 空或省略: 函数关闭活动窗口并激活(默认组)中最老的窗口
   * R: 最新的窗口(最近激活的窗口) 被激活
   * A: 关闭(默认组)的所有成员.等同于 WinClose "ahk_group GroupName".
   * @returns {WindowGroup} this
   */
  static Close(Mode?) {
    GroupClose(this.DefaultGroupName, Mode?)
    return this
  }
  ;#endregion
}
