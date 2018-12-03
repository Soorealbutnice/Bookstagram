package com.dnb.member.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dnb.member.common.MailHandler;
import com.dnb.member.common.TempKey;
import com.dnb.member.dao.MemberDao;
import com.dnb.member.model.MemberDto;


@Service
public class MemberServiceImpl implements MemberService {
   
   @Autowired
   SqlSession sqlSession;
   @Inject
   private JavaMailSender mailSender;
   
   @Transactional
   @Override
   public int insertMember(MemberDto memberDto) throws Exception {
      
      int cnt = sqlSession.getMapper(MemberDao.class).insertMember(memberDto);
      String key = new TempKey().getKey(50, false); // 인증키 생성
      String email1 = memberDto.getEmail1();
      String email = memberDto.getEmail1()+"@"+memberDto.getEmail2();
      memberDto.setUser_authCode(key);
     
      MailHandler sendMail = new MailHandler(mailSender);
      sendMail.setSubject("[동네북 회원가입 인증]");
      sendMail.setText(
      new StringBuffer().append("<h1>메일인증</h1>").append("<h3>안녕하세요 동네북입니다 이메일인증을 완료하시고 프로필을 설정해보세요.</h3>").append("<a href='http://localhost/dnb/login/emailConfirm.dnb?user_email=").append(email).append("&email1=").append(email1).append("&key=").append(key).append("' target='_blenk'>확인 후 프로필 설정하러가기</a>").toString());
      sendMail.setFrom("hy545332@gmail.com", "동네북 관리자");
      sendMail.setTo(email);
      sendMail.send();
      return cnt;
   }
   
   @Override
   public int writeArticle(MemberDto memberDto) {
      return sqlSession.getMapper(MemberDao.class).writeArticle(memberDto);
   }

   @Override
   public List<MemberDto> selectMember() {
      return null;
   }
   @Override
   public int updateMember(MemberDto memberDto) {   
           System.out.println(memberDto.getId());
     return sqlSession.getMapper(MemberDao.class).updateMember(memberDto);   
   }

   @Override
   @Transactional
   public void deleteMember(String id) {
     MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
     System.out.println("삭제할아이디" + id);
     memberDao.deleteReply(id);
     memberDao.deletePin(id);
     memberDao.deletePost(id);
     memberDao.deleteWantbook(id);
     memberDao.deleteReadbook(id);
     memberDao.deleteFollow(id);
     memberDao.deleteMember(id);
   }

   @Override
   public MemberDto getMember(String id) {
      return sqlSession.getMapper(MemberDao.class).getMember(id);
   }

   @Override
   public int idCheck(String id) {
      return sqlSession.getMapper(MemberDao.class).idCheck(id);
   }

   @Override
   public MemberDto login(Map<String, String> map) {
      
      return sqlSession.getMapper(MemberDao.class).login(map);
   }

   @Override
   public void userAuth(String email) throws Exception {
      String key = new TempKey().getKey(50, false);
      sqlSession.getMapper(MemberDao.class).createAuthKey(email, key); // 인증키 DB저장
   }

   @Override
   public int insertApi(String id){
       int cnt = sqlSession.getMapper(MemberDao.class).insertApi(id);
      return cnt;
   }

   
}