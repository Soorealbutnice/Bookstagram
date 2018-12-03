package com.dnb.member.dao;

import java.util.HashMap;
import java.util.List;

import com.dnb.member.model.WantBookDto;

public interface WantBookDao {
	
	int insertWantBook (WantBookDto wantBookDto);
	List<WantBookDto> listWantBook(WantBookDto wantBookDto);
	int deleteWantBook (int wbook_no);
	WantBookDto getWantBook (WantBookDto wantBookDto);
	List<WantBookDto> myWantBook(String id);
	List<String> wantBookCheck(String id);
}
