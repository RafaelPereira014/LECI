package Compiladores.aula1;

public class calculator {
    public static void main(String[] args) {
        String operator = String.valueOf(args[0]);
        double a = Double.parseDouble(args[1]);
        double b = Double.parseDouble(args[2]);
        switch (operator) {
            case "+":
                System.out.println("Result:" + (a + b));
                break;
            case "-":
                System.out.println("Result:" + (a - b));
                break;
            case "*":
                System.out.println("Result:" + (a * b));
                break;
            case "/":
                System.out.println("Result:" + (a / b));
                break;
            default:
                System.out.println("Invalid operator");
                break;
        }
    }
}