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
      //���⼭ map.put���� �ϸ��� �̷��� �ʸ� �־������ ������ �Ķ���͸� �޴� map�� �ɼ������� �׷��� �ʴ� ���̾ƴϰ� �Ķ���͸��޴°Ŵٶ�°� �˷��ִµ� requestParam
      System.out.println(map.get("key"));
      List<MemberDto> list = adminService.memberList(map);
      JSONObject memberlist =new JSONObject(); 
      JSONArray jarray =new JSONArray();
      for(MemberDto memberDto : list) {
         //�ۿ� ����� �ϳ������� �����ϴ°�;�� �� member�� �ȿ��ٰ� �������
         JSONObject member =new JSONObject();//�̰� �������غҰ���
         member.put("id", memberDto.getId());
         member.put("name", memberDto.getName());
         member.put("email", memberDto.getEmail1() + "@" + memberDto.getEmail2());
         member.put("nickname", memberDto.getNickname());
         member.put("joindate", memberDto.getJoindate());
         
         jarray.put(member);
         //�����ϱ� jsonobject�� ���δ� map�������� map�̶� �Ȱ����ڵ��ϴϱ�, map�̴ϱ� ���������� ���ϰ� ���ִ°͸� Ȯ���ϸ��
      }
      memberlist.put("mlist", jarray);
      System.out.println(memberlist.toString());
      return memberlist.toString();
      //���� ����Ʈ�ȿ��ִ°� ������ jsonObject�� ����������
      //�ٵ� MemberDetailDto�� ����Ʈ�� �迭�ε� json�� ���鶧 ��ü�� ���� ������ ������ �Ӽ�,��,,,
   }
   
   @RequestMapping("/chart.dnb")
   public String chart() {         
      System.out.println("��Ʈ��Ʈ�ѷ��Դ�");
      return "admin/tables";
   }

}