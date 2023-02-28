package Compiladores.aula1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class ex1_4{
    public static void main(String[] args) throws FileNotFoundException {
        Map<Integer, String> map = new HashMap<Integer, String>();

        try (Scanner sc = new Scanner(new File("numbers.txt"))) {
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] tokens = line.split(" ");
                map.put(Integer.parseInt(tokens[0]), tokens[1]);
            }
        }
        try (Scanner read = new Scanner(System.in)) {
            String frase = read.nextLine();
            for(int i=0;i<frase.length();i++){
                if(map.containsValue(frase.substring(i, i+1))){
                    System.out.println(map.);
                }else{
                    System.out.println("Invalid operator");
                }
            }
        }
        
    }
}