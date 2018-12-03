package com.dnb.member.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.member.dao.ReadBookDao;
import com.dnb.member.dao.WantBookDao;
import com.dnb.member.model.ReadBookDto;
import com.dnb.member.model.WantBookDto;

@Service
public class ReadBookServiceImpl implements ReadBookService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insertReadBook(ReadBookDto readBookDto) {
		return sqlSession.getMapper(ReadBookDao.class).insertReadBook(readBookDto);
	}

	@Override
	public String listReadBook(ReadBookDto readBookDto) {
		List<ReadBookDto> readBookList = sqlSession.getMapper(ReadBookDao.class).listReadBook(readBookDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(ReadBookDto readBookDTO : readBookList) {
			JSONObject readBook = new JSONObject();
			readBook.put("rbook_no", readBookDTO.getRbook_no());
			readBook.put("rbook_author", readBookDTO.getRbook_author());
			readBook.put("rbook_pic", readBookDTO.getRbook_pic());
			readBook.put("risbn", readBookDTO.getRisbn());
			readBook.put("rbook_desc", readBookDTO.getRbook_desc());
			readBook.put("rbook_title", readBookDTO.getRbook_title());

			jarray.put(readBook);
		}
		json.put("readBookList", jarray);
		
		return json.toString();
	}

	@Override
	public int deleteReadBook(int rbook_no) {
		return sqlSession.getMapper(ReadBookDao.class).deleteReadBook(rbook_no);
		
	}

	@Override
	public ReadBookDto getReadBook(ReadBookDto readBookDto) {
		return sqlSession.getMapper(ReadBookDao.class).getReadBook(readBookDto);
	}

	@Override
	public List<ReadBookDto> myReadBookList(String id) {
		return sqlSession.getMapper(ReadBookDao.class).myReadBookList(id);
	}

	@Override
	public List<String> readBookCheck(String id) {
		return sqlSession.getMapper(ReadBookDao.class).readBookCheck(id);
	}
	
	

}
