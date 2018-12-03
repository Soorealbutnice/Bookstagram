package com.dnb.member.service;

import java.util.List;
import java.util.Map;


import com.dnb.member.model.MemberDto;

public interface MemberService {
   
   int idCheck(String id);
   int insertMember(MemberDto memberDto) throws Exception;
   int insertApi(String id);

   int writeArticle(MemberDto memberDto);
   List<MemberDto> selectMember();
   int updateMember(MemberDto memberDto);
   void deleteMember(String id);
   MemberDto getMember(String id);

   MemberDto login(Map<String, String> map);
   void userAuth(String email) throws Exception;

}