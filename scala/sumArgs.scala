object sumArgs {
  def main(args: Array[String]) {
    try {
      val elements = args map Integer.parseInt
      println("sum of all arguments is " + elements.foldRight(0) (_ + _))
    } catch {
      case e: NumberFormatException =>
        println("Usage: scala sumArgs <arg1> <arg2> ...")
    }
  }
}

