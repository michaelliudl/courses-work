object cliMatch {
  var verbose = false
  def main(args: Array[String]) {
    for(a <- args) a match {
      case "-h" | "-help" =>
        println("Usage: scala cliMatch [-h|-help|-v|-verbose]")
      case "-v" | "-verbose" =>
        verbose = true
      case x =>
        println("Unknown option: '" + x + "'")
    }
    if (verbose)
      println("entring verbose mode.")
  }
}

