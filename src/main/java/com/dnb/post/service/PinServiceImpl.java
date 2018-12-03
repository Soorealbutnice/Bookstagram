package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.post.dao.PinDao;
import com.dnb.post.model.PinDto;

@Service
public class PinServiceImpl implements PinService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertPin(PinDto pinDto) {
		return sqlSession.getMapper(PinDao.class).insertPin(pinDto);
	}

	@Override
	public List<PinDto> selectPin(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int deletePin(PinDto pinDto) {
		return sqlSession.getMapper(PinDao.class).deletePin(pinDto);
	}

	@Override
	public PinDto getMyPin(PinDto pinDto) {
		return sqlSession.getMapper(PinDao.class).getMyPin(pinDto);
	}

	@Override
	public List<Integer> pinCheck(String id) {
		return sqlSession.getMapper(PinDao.class).pinCheck(id);
	}
	
}
