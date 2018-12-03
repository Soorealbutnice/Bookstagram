package com.dnb.member.dao;

import java.util.List;

import com.dnb.member.model.FollowDto;

public interface FollowDao {
	
	int insertFollow(FollowDto followDto);
	List<FollowDto> selectFollow(String id);
	int deleteFollow (int follow_no);
	List<FollowDto> meFollowList(String id);
	List<FollowDto> myFollowList(FollowDto followDto);
	FollowDto getFollower(FollowDto followDto);
	List<String> followerCheck (String id);

}
