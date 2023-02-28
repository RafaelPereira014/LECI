package Compiladores.aula1;

import java.util.Stack;
import java.util.*;

public class calculator1_3 {
    public static void main(String[] args) {
       //create stack
        Stack<Double> stack = new Stack<Double>();

        try (Scanner sc = new Scanner(System.in)) {
            while(sc.hasNextLine()){

                String line = sc.nextLine();
                String[] tokens = line.split(" ");
                
                for(int i=0;i<tokens.length;i++){
                    double val = value(tokens[i]);
                    if(val != -1){
                        stack.push(val);
                    }else{
                        double a = stack.pop();
                        double b = stack.pop();
                        switch (tokens[i]) {
                            case "+":
                                stack.push(a + b);
                                break;
                            case "-":
                                stack.push(a - b);
                                break;
                            case "*":
                                stack.push(a * b);
                                break;
                            case "/":
                                stack.push(a / b);
                                break;
                            default:
                                System.out.println("Invalid operator");
                                break;
                        }
                        
                    }
                    System.out.println("Stack: " + stack);
                    
                }    
            }
        }
    }

    static double value(String s) {
        try {
            return Double.parseDouble(s);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}
