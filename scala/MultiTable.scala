val FIRST = 1
val LAST = 10
val WIDTH = 4

def multiTable() = {
  val rowList = 
    for (row <- FIRST to LAST)
      yield makeRow(row)
  rowList.mkString("\n")
}

def makeRow(row: Int) = makeColList(row).mkString

def makeColList(row: Int) = 
  for (col <- FIRST to LAST) yield {
    val prod = (row * col).toString
    val padding = " " * (WIDTH - prod.length)
    padding + prod
  }

println(multiTable)


