object TimerFunction extends Application {
  def oncePerSecond(callback: () => Unit) {
    while (true) {callback(); Thread sleep 1000L}
  }

  oncePerSecond(() =>
    println("Time flies like an arrow...")
      )
}
