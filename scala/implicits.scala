object implicits extends Application {
  implicit def arrayWrapper[A : ClassManifest](x: Array[A]) =
    new {
      def sort(p: (A, A) => Boolean) = {
        util.Sorting.stableSort(x, p); x
      }
    }

  val x = Array(54, 43, 88, 20, 99, 34, 100, 99, 200)
  println("sorted x = " + x.sort((x: Int, y: Int) => x < y))
}
