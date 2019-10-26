package com.matcher;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        if (args.length != 2 ||
            !(args[0].equals("-fa") || args[0].equals("-kmp"))) {
            System.err.println("Invalid arguments." +
                " Please type \"-fa pattern\" " +
                "\n\tfor finite automaton algorithm " +
                "\nor \"-kmp pattern\" " +
                "\n\tfor Knuth-Morris-Pratt algorithm." );
            
        } else {
            System.out.println("Type -q to exit");
            Scanner scanner = new Scanner(System.in);
            Matcher matcher;
            if (args[0].equals("-fa")) {
                matcher = new FiniteAutomaton(args[1]);
            } else {
                matcher = new KMP(args[1]);
            }
            System.out.println("You searching with " + matcher.getClass().getSimpleName());
            System.out.println("Enter the line of text to search: ");
            String input = scanner.nextLine();
            while (!input.equals("-q") && !input.equals("-Q")) {
                System.out.println("Pattern occurs with offset "
                    + matcher.findMatch(input));
                System.out.println("Enter the line of text to search: ");
                input = scanner.nextLine();
            }
            scanner.close();
        }
    }
}
