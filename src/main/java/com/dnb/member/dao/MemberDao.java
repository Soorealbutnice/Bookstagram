package com.dnb.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dnb.member.model.MemberDto;

public interface MemberDao {
   
   int idCheck(String id);
   int insertMember(MemberDto memberDto);
   int insertApi(String id);

   List<MemberDto> selectMember();
   int updateMember(MemberDto memberDto);
   MemberDto getMember(String id);
   
   MemberDto login(Map<String, String> map);
   int createAuthKey(@Param("email1")String email,@Param("key")String key);
   void userAuth(String user_email) throws Exception;
   int writeArticle(MemberDto memberDto);

   int deleteMember(String id);
   int deletePost(String id);
   int deletePin(String id);
   int deleteReply(String id);
   int deleteReadbook(String id);
   int deleteWantbook(String id);
   int deleteSupport(String id);
   int deleteFollow(String id);

}