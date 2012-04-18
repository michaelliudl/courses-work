object foryield {
  def main(args: Array[String]) {
    val result = for (a <- args) yield a.toUpperCase
    println("Arguments: " + result.toString)
  }
}
