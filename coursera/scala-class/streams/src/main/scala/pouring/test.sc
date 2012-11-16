package pouring

object test {
  val problem = new Pouring(Vector(4, 7, 9))      //> problem  : pouring.Pouring = pouring.Pouring@2dec8909
  problem.moves                                   //> res0: scala.collection.immutable.IndexedSeq[Product with Serializable with po
                                                  //| uring.test.problem.Move] = Vector(Empty(0), Empty(1), Empty(2), Fill(0), Fill
                                                  //| (1), Fill(2), Pour(0,1), Pour(0,2), Pour(1,0), Pour(1,2), Pour(2,0), Pour(2,1
                                                  //| ))
  problem.pathSets.take(2).toList                 //> res1: List[Set[pouring.test.problem.Path]] = List(Set(-->Vector(0, 0, 0)), S
                                                  //| et(Fill(0)-->Vector(4, 0, 0), Fill(2)-->Vector(0, 0, 9), Pour(0,1)-->Vector(
                                                  //| 0, 0, 0), Pour(1,0)-->Vector(0, 0, 0), Fill(1)-->Vector(0, 7, 0), Pour(1,2)-
                                                  //| ->Vector(0, 0, 0), Pour(0,2)-->Vector(0, 0, 0), Empty(0)-->Vector(0, 0, 0), 
                                                  //| Pour(2,0)-->Vector(0, 0, 0), Empty(1)-->Vector(0, 0, 0), Empty(2)-->Vector(0
                                                  //| , 0, 0), Pour(2,1)-->Vector(0, 0, 0)))
  problem.solution(6)                             //> res2: Stream[pouring.test.problem.Path] = Stream(Fill(2) Pour(2,1) Pour(1,0)
                                                  //|  Pour(0,2)-->Vector(0, 3, 6), ?)
}