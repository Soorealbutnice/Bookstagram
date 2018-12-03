package com.dnb.member.service;

import java.util.List;

import com.dnb.member.model.SupportDto;

public interface SupportService {
	
	int insertSupport (SupportDto supportDto);
	String selectSupport(SupportDto supportDto);
	String mySupportList(SupportDto supportDto);

}
