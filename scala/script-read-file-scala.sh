#!/bin/sh
exec scala "$0" "$@"
!#
import scala.io.Source
if (args.length > 0) {
    val linesList = Source.fromFile(args(0)).getLines().toList
    val longestLine = linesList.reduceLeft(
        (current, next) => if (current.length > next.length) current else next)
    val maxWidth = widthOfLength(longestLine)
    val result = formatLines(linesList, maxWidth)
    println(result)
} else {
    Console.err.println("Please enter filename")
}

def formatLines(linesList: List[String], maxWidth: Int):String = {
    linesList.map(line => formatLine(line, maxWidth)).mkString("\n")
}

def widthOfLength(line: String) = line.length.toString.length

def formatLine(line: String, maxWidth: Int) = {
    val numSpaces = maxWidth - widthOfLength(line)
    val padding = " " * numSpaces
    padding + line.length + " | " + line
}
