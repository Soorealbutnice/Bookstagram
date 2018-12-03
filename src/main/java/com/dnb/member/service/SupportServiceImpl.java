package com.dnb.member.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.member.dao.FollowDao;
import com.dnb.member.dao.SupportDao;
import com.dnb.member.model.FollowDto;
import com.dnb.member.model.SupportDto;

@Service
public class SupportServiceImpl implements SupportService {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertSupport(SupportDto supportDto) {
		return sqlSession.getMapper(SupportDao.class).insertSupport(supportDto);
	}

	@Override
	public String selectSupport(SupportDto supportDto) {
		List<SupportDto> isupportList = sqlSession.getMapper(SupportDao.class).selectSupport(supportDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(SupportDto supportDTO : isupportList) {
			JSONObject support = new JSONObject();
			support.put("support_no", supportDTO.getSupport_no());
			support.put("pay", supportDTO.getPay());
			support.put("nickname", supportDTO.getNickname());
			support.put("supporter", supportDTO.getSupporter());
			support.put("support_date", supportDTO.getSupport_date());
			support.put("introduce", supportDTO.getIntroduce());
			support.put("origin_proPicture", supportDTO.getOrigin_proPicture());
			support.put("save_proPicture", supportDTO.getSave_proPicture());
			support.put("saveFolder", supportDTO.getSaveFolder());
			support.put("supported_id", supportDTO.getSupported_id());
			jarray.put(support);
		}
		json.put("isupportList", jarray);
		
		return json.toString();
	}

	@Override
	public String mySupportList(SupportDto supportDto) {
		List<SupportDto> msupportList = sqlSession.getMapper(SupportDao.class).mySupportList(supportDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(SupportDto supportDTO : msupportList) {
			JSONObject support = new JSONObject();
			support.put("support_no", supportDTO.getSupport_no());
			support.put("pay", supportDTO.getPay());
			support.put("nickname", supportDTO.getNickname());
			support.put("supporter", supportDTO.getSupporter());
			support.put("support_date", supportDTO.getSupport_date());
			support.put("introduce", supportDTO.getIntroduce());
			support.put("origin_proPicture", supportDTO.getOrigin_proPicture());
			support.put("save_proPicture", supportDTO.getSave_proPicture());
			support.put("saveFolder", supportDTO.getSaveFolder());
			
			jarray.put(support);
		}
		json.put("msupportList", jarray);
		
		return json.toString();
	}

}
