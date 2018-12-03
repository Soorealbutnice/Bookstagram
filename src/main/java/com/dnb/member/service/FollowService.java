package com.dnb.member.service;

import java.util.List;

import com.dnb.member.model.FollowDto;

public interface FollowService {
	
	int insertFollow(FollowDto followDto);
	List<FollowDto> selectFollow(String followed_id);
	int deleteFollow (int follow_no);
	List<FollowDto> meFollowList(String followed_id);
	String myFollowList(FollowDto followDto);
	FollowDto getFollower(FollowDto followDto);
	List<String> followerCheck (String id);
}
