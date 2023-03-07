package Compiladores.aula1;

import java.util.Scanner;
import java.util.*;

class Node {
    char data;
    Node left, right;
 
    public Node(char item)
    {
        data = item;
        left = right = null;
    }
}
 

public class ex1_7 {
    
    public static void main(String[] args) {
       constructTree(args);
       
      


        
    }
    public static boolean isOperator(char c)
    {
        if (c == '+' || c == '-'
            || c == '*' || c == '/'
            || c == '^') {
            return true;
        }
        return false;
    }

    public static Node constructTree(String[] args)
    {
        Stack<Node> st = new Stack<Node>();
        for (int i = 0; i < args.length; i++) {
            if(isOperator(args[i].charAt(0))){
                Node right = st.pop();
                Node left = st.pop();
                Node node = new Node(args[i].charAt(0));
                node.left = left;
                node.right = right;
                st.push(node);
            }else{
                Node node = new Node(args[i].charAt(0));
                st.push(node);
            }   
        }
        Node root = st.peek();
        st.pop();
        return root;
    }

    public void printInfix(Node node){
        if(node != null){
            printInfix(node.left);
            System.out.print(node.data+" ");
            printInfix(node.right);
        }

    }

    public void eval(){

    }
}
