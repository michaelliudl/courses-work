class ChecksumAccumulator {
  private var sum = 0
  def add(input: Byte) { sum += input }
  def checksum(): Int = ~(sum & 0xFF) + 1
}

import scala.collection.mutable.Map

object ChecksumAccumulator {
  private val cache = Map[String, Int]()
  def calculate(input: String): Int = {
    if (cache.contains(input))
      cache(input)
    else {
      val acc = new ChecksumAccumulator
      for (char <- input)
        acc.add(char.toByte)
      val cs = acc.checksum()
      cache += (input -> cs)
      cs
    }
  }
}

