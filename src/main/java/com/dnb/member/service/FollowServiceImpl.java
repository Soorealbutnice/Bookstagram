package com.dnb.member.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnb.member.dao.FollowDao;
import com.dnb.member.model.FollowDto;
import com.dnb.post.dao.PostDao;
import com.dnb.post.model.PostDto;

@Service
public class FollowServiceImpl implements FollowService {
	@Autowired
	SqlSession sqlSession;

	@Override
	public int insertFollow(FollowDto followDto) {
		return sqlSession.getMapper(FollowDao.class).insertFollow(followDto);
	}

	@Override
	public List<FollowDto> selectFollow(String followed_id) {
		return sqlSession.getMapper(FollowDao.class).selectFollow(followed_id);
	}

	@Override
	public int deleteFollow(int follow_no) {
		return sqlSession.getMapper(FollowDao.class).deleteFollow(follow_no);
	}

	@Override
	public List<FollowDto> meFollowList(String followed_id) {
		return sqlSession.getMapper(FollowDao.class).meFollowList(followed_id);
	}

	@Override
	public String myFollowList(FollowDto followDto) {
		List<FollowDto> followList = sqlSession.getMapper(FollowDao.class).myFollowList(followDto);
		JSONObject json = new JSONObject();
		JSONArray jarray = new JSONArray();
		for(FollowDto followDTO : followList) {
			JSONObject follow = new JSONObject();
			follow.put("follow_no", followDTO.getFollow_no());
			follow.put("follower_id", followDTO.getFollower_id());
			follow.put("id", followDTO.getFollowed_id());
			follow.put("introduce", followDTO.getIntroduce());
			follow.put("nickname", followDTO.getNickname());
			follow.put("origin_proPicture", followDTO.getOrigin_proPicture());
			follow.put("save_proPicture", followDTO.getSave_proPicture());
			follow.put("saveFolder", followDTO.getSaveFolder());
			follow.put("followed_id", followDTO.getFollowed_id());

			jarray.put(follow);
		}
		json.put("followList", jarray);
		
		return json.toString();
	}

	@Override
	public FollowDto getFollower(FollowDto followDto) {
		return sqlSession.getMapper(FollowDao.class).getFollower(followDto);
	}

	@Override
	public List<String> followerCheck(String id) {
		return sqlSession.getMapper(FollowDao.class).followerCheck(id);
	}

}
