package com.matcher;

import java.util.ArrayList;

public interface Matcher {
  ArrayList<Integer> findMatch(String text);
  
  void setPattern(String pattern);
}
