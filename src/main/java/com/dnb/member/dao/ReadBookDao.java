package com.dnb.member.dao;

import java.util.List;
import com.dnb.member.model.ReadBookDto;

public interface ReadBookDao {
	
	int insertReadBook(ReadBookDto readBookDto);
	List<ReadBookDto> listReadBook(ReadBookDto readBookDto);
	int deleteReadBook(int rbook_no);
	ReadBookDto getReadBook(ReadBookDto readBookDto);
	List<ReadBookDto> myReadBookList(String id);
	List<String> readBookCheck(String id);
}
