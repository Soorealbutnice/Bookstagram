package com.dnb.member.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.member.dao.ChartDao;
import com.dnb.member.model.MemberDto;
import com.dnb.member.model.ReadBookDto;

@Service
public class ChartServiceImpl implements ChartService{

   @Autowired
   SqlSession sqlSession;

   @Override
   public HashMap<String, Integer> avgreadbook(String id) {
      return sqlSession.getMapper(ChartDao.class).avgreadbook(id);
   }

   @Override
   public HashMap<String, Integer> myreadbook(String id) {   
      return sqlSession.getMapper(ChartDao.class).myreadbook(id);
      
   }

   @Override
   public HashMap<String, Integer> listwritereview(String id) {
      return sqlSession.getMapper(ChartDao.class).listwritereview(id);
   }

   @Override
   public HashMap<String, Integer> listreadbook(String id) {
      return sqlSession.getMapper(ChartDao.class).listreadbook(id);
   }

   @Override
   public HashMap<String, Integer> listavgbook(String id) {
      return sqlSession.getMapper(ChartDao.class).listavgbook(id);
   }
   
}