package com.dnb.member.control;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dnb.member.model.MemberDto;
import com.dnb.member.model.SupportDto;
import com.dnb.member.service.SupportService;

@Controller
@RequestMapping("/support")
public class SupportControl {
	
	@Autowired
	private SupportService supportService;
	
	@RequestMapping(value="/insertSupport.dnb", method=RequestMethod.GET)		
	public @ResponseBody void insertSupport(@RequestParam("pay") int pay, @RequestParam("supported_id") String supported_id, HttpSession session) {
		SupportDto supportDto = new SupportDto();
		MemberDto memberDto = (MemberDto)session.getAttribute("userInfo");
		String id = memberDto.getId();
		supportDto.setPay(pay);
		supportDto.setSupported_id(supported_id);
		supportDto.setSupporter(id);
		
		System.out.println("입력할 값은 넘어오지? ====================");
		System.out.println(pay);
		System.out.println(supported_id);
		
		int result = supportService.insertSupport(supportDto);
		System.out.println("support insert result = " + result);
	
	}

}
