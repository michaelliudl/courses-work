package main

import (
	"fmt"
	"math"
	"math/cmplx"
)

func main() {
	tour1()
	tour6()
	tour13()
	tour14()
	tour16()
	tour23()
	tour24()
	tour30()
	tour31()
	tour32()
	tour33()
	tour34()
}

func tour34() {
	pow := make([]int, 10)
	for i := range pow {
		pow[i] = 1 << uint(i)
	}
	for _, value := range pow {
		fmt.Printf("%d\n", value)
	}
}

var power = []int{1, 2, 4, 8, 16, 32, 64, 128}

func tour33() {
	for i, v := range power {
		fmt.Printf("2**%d = %d\n", i, v)
	}
}

func tour32() {
	var z []int
	fmt.Println(z, len(z), cap(z))
	if z == nil {
		fmt.Println("nil!")
	}
}

var (
	ToBe   bool       = false
	MaxInt uint64     = 1<<64 - 1
	CompZ  complex128 = cmplx.Sqrt(-5 + 12i)
)

func add(x int, y int) int {
	return x + y
}

func minus(x, y int) int {
	return x - y
}

func swap(x, y string) (string, string) {
	return y, x
}

func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

var x, y, z int = 100, 99, 88
var c, python, java = true, false, "no!"

const Pi = 3.14

const (
	Big   = 1 << 100
	Small = Big >> 99
)

func needInt(x int) int           { return x*10 + 1 }
func needFloat(x float64) float64 { return x * 0.1 }

func forLoop() {
	sum := 0
	for i := 0; i < 10; i++ {
		sum += i
	}
	fmt.Println(sum)
}

func forLoop1() {
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
}

func forLoop2() {
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
}

func sqrt(x float64) string {
	if x < 0 {
		return sqrt(-x) + "i"
	}
	return fmt.Sprint(math.Sqrt(x))
}

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	} else {
		fmt.Printf("%g >= %g\n", v, lim)
	}
	return lim
}

func Sqrt(x float64) float64 {
	z := 1.0
	for i := 0; i < 100; i++ {
		z = z - (z*z-x)/2*z
	}
	return z
}

func Sqrt1(x float64) float64 {
	i := 0
	z := 1.0
	for ; math.Abs(x-z*z) > 0.001; i++ {
		z = z - (z*z-x)/(2*z)
	}
	fmt.Println(i)
	return z
}

type Vertex struct {
	X, Y int
}

var (
	p = Vertex{100, 200}
	q = &Vertex{300, 400}
	r = Vertex{X: 50}
	s = Vertex{}
)

func tour14() {
	const World = "世界"
	fmt.Println("Hello, ", World)
	fmt.Println("Happy", Pi, "Day")
	const Truth = true
	fmt.Println("Go rules?", Truth)
	fmt.Println(needInt(Small))
	//fmt.Println(needInt(Big))
	fmt.Println(needFloat(Small))
	fmt.Println(needFloat(Big))
}

func tour13() {
	x, y, z := 1001, math.Pi*2, math.E
	c, python, java := "c language", 0x64, true
	fmt.Println(x, y, z, c, python, java)
	const f = "%T(%v)\n"
	fmt.Printf(f, ToBe, ToBe)
	fmt.Printf(f, MaxInt, MaxInt)
	fmt.Printf(f, CompZ, CompZ)
}

func tour6() {
	fmt.Println(add(33, 25))
	fmt.Println(minus(124, 568))
	a, b := swap("hello", "world")
	fmt.Println(a, b)
	fmt.Println(split(17))
}

func tour1() {
	fmt.Printf("hello, world")
	fmt.Printf("\tgood night")
	fmt.Println("\tmorning call")
	fmt.Println("Happy", math.Pi, "day")
	fmt.Printf("Now you have %g problems.\n",
		math.Nextafter(2, 3))
}

func tour16() {
	forLoop()
	forLoop1()
	forLoop2()
}

func tour23() {
	fmt.Println(sqrt(2), sqrt(-4))
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
	fmt.Println(Sqrt(2))
	fmt.Println(Sqrt1(2))
}

func tour24() {
	v := Vertex{1, 2}
	v.X = 4
	w := &v
	w.X = 1e9
	fmt.Println(v)
	fmt.Println(w)
	fmt.Println(p, q, r, s)
	var vertez *Vertex = new(Vertex)
	vertez.X, vertez.Y = 111, 999
	fmt.Println(vertez)
	vertey := new(Vertex)
	vertey.X, vertey.Y = 222, 888
	fmt.Println(vertey)
}

func tour30() {
	p := []int{2, 3, 5, 7, 11, 13}
	fmt.Println("p == ", p)
	for i := 0; i < len(p); i++ {
		fmt.Printf("p[%d] == %d\n", i, p[i])
	}
	fmt.Println("p[1:4] == ", p[1:4])
	fmt.Println("p[:3] == ", p[:3])
	fmt.Println("p[4:] == ", p[4:])
}

func tour31() {
	a := make([]int, 5)
	printSlice("a", a)
	b := make([]int, 0, 5)
	printSlice("b", b)
	c := b[:2]
	printSlice("c", c)
	printSlice("b", b)
	d := c[2:5]
	printSlice("d", d)
	printSlice("b", b)
}

func printSlice(s string, x []int) {
	fmt.Printf("%s len=%d cap=%d %v\n",
		s, len(x), cap(x), x)
}
