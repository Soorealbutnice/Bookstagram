package com.dnb.admin.service;

import java.util.List;
import java.util.Map;

import com.dnb.member.model.MemberDto;


public interface AdminService {
   List<MemberDto> memberList(Map<String, String> map);

}