package com.matcher;

import java.util.ArrayList;

public class FiniteAutomaton implements Matcher {
  private String pattern;
  private char[] alphabet;
  private int[][] transition;
  
  FiniteAutomaton(String pattern, String alphabet) {
    this.pattern = pattern;
    this.alphabet = alphabet.toCharArray();
    generateTransitionArray();
  }
  
  @Override
  public ArrayList<Integer> findMatch(String text) {
    ArrayList<Integer> offset = new ArrayList<>();
    int m = pattern.length();
    int q = 0;
    for (int i = 0; i < text.length(); i++) {
      q = transition[q][alphabetIndex(text.charAt(i))];
      if (q == m) {
        offset.add(i - m + 1);
      }
    }
    return offset;
  }
  
  private void generateTransitionArray() {
    int m = pattern.length();
    transition = new int[m + 1][alphabet.length];
    for (int i = 0; i < m + 1; i++) {
      for (int j = 0; j < alphabet.length; j++) {
        int k = Math.min(m, i + 1);
        while (k > 0 && !(pattern.substring(0, Math.min(i + 1, m))).startsWith(pattern.substring(i - k + 1, i) + alphabet[j])) {
          k--;
        }
        transition[i][j] = k;
      }
    }
  }
  
  private int alphabetIndex(char a) {
    int i = 0;
    while (alphabet[i] != a) {
      i++;
      if (i >= alphabet.length)
        throw new IndexOutOfBoundsException("Letter not in alphabet");
    }
    return i;
  }
  
  @Override
  public void setPattern(String pattern) {
    this.pattern = pattern;
    generateTransitionArray();
  }
}
