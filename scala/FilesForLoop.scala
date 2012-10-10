val filesHere = (new java.io.File(".")).listFiles
def grep(pattern: String) {
    for (file <- filesHere
          if file.isFile
          if file.getName.endsWith(".scala");
          line <- fileLines(file)
          if line.trim.matches(pattern)
    ) println(file + ": " + line)
}
def fileLines(file: java.io.File) = scala.io.Source.fromFile(file).getLines.toList

grep(".*isFile.*")
