package com.dnb.post.dao;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.PinDto;

public interface PinDao {
	
	int insertPin(PinDto pinDto);
	List<PinDto> selectPin(String id);
	int deletePin(PinDto pinDto);
	PinDto getMyPin(PinDto pinDto);
	List<Integer> pinCheck (String id);
}
