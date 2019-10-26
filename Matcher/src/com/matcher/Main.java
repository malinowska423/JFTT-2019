package com.matcher;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        if (!(args[0].equals("-fa") || args[0].equals("-kmp"))) {
            System.err.println("Invalid arguments." +
                " Please type \"-fa\" " +
                "\n\tfor finite automaton algorithm " +
                "\nor \"-kmp\" " +
                "\n\tfor Knuth-Morris-Pratt algorithm." );
            
        } else {
            Scanner scanner = new Scanner(System.in);
            Matcher matcher;
            if (args[0].equals("-fa")) {
                matcher = new FiniteAutomaton();
            } else {
                matcher = new KMP();
            }
            System.out.println("You searching with " + matcher.getClass().getSimpleName());
            System.out.print("Enter the pattern: ");
            String pattern = scanner.nextLine();
            System.out.println("Enter the line of text to search: ");
            String input = scanner.nextLine();
            while (!input.equals("-q") && !input.equals("-Q")) {
                System.out.println("Pattern occurs with offset "
                    + matcher.findMatch(input, pattern));
                System.out.println("#############");
                System.out.print("Enter the pattern: ");
                pattern = scanner.nextLine();
                System.out.println("Enter the line of text to search: ");
                input = scanner.nextLine();
            }
            scanner.close();
        }
    }
}
