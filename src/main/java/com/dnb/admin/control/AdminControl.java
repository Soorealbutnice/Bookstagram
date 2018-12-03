package com.dnb.admin.control;


import java.util.List;
import java.util.Map;


import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dnb.admin.service.AdminService;
import com.dnb.member.model.MemberDto;




@Controller
@RequestMapping("/admin")
public class AdminControl {
   
   @Autowired
   private AdminService adminService;
   
   @RequestMapping("/login.dnb")
   public String start() {         
      return "admin/tables";
   }
   @RequestMapping("/member.dnb")
   public String member() {         

      return "admin/tables";
   }
   @RequestMapping("/memberlist.dnb")
   public @ResponseBody String memberList(@RequestParam Map<String, String> map) {
      //여기서 map.put으로 하면은 이렇게 맵만 넣어놓으면 모델이지 파라미터를 받는 map이 될순업쇼음 그래서 너는 모델이아니고 파라미터를받는거다라는걸 알려주는데 requestParam
      System.out.println(map.get("key"));
      List<MemberDto> list = adminService.memberList(map);
      JSONObject memberlist =new JSONObject(); 
      JSONArray jarray =new JSONArray();
      for(MemberDto memberDto : list) {
         //밖에 만들면 하나만갖고 참조하는건;ㄲ ㅏ member는 안에다가 해줘야함
         JSONObject member =new JSONObject();//이거 구조이해불가능
         member.put("id", memberDto.getId());
         member.put("name", memberDto.getName());
         member.put("email", memberDto.getEmail1() + "@" + memberDto.getEmail2());
         member.put("nickname", memberDto.getNickname());
         member.put("joindate", memberDto.getJoindate());
         
         jarray.put(member);
         //딱보니까 jsonobject의 내부는 map을쓴거임 map이랑 똑같이코딩하니까, map이니까 순서유지는 안하고 들어가있는것만 확인하면됨
      }
      memberlist.put("mlist", jarray);
      System.out.println(memberlist.toString());
      return memberlist.toString();
      //이제 리스트안에있는걸 가지고 jsonObject를 만들어줘야함
      //근데 MemberDetailDto는 리스트의 배열인데 json을 만들때 객체를 만들어서 보내줌 형식은 속성,값,,,
   }
   
   @RequestMapping("/chart.dnb")
   public String chart() {         
      System.out.println("차트컨트롤러왔다");
      return "admin/tables";
   }

}