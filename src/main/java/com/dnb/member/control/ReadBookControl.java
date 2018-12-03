package com.dnb.member.control;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dnb.member.model.MemberDto;
import com.dnb.member.model.ReadBookDto;
import com.dnb.member.service.ReadBookService;

@Controller
@RequestMapping("/read")
public class ReadBookControl {
	
	@Autowired
	private ReadBookService readBookService;
	
	@RequestMapping("/readBookCome.dnb")
	public String readBookCome() {
		return "/book/readbook";
	}

	@RequestMapping("/listReadBook.dnb")
	public @ResponseBody String listReadBook(@RequestParam("rbook_no") int rbook_no, HttpSession session) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		ReadBookDto readBookDto = new ReadBookDto();
		readBookDto.setId(id);
		readBookDto.setRbook_no(rbook_no);
		String readBookList = readBookService.listReadBook(readBookDto);
		return readBookList;
	}
	
	@RequestMapping(value="insertReadBook.dnb", method=RequestMethod.GET)
	public void insertReadBook(@RequestParam("isbn") String isbn, @RequestParam("description") String description,  
			@RequestParam("title") String title,@RequestParam("author") String author,@RequestParam("image") String image, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		ReadBookDto readBookDto = new ReadBookDto();
		readBookDto.setRisbn(isbn);
		readBookDto.setId(id);
		if(readBookService.getReadBook(readBookDto) == null) {
			readBookDto.setId(id);
			readBookDto.setRbook_title(title);
			readBookDto.setRisbn(isbn);
			readBookDto.setRbook_pic(image);
			readBookDto.setRbook_desc(description);
			readBookDto.setRbook_author(author);
			int rbook_no = readBookService.insertReadBook(readBookDto);
		} 
	}

	@RequestMapping(value="cancelReadBook.dnb", method = RequestMethod.GET)
	public void deleteReadBook(@RequestParam("isbn") String isbn, HttpSession session) {
		ReadBookDto readBookDto = new ReadBookDto();
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		readBookDto.setRisbn(isbn);
		readBookDto.setId(memberDto.getId());
		readBookDto = readBookService.getReadBook(readBookDto);
		int cnt = readBookService.deleteReadBook(readBookDto.getRbook_no());
	}
}
