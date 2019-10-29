package com.matcher;

public class Main {

    public static void main(String[] args) {
        if (!(args[0].equals("-fa") || args[0].equals("-kmp"))) {
            System.err.println("Invalid arguments." +
                " Please type \"-fa\" " +
                "\n\tfor finite automaton algorithm " +
                "\nor \"-kmp\" " +
                "\n\tfor Knuth-Morris-Pratt algorithm." );
            
        } else {
            Matcher matcher;
            if (args[0].equals("-fa")) {
                matcher = new FiniteAutomaton("αβαβ", "αβγδ");
            } else {
                matcher = new KMP("αβαβ");
            }
            System.out.println("You're searching with " + matcher.getClass().getSimpleName());
            System.out.println("1) ");
            matcher.findMatch("αβαβγβαβαβαβαβγ")
                .forEach(integer -> System.out.print(integer + " "));
            System.out.println("\n2) ");
            matcher.setPattern("αβ");
            matcher.findMatch("αβαβγβαβαβαβαβγ")
                .forEach(integer -> System.out.print(integer + " "));
        }
    }
}
