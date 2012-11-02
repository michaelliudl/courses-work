package forcomp

object forcomp {
  /*("test" map (c => (c, 1))) groupBy (elem => elem._1) toList
  def wordOccurrences(word: String): List[(Char, Int)] =
    ((word.toLowerCase groupBy ((char: Char) => char) toList) map (elem => elem._1 -> elem._2.length)) sortWith (_._1 < _._1)
  def sentenceOccurrences(sentence: List[String]): List[(Char, Int)] =
    Nil
  
  wordOccurrences((List("te  st", "hel  lo") mkString "") filter (_.isLetter))
  List("tea", "ate", "eat", "hello") groupBy (elem => wordOccurrences(elem))
  def combinations(list: List[(Char, Int)]): List[List[(Char, Int)]] =
    //List(List()) ::: List(List(('a', 2))) ::: List(List(('a', 1))) ::: List(List())
    (for {
      (char, int) <- list
      count <- 1 to int
    } yield List((char, count))) ::: combinations1(list)
  
  def combinations1(list: List[(Char, Int)]): List[List[(Char, Int)]] = {
    list match {
      case List() => List(List())
      case x :: xs => {
        val (char, int) = x
        val first = (for (count <- 1 to int) yield (char, count)).toList
        for {
          firstPair <- first
          otherPair <- combinations1(xs)
        } yield (firstPair :: otherPair)
      }
    }
    //(1 to int) map (count => List(List((char, count))) ::: combinations1(list.tail))
  }
  combinations(List(('a', 2), ('b', 2)))
  combinations1(List(('a', 2), ('b', 2)))
  List(('a', 2)) ::: List(('b', 2))
  val long = (List(('a', 2), ('b', 2)) toMap)
  val short = (List(('a', 1)) toMap)
  //(short foldLeft long)(minusMap(_, _))
  //(List(('a', 2), ('b', 2)) toMap).foldLeft(List(('a', 1)) toMap) (minus)
  def minusMap(map: Map[Char, Int], pair: (Char, Int)): Map[Char, Int] = {
    val (char, int) = pair
    map + (char -> (map(char) - int))
  }
  val lard = List(('a', 1), ('d', 5), ('l', 1), ('r', 1))
  val r = List(('r', 1), ('d', 2))
  val remainder = for {
    (char, count) <- lard
    (ch, co) <- r
    if (char == ch)
  } yield (char, count - co)
  
  val lardmap: Map[Char, Int] = lard toMap
  val rmap: Map[Char, Int] = r toMap
  //(rmap foldLeft lardmap)(addTerm)
  def addTerm(terms: Map[Char, Int], term: (Char, Int)): Map[Char, Int] = {
    val (exp, coeff) = term
    terms + (exp -> (coeff + terms(exp)))
  }
  def removeTerm(terms: Map[Char, Int], term: (Char, Int)): Map[Char, Int] = {
    val (exp, coeff) = term
    terms + (exp -> (terms(exp) - coeff))
  }
  (rmap foldLeft lardmap)(addTerm)
  (rmap foldLeft lardmap)(removeTerm) filter (_._2 != 0) toList*/
  val list = (List(List(('a',1)), List(('e',1)), List(('e',2)), List(('m',1)), List(('m',2))).flatten)
                                                  //> list  : List[(Char, Int)] = List((a,1), (e,1), (e,2), (m,1), (m,2))
  val allList = ((((1 to list.length) map (list.combinations(_) toList)) flatten) toList)
                                                  //> allList  : List[List[(Char, Int)]] = List(List((a,1)), List((e,1)), List((e
                                                  //| ,2)), List((m,1)), List((m,2)), List((a,1), (e,1)), List((a,1), (e,2)), Lis
                                                  //| t((a,1), (m,1)), List((a,1), (m,2)), List((e,1), (e,2)), List((e,1), (m,1))
                                                  //| , List((e,1), (m,2)), List((e,2), (m,1)), List((e,2), (m,2)), List((m,1), (
                                                  //| m,2)), List((a,1), (e,1), (e,2)), List((a,1), (e,1), (m,1)), List((a,1), (e
                                                  //| ,1), (m,2)), List((a,1), (e,2), (m,1)), List((a,1), (e,2), (m,2)), List((a,
                                                  //| 1), (m,1), (m,2)), List((e,1), (e,2), (m,1)), List((e,1), (e,2), (m,2)), Li
                                                  //| st((e,1), (m,1), (m,2)), List((e,2), (m,1), (m,2)), List((a,1), (e,1), (e,2
                                                  //| ), (m,1)), List((a,1), (e,1), (e,2), (m,2)), List((a,1), (e,1), (m,1), (m,2
                                                  //| )), List((a,1), (e,2), (m,1), (m,2)), List((e,1), (e,2), (m,1), (m,2)), Lis
                                                  //| t((a,1), (e,1), (e,2), (m,1), (m,2)))
  (allList filter (list => (list toMap).size >= list.length))
                                                  //> res0: List[List[(Char, Int)]] = List(List((a,1)), List((e,1)), List((e,2)),
                                                  //|  List((m,1)), List((m,2)), List((a,1), (e,1)), List((a,1), (e,2)), List((a,
                                                  //| 1), (m,1)), List((a,1), (m,2)), List((e,1), (m,1)), List((e,1), (m,2)), Lis
                                                  //| t((e,2), (m,1)), List((e,2), (m,2)), List((a,1), (e,1), (m,1)), List((a,1),
                                                  //|  (e,1), (m,2)), List((a,1), (e,2), (m,1)), List((a,1), (e,2), (m,2)))
  ((1 to "abcd".length) map ("abcd".combinations(_)) flatten)
                                                  //> res1: scala.collection.immutable.IndexedSeq[String] = Vector(a, b, c, d, ab
                                                  //| , ac, ad, bc, bd, cd, abc, abd, acd, bcd, abcd)
  
  list map (List(_)) toList                       //> res2: List[List[(Char, Int)]] = List(List((a,1)), List((e,1)), List((e,2)),
                                                  //|  List((m,1)), List((m,2)))
}