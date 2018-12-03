package com.dnb.member.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dnb.member.model.BookinfoDto;
import com.dnb.member.model.MemberDto;
import com.dnb.member.model.ReadBookDto;
import com.dnb.member.model.WantBookDto;
import com.dnb.member.service.WantBookService;

@Controller
@RequestMapping("/want")
public class WantBookControl {
	
	@Autowired
	private WantBookService wantBookService;

	@RequestMapping("/wantBookCome.dnb")
	public String wantBookCome() {
		return "/book/wantbook";
	}
	
	
	@RequestMapping("/listWantBook.dnb")
	public @ResponseBody String listWantBook(@RequestParam("wbook_no") int wbook_no, HttpSession session) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		
		WantBookDto wantBookDto = new WantBookDto();
		wantBookDto.setId(id);
		wantBookDto.setWbook_no(wbook_no);
		String wantBookList = wantBookService.listWantBook(wantBookDto);
		return wantBookList;
	}
	
	@RequestMapping(value="insertWantBook.dnb", method=RequestMethod.GET)
	public void insertWantBook(@RequestParam("isbn") String isbn, @RequestParam("description") String description,  
			@RequestParam("title") String title,@RequestParam("author") String author,@RequestParam("image") String image, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		WantBookDto wantBookDto = new WantBookDto();
		wantBookDto.setWisbn(isbn);
		wantBookDto.setId(id);

		if(wantBookService.getWantBook(wantBookDto) == null) {
			wantBookDto.setWbook_title(title);
			wantBookDto.setWisbn(isbn);
			wantBookDto.setWbook_pic(image);
			wantBookDto.setWbook_desc(description);
			wantBookDto.setWbook_author(author);
			wantBookDto.setId(id);

			int wbook_no = wantBookService.insertWantBook(wantBookDto);
			System.out.println("인서트 결과 : " + wbook_no);
		} else {
			System.out.println("이미 체크한 책입니다");
		}
		

	}
	
	@RequestMapping(value="cancelWantBook.dnb", method = RequestMethod.GET)
	public void deleteWantBook(@RequestParam("isbn") String isbn, HttpSession session) {
		System.out.println("cancelWantbook");
		WantBookDto wantBookDto = new WantBookDto();
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		wantBookDto.setWisbn(isbn);
		wantBookDto.setId(id);
		WantBookDto wantBookDTO = wantBookService.getWantBook(wantBookDto);
			if(wantBookDTO != null) {
				int cnt = wantBookService.deleteWantBook(wantBookDTO.getWbook_no());
			}
	}
	
}
