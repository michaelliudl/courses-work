import ChecksumAccumulator.calculate
object FallWinterSpringSummer extends App {
  List("fall", "winter", "spring").foreach(season => println(season + ": " + calculate(season)))
}
