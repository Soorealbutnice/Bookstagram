package com.dnb.member.dao;

import java.util.HashMap;

public interface ChartDao {

   HashMap<String, Integer> avgreadbook(String id);
   HashMap<String, Integer> myreadbook(String id);
   HashMap<String, Integer> listwritereview(String id);
   HashMap<String, Integer> listreadbook(String id);
   HashMap<String, Integer> listavgbook(String id);
}