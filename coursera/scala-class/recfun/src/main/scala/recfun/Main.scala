package recfun
import common._
import scala.collection.immutable.Stack

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
  }

  /**
   * Exercise 1
   */
  def pascal(c: Int, r: Int): Int =
    if (c == 0 || c == r) 1
    else pascal(c - 1, r - 1) + pascal(c, r - 1)

  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean =
    if (chars isEmpty) true
    else {
      val parens: Stack[Char] = Stack.empty
      balance(chars, parens)
    }

  def balance(chars: List[Char], parens: Stack[Char]): Boolean =
        if (chars.isEmpty && parens.isEmpty) true
        else if (chars.isEmpty) false
        else {
          val headChar = chars.head
          if (headChar == ')')
            if (parens.isEmpty || parens.last != '(') false
            else balance(chars.tail, parens.pop)
          else if (headChar == '(')
            balance(chars.tail, parens.push(headChar))
          else
            balance(chars.tail, parens)
        }
  /**
   * Exercise 3
   */
  def countChange(money: Int, coins: List[Int]): Int =
    if (coins isEmpty) 0
    else if (money < 0) 0
    else if (money == 0) 1
    else
      countChange(money - coins.head, coins) + countChange(money, coins.tail)
  
  /*def countChangeOld(money: Int, coins: List[Int]): Int = {
    var total = 0
    var index = 0
    while (index < coins.length) {
      total = total + count(money, coins.drop(index))
      index += 1
    }
    total
  }
  
  def count(money: Int, coins: List[Int]): Int = {
    if (coins isEmpty) 0
    else {
      val first = coins.head
      if (first > money) count(money, coins.tail)
      else if (first == money) 1 + count(money, coins.tail)
      else {
        var total = 0
        var sum = 0
        while (sum < money) {
          sum = sum + first
          var myCoins = coins.tail
          while (!myCoins.isEmpty) {
            total = total + count(money - sum, myCoins)
            myCoins = myCoins.tail
          }
        }
        if (sum == money) total + 1
        else total
      }
    }
  }*/
}
