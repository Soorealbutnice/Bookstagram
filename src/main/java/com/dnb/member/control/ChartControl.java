package com.dnb.member.control;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dnb.member.model.MemberDto;
import com.dnb.member.service.ChartService;

@Controller
@RequestMapping("/chart")
public class ChartControl {

   @Autowired
   private ChartService chartService;
   
   @RequestMapping("/readbook.dnb")
   public ModelAndView readbook(MemberDto memberDto, HttpSession session) {
      memberDto = (MemberDto)session.getAttribute("userInfo");
      String id = memberDto.getId();
   
      HashMap<String, Integer> avgreadbook = chartService.avgreadbook(id);
      HashMap<String, Integer> myreadbook = chartService.myreadbook(id);
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("avgreadbook", avgreadbook);
      mav.addObject("myreadbook", myreadbook);
      mav.setViewName("chart/proChart");
      return mav;
   }

   @RequestMapping("/writereview.dnb")
   public ModelAndView writereview(MemberDto memberDto, HttpSession session) {
     memberDto = (MemberDto)session.getAttribute("userInfo");
     String id = memberDto.getId();
     
      HashMap<String, Integer> writereview = chartService.listwritereview(id);
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("writereview", writereview);
      mav.setViewName("chart/writeChart");
      return mav;
   }
   
   @RequestMapping("/listreadbook.dnb")
   public ModelAndView listreadbook(MemberDto memberDto, HttpSession session) {
      memberDto = (MemberDto)session.getAttribute("userInfo");
      String id = memberDto.getId();

      HashMap<String, Integer> listreadbook = chartService.listreadbook(id);
      HashMap<String, Integer> listavgbook = chartService.listavgbook(id);
      
      ModelAndView mav = new ModelAndView();
      mav.addObject("listreadbook", listreadbook);
      mav.addObject("listavgbook", listavgbook);
      mav.setViewName("chart/readChart");
      return mav;
   }
   
   
   
}