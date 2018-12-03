package com.dnb.post.service;

import java.util.List;
import java.util.Map;

import com.dnb.post.model.PinDto;

public interface PinService {
	
	int insertPin(PinDto pinDto);
	List<PinDto> selectPin(String id);
	int deletePin(PinDto pinDto);
	PinDto getMyPin(PinDto pinDto);
	List<Integer> pinCheck (String id);

}
