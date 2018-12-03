package com.dnb.member.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.member.dao.FollowDao;
import com.dnb.member.dao.WantBookDao;
import com.dnb.member.model.FollowDto;
import com.dnb.member.model.WantBookDto;

@Service
public class WantBookServiceImpl implements WantBookService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertWantBook(WantBookDto wantBookDto) {
		return sqlSession.getMapper(WantBookDao.class).insertWantBook(wantBookDto);
	}

	@Override
	public String listWantBook(WantBookDto wantBookDto) {
		List<WantBookDto> wantBookList = sqlSession.getMapper(WantBookDao.class).listWantBook(wantBookDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(WantBookDto wantBookDTO : wantBookList) {
			JSONObject wantBook = new JSONObject();
			wantBook.put("wbook_no", wantBookDTO.getWbook_no());
			wantBook.put("wbook_author", wantBookDTO.getWbook_author());
			wantBook.put("wbook_pic", wantBookDTO.getWbook_pic());
			wantBook.put("wisbn", wantBookDTO.getWisbn());
			wantBook.put("wbook_desc", wantBookDTO.getWbook_desc());
			wantBook.put("wbook_title", wantBookDTO.getWbook_title());

			jarray.put(wantBook);
		}
		json.put("wantBookList", jarray);
		
		return json.toString();
	}

	@Override
	public int deleteWantBook(int wbook_no) {
		return sqlSession.getMapper(WantBookDao.class).deleteWantBook(wbook_no);
	}

	@Override
	public WantBookDto getWantBook(WantBookDto wantBookDto) {
		return sqlSession.getMapper(WantBookDao.class).getWantBook(wantBookDto);
	}

	@Override
	public List<WantBookDto> myWantBook(String id) {
		return sqlSession.getMapper(WantBookDao.class).myWantBook(id);
	}

	@Override
	public List<String> wantBookCheck(String id) {
		return sqlSession.getMapper(WantBookDao.class).wantBookCheck(id);
	}
	
	
}
