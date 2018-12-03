package com.dnb.member.service;

import java.util.List;

import com.dnb.member.model.BookinfoDto;
import com.dnb.member.model.ReadBookDto;

public interface ReadBookService {
	
	int insertReadBook(ReadBookDto readBookDto);
	String listReadBook(ReadBookDto readBookDto);
	int deleteReadBook(int rbook_no);
	ReadBookDto getReadBook(ReadBookDto readBookDto);
	List<ReadBookDto> myReadBookList(String id);
	List<String> readBookCheck (String id);
}
