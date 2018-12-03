package com.dnb.member.service;

import java.util.HashMap;
import java.util.List;

import com.dnb.member.model.WantBookDto;

public interface WantBookService {
	
	int insertWantBook (WantBookDto wantBookDto);
	String listWantBook(WantBookDto wantBookDto);
	int deleteWantBook (int wbook_no);
	WantBookDto getWantBook(WantBookDto wantBookDto);
	List<WantBookDto> myWantBook(String id);
	List<String> wantBookCheck (String id);
}
