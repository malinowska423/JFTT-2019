package com.matcher;

public class KMP implements Matcher {
  private int[] prefix;
  
  
  @Override
  public int findMatch(String text, String pattern) {
    int n = text.length();
    int m = pattern.length();
    computePrefix(pattern);
    int q = 0;
    for (int i = 0; i < n; i++) {
      while (q > 0 && pattern.charAt(q) != text.charAt(i)) {
        q = prefix[q];
      }
      if (pattern.charAt(q) == text.charAt(i)) q++;
      if (q == m) {
        return i - m + 1;
      }
    }
    return -1;
  }
  
  private void computePrefix(String pattern) {
    int m = pattern.length();
    prefix = new int[m];
    prefix[0] = 0;
    int k = -1;
    for (int q = 1; q < m; q++) {
      while (k > -1 && pattern.charAt(k + 1) != pattern.charAt(q)) {
        k = prefix[k];
      }
      if (pattern.charAt(k + 1) == pattern.charAt(q)) k++;
      prefix[q] = k;
    }
  }
}
