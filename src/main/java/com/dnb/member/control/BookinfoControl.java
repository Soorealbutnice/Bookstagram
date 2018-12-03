package com.dnb.member.control;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ViewNameMethodReturnValueHandler;

import com.dnb.member.model.BookinfoDto;
import com.dnb.member.model.MemberDto;
import com.dnb.member.service.BookinfoService;
import com.dnb.member.service.ReadBookService;
import com.dnb.member.service.WantBookService;

@Controller
@RequestMapping("/info")
public class BookinfoControl {

   @Autowired
   private BookinfoService bookinfoService;
   
   @Autowired
   private WantBookService wantBookService;
   
   @Autowired
   private ReadBookService readBookService;
   
   @RequestMapping(value="/info.dnb", method=RequestMethod.POST)
   public String bookinfo(@RequestParam("description") String description, @RequestParam("title") String title, @RequestParam("image") String image, @RequestParam("author") String author, @RequestParam("publisher") String publisher, @RequestParam("pubdate") String pubdate, @RequestParam("isbn") String isbn, HttpSession session, Model model) {
	  BookinfoDto dto = new BookinfoDto();
      dto.setIsbn(isbn);
      dto.setTitle(title);
      dto.setAuthor(author);
      dto.setPubdate(pubdate);
      dto.setImage(image);
      dto.setDescription(description);
      dto.setPublisher(publisher);
      
      model.addAttribute("book", dto);
      MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
      String id = memberDto.getId();
      
	  List<String> wantBookList = wantBookService.wantBookCheck(id);
	  String wantBookListString = "";
	  for (String s : wantBookList)
	  {
		  wantBookListString += s + "\t";
	  }
	  
	  List<String> readBookList = readBookService.readBookCheck(id);
	  String readBookListString = "";
	  for (String s : readBookList)
	  {
		  readBookListString += s + "\t";
	  }
      
	  session.setAttribute("wblist", wantBookListString);
	  session.setAttribute("rblist", readBookListString);
      
      return "book/bookinfo";
   }

   @RequestMapping(value="/search.dnb", method=RequestMethod.GET)
   public @ResponseBody String search(@RequestParam("word") String word) {
      String booklist = bookinfoService.bookinfo(word);
      return booklist;
   }
   
   @RequestMapping(value="/searchbook.dnb", method=RequestMethod.GET)
   public ModelAndView searchbook(@RequestParam("word") String word, HttpSession session) throws UnsupportedEncodingException {
	  ModelAndView mav = new ModelAndView();
      mav.addObject("word", word);
      mav.setViewName("book/searchbook");
      
      MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
      String id = memberDto.getId();
	  List<String> wantBookList = wantBookService.wantBookCheck(id);
	  String wantBookListString = "";
	  for (String s : wantBookList)
	  {
		  wantBookListString += s + "\t";
	  }
	  
	  List<String> readBookList = readBookService.readBookCheck(id);
	  String readBookListString = "";
	  for (String s : readBookList)
	  {
		  readBookListString += s + "\t";
	  }
      
	  session.setAttribute("wblist", wantBookListString );
	  session.setAttribute("rblist", readBookListString );
	  
      return mav;
   }
   
   @RequestMapping(value="/searchreview.dnb", method=RequestMethod.GET)
   public @ResponseBody String searchreview(@RequestParam("isbn") String isbn, HttpSession session) {
      String reviewlist = bookinfoService.reviewinfo(isbn);
      MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
      String id = memberDto.getId();
      
	  List<String> wantBookList = wantBookService.wantBookCheck(id);
	  String wantBookListString = "";
	  for (String s : wantBookList)
	  {
		  wantBookListString += s + "\t";
	  }
	  
	  List<String> readBookList = readBookService.readBookCheck(id);
	  String readBookListString = "";
	  for (String s : readBookList)
	  {
		  readBookListString += s + "\t";
	  }
      
	  session.setAttribute("wblist", wantBookListString );
	  session.setAttribute("rblist", readBookListString );
      
      return reviewlist;
   }
   
}