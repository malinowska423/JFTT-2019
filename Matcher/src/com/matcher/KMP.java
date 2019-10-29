package com.matcher;

import java.util.ArrayList;

public class KMP implements Matcher {
  private String pattern;
  private int[] prefix;
  
  KMP(String pattern) {
    this.pattern = pattern;
    computePrefixTable();
  }
  
  @Override
  public ArrayList<Integer> findMatch(String text) {
    ArrayList<Integer> offset = new ArrayList<>();
    int m = pattern.length();
    int q = 0;
    for (int i = 0; i < text.length(); i++) {
      while (q > 0 && pattern.charAt(q) != text.charAt(i)) {
        q = prefix[q - 1] + 1;
      }
      if (pattern.charAt(q) == text.charAt(i)) q++;
      if (q == m) {
        offset.add(i - m + 1);
        q = prefix[q - 1] + 1;
      }
    }
    return offset;
  }
  
  private void computePrefixTable() {
    int m = pattern.length();
    prefix = new int[m];
    prefix[0] = -1;
    int k = -1;
    for (int q = 1; q < m; q++) {
      while (k > -1 && pattern.charAt(k + 1) != pattern.charAt(q)) {
        k = prefix[k];
      }
      if (pattern.charAt(k + 1) == pattern.charAt(q)) k++;
      prefix[q] = k;
    }
  }
  
  @Override
  public void setPattern(String pattern) {
    this.pattern = pattern;
    computePrefixTable();
  }
}
