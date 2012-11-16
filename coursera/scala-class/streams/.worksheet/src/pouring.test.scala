package pouring

object test {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(75); 
  val problem = new Pouring(Vector(4, 7, 9));System.out.println("""problem  : pouring.Pouring = """ + $show(problem ));$skip(16); val res$0 = 
  problem.moves;System.out.println("""res0: scala.collection.immutable.IndexedSeq[Product with Serializable with pouring.test.problem.Move] = """ + $show(res$0));$skip(34); val res$1 = 
  problem.pathSets.take(2).toList;System.out.println("""res1: List[Set[pouring.test.problem.Path]] = """ + $show(res$1));$skip(22); val res$2 = 
  problem.solution(6);System.out.println("""res2: Stream[pouring.test.problem.Path] = """ + $show(res$2))}
}