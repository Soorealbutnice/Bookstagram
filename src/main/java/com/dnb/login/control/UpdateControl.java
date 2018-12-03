package com.dnb.login.control;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.dnb.member.model.MemberDto;
import com.dnb.member.service.MemberService;

@Controller
@RequestMapping("/myup")
public class UpdateControl {

   @Autowired
   private MemberService memberService;
   @Autowired
   ServletContext servletContext;

   @RequestMapping(value = "/update.dnb", method = RequestMethod.GET)
   public String update() {
      return "mypage/update";

   }
   @RequestMapping(value = "/update.dnb", method = RequestMethod.POST)
   public String  update(@ModelAttribute MemberDto memberDto, HttpSession session, @RequestParam("picture") MultipartFile multipartFile) {

              MemberDto memberDTO = new MemberDto();
              
            if (multipartFile != null && !multipartFile.isEmpty()) {
               String origin_proPicture = multipartFile.getOriginalFilename();
               String realPath = servletContext.getRealPath("/upload/profile");

               DateFormat df = new SimpleDateFormat("yyMMdd");
               String psavefolder = df.format(new Date());// 180725
               String realSaveFolder = realPath + File.separator + psavefolder;
               File dir = new File(realSaveFolder);

               if (!dir.exists()) {
                  dir.mkdirs();
               }

               String save_proPicture = UUID.randomUUID().toString()
                     + origin_proPicture.substring(origin_proPicture.lastIndexOf('.'));

               File file = new File(realSaveFolder, save_proPicture);
               try {
                  multipartFile.transferTo(file);
               } catch (IllegalStateException e) {
                  e.printStackTrace();
               } catch (IOException e) {
                  e.printStackTrace();
               }

               memberDTO.setOrigin_proPicture(origin_proPicture);
               memberDTO.setSave_proPicture(save_proPicture);
               memberDTO.setSaveFolder(psavefolder);

               
            } else {
              memberDTO.setOrigin_proPicture("nopic");
              memberDTO.setSave_proPicture("nopic");
              memberDTO.setSaveFolder("nopic");

            }
            MemberDto userdto = (MemberDto)session.getAttribute("userInfo");
            
            memberDTO.setName(memberDto.getName());
            memberDTO.setIntroduce(memberDto.getIntroduce());
            memberDTO.setNickname(memberDto.getNickname());
            memberDTO.setPass(memberDto.getPass());
            memberDTO.setEmail2(memberDto.getEmail2());
            memberDTO.setEmail1(memberDto.getEmail1());
            memberDTO.setId(userdto.getId());
            
            int cnt = memberService.updateMember(memberDTO);
            MemberDto updatedDto = (MemberDto)memberService.getMember(memberDto.getId());
            session.setAttribute("userInfo", updatedDto);
            
            return "mypage/update";
   }//마이페이지 회원정보 수정
   
   
   @RequestMapping(value = "/delete.dnb", method = RequestMethod.POST)
   public String delete(@ModelAttribute MemberDto memberDto, HttpSession session){
      memberService.deleteMember(memberDto.getId());
      return "redirect:/login/login.dnb";
   }//마이페이지 회원정보 탈퇴
   
   @RequestMapping(value = "/admindelete.dnb", method = {RequestMethod.POST,RequestMethod.GET})
   public ModelAndView admindelete(@ModelAttribute MemberDto memberDto, HttpSession session){
         ModelAndView mav = new ModelAndView();     
         memberService.deleteMember(memberDto.getId());
         mav.setViewName("admin/tables");
         return mav;
      }//admin회원정보 삭제

}