package com.dnb.member.dao;

import java.util.List;

import com.dnb.member.model.SupportDto;

public interface SupportDao {
	
	int insertSupport (SupportDto supportDto);
	List<SupportDto> selectSupport(SupportDto supportDto);
	List<SupportDto> mySupportList(SupportDto supportDto);

}
