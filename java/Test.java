public class Test {
    public static void main(String[] args) {
        MyInterface[] myArray = new MyInterface[10];
        System.out.println(myArray);
    }
    public interface MyInterface {
        void method1();
        void method2();
    }
}
