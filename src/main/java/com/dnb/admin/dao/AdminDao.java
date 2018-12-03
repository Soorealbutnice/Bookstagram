package com.dnb.admin.dao;

import java.util.List;
import java.util.Map;

import com.dnb.member.model.MemberDto;

public interface AdminDao {
   List<MemberDto> memberList(Map<String, String> map);

}