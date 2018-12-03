package com.dnb.admin.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.admin.dao.AdminDao;
import com.dnb.member.model.MemberDto;

@Service
public class AdminServiceImpl implements AdminService {
   
   @Autowired
   SqlSession sqlSession;
   
   @Override
   public List<MemberDto> memberList(Map<String, String> map) {
      return sqlSession.getMapper(AdminDao.class).memberList(map);

   }
}