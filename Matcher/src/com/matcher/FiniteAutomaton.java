package com.matcher;

import java.util.Scanner;

public class FiniteAutomaton implements Matcher {
  private int[][] transition;
  
  @Override
  public int findMatch(String text, String pattern) {
    int index = -1;
    Scanner scanner = new Scanner(System.in);
    System.out.print("Enter the alphabet: ");
    char[] sigma = scanner.next().toCharArray();
    transition(pattern, sigma);
    int m = pattern.length();
    int q = 0;
    for (int i = 0; i < text.length(); i++) {
      q = transition[q][alphabetIndex(text.charAt(i), sigma)];
      if (q == m) {
        index = i - m + 1;
      }
    }
    return index;
  }
  
  private void transition(String pattern, char[] alphabet) {
    int m = pattern.length();
    transition = new int[m + 1][alphabet.length];
    for (int q = 0; q < m + 1; q++) {
      for (int i = 0; i < alphabet.length; i++) {
        int k = Math.min(m, q + 1);
        while (k > 0 && !(pattern.substring(0, Math.min(q + 1, m))).startsWith(pattern.substring(q - k + 1, q) + alphabet[i])) {
          k--;
        }
        transition[q][i] = k;
      }
    }
  }
  
  
  private int alphabetIndex(char a, char[] alphabet) {
    int i = 0;
    while (alphabet[i] != a) {
      i++;
      if (i >= alphabet.length)
        throw new IndexOutOfBoundsException("Letter not in alphabet");
    }
    return i;
  }
  
  
  
  private void printTransitionTable(char[] sigma) {
    System.out.print("x ");
    for (int i = 0; i < sigma.length; i++) {
      System.out.print(sigma[i] + " ");
    }
    System.out.println();
    for (int i = 0; i < transition.length; i++) {
      System.out.print(i + " ");
      for (int j = 0; j < transition[i].length; j++) {
        System.out.print(transition[i][j] + " ");
      }
      System.out.println();
    }
  }
  
}
