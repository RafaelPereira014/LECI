package Compiladores.aula1;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

public class ex1_4{
    public static void main(String[] args) throws FileNotFoundException {
        Map<String, String> map = new HashMap<>();
        try (Scanner sc = new Scanner(new File("numbers.txt"))) {
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] tokens = line.split("-");
                map.put(tokens[0], tokens[1]);

            }
            //System.out.println(map);

        Scanner read = new Scanner(System.in);
        System.out.println("Enter a phrase: ");
        String phrase = read.nextLine();
        String[] words = phrase.split(" ");
        
     }
        
    }
    
}