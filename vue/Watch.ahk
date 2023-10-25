/************************************************************************
 * @description 
 * @file Watch.ahk
 * @author Jackson
 * @date 2023/10/21
 * @version 0.0.1
 ***********************************************************************/
#Include <vue\Vue>
#Include <vue\Ref>

Watch(Source, WatchCallback) {
  StopWatch() {

  }
  watchSource := HasMethod(Source) ? Source : () {
    for (prop, val in Source.OwnProps()) {
    }
  },
    oldValue := unset,
    Vue.Effect.Push(() {
      newValue := watchSource(),
        Call := WatchCallback.Bind(oldValue, newValue),
        oldValue := newValue,
        Call()
    }),
    oldValue := watchSource(),
    Vue.Effect.Pop()
  return StopWatch
}