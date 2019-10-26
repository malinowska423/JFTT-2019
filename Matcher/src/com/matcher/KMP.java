package com.matcher;

import java.util.ArrayList;

public class KMP implements Matcher {
  private String pattern;
  private ArrayList<Integer> prefix;
  
  public KMP(String pattern) {
    this.pattern = pattern;
    this.prefix = prefix(pattern);
  }
  
  @Override
  public int findMatch(String text) {
    return 0;
  }
  
  private ArrayList<Integer> prefix(String pattern) {
    return null;
  }
}
