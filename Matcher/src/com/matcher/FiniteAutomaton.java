package com.matcher;

import java.util.ArrayList;

public class FiniteAutomaton implements Matcher {
  private String pattern;
  private ArrayList<Integer> transition;
  
  public FiniteAutomaton(String pattern) {
    this.pattern = pattern;
    this.transition = transition(pattern);
  }
  
  @Override
  public int findMatch(String text) {
    return 0;
  }
  
  private ArrayList<Integer> transition(String pattern) {
    return null;
  }
}
