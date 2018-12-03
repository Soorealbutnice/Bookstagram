package com.dnb.post.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.post.model.HashtagDto;

@Service
public class HashtagServiceImpl implements HashtagService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public HashtagDto selectHashtag() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int updateHahtag(int hashtag_no) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteHashtag(int hashtag_no) {
		// TODO Auto-generated method stub
		return 0;
	}

}
