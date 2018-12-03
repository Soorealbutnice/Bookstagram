package com.dnb.login.control;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.dnb.member.model.MemberDto;
import com.dnb.member.service.MemberService;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/login")
public class MemberControl {

   @Autowired
   private MemberService memberService;

   @Autowired
   ServletContext servletContext;

   @RequestMapping(value = "/logout.dnb", method = RequestMethod.GET)
   public ModelAndView logout(HttpSession session) {
     session.invalidate();
      ModelAndView mav = new ModelAndView();
      mav.setView(new RedirectView("login.dnb"));
      return mav;
   }//로그아웃
   
   @RequestMapping(value = "/idcheck.dnb", headers = { "Content-type=application/json" })
   public @ResponseBody String idCheck(@RequestParam("id") String id) {
      int cnt = memberService.idCheck(id);
      JSONObject json = new JSONObject();
      json.put("idcount", cnt);

      return json.toString();
   }//아이디확인

   @RequestMapping(value = "/register.dnb", method = RequestMethod.GET)
   public String register() {
      return "login/register";
      //회원가입 화면
   }

   @RequestMapping(value = "/register.dnb", method = RequestMethod.POST)
   public ModelAndView register(MemberDto memberDto) throws Exception {
      ModelAndView mav = new ModelAndView();
      int cnt = memberService.insertMember(memberDto);
      if (cnt != 0) {
         mav.addObject("userInfo", memberDto);
         mav.setViewName("login/registerok");
      } else {
         mav.setViewName("login/registerfail");
      }
      return mav;
   }//회원가입

   @RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
   public ModelAndView emailConfirm(String user_email,String email1, String key, Model model, HttpSession session) throws Exception { // 이메일인증
      String email = email1;
      String userEmail = user_email;
      ModelAndView mav = new ModelAndView();
      memberService.userAuth(email);
      mav.setViewName("/login/loginmailok");

      String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

      model.addAttribute("url", naverAuthUrl);

      OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
      String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

      model.addAttribute("google_url", url);
      return mav;
   }//이메일 인증완료

   @RequestMapping(value = "/login.dnb", method = RequestMethod.GET)
   public String login(Model model, HttpSession session) {

      String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

      model.addAttribute("url", naverAuthUrl);

      OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
      String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

      model.addAttribute("google_url", url);

      return "login/login";
   }//로그인 화면

   @RequestMapping(value = "/login.dnb", method = RequestMethod.POST)
   public String login(@RequestParam Map<String, String> map, HttpSession session) {

      MemberDto memberDto = memberService.login(map);
      if (memberDto != null) {
      memberDto = memberService.getMember(memberDto.getId());
      session.setAttribute("userInfo", memberDto);
      
         if (memberDto.getUser_authCode() != null) {
            if (memberDto.getNickname() == null) {
               return "login/registerProfile";
            } else {
               return "commons/AllListMain";
            }
         } else {
            return "login/registerok";
         }
      }
      return "login/loginfail";
   }//로그인 유효성 검사
   

   @RequestMapping(value = "/write.dnb", method = RequestMethod.GET)
   public String write() {
      return "login/registerProfile";
   }//프로필설정 화면

   @RequestMapping(value = "/write.dnb", method = RequestMethod.POST)
   public String write(MemberDto memberDto, @RequestParam("picture") MultipartFile multipartFile, HttpSession session,
         Model model) {

      if (memberDto != null) {
         MemberDto memberDto2 = (MemberDto) session.getAttribute("userInfo");
         String id = memberDto2.getId();
         memberDto.setId(id);
         memberDto.setName(memberDto.getName());
         memberDto.setEmail1(memberDto.getEmail1() + "@" + memberDto.getEmail2());

         if (multipartFile != null && !multipartFile.isEmpty()) {
            String originalPicture = multipartFile.getOriginalFilename();
            String realPath = servletContext.getRealPath("/upload/profile");
            
            DateFormat df = new SimpleDateFormat("yyMMdd");
            String saveFolder = df.format(new Date());
            String realSaveFolder = realPath + File.separator + saveFolder;// 실제파일의 경로

            File dir = new File(realSaveFolder);
            if (!dir.exists()) {
               dir.mkdirs();// 이폴더가 없다면 디렉토리를 만들어라
            }
            String savePicture = UUID.randomUUID().toString()
                  + originalPicture.substring(originalPicture.lastIndexOf('.'));//유일한 id값

            File file = new File(realSaveFolder, savePicture);
            try {
               multipartFile.transferTo(file);
            } catch (IllegalStateException e) {
               e.printStackTrace();
            } catch (IOException e) {
               e.printStackTrace();
            }

            memberDto.setSaveFolder(saveFolder);
            memberDto.setOrigin_proPicture(originalPicture);
            memberDto.setSave_proPicture(savePicture);

         }
         memberService.writeArticle(memberDto);
         session.setAttribute("userInfo", memberDto);

      }
      return "commons/AllListMain";
   }//프로필설정


   @RequestMapping(value = "/writeApi.dnb", method = RequestMethod.GET)
   public String writeApi() {
      return "login/registerProfile2";
   }//API프로필설정

   @RequestMapping(value = "/writeApi.dnb", method = RequestMethod.POST)
   public String writeApi(MemberDto memberDto, @RequestParam("picture") MultipartFile multipartFile, HttpSession session,
         Model model) {
      MemberDto memberDto2= (MemberDto) session.getAttribute("userInfo");
      memberDto.setId(memberDto2.getId());
      if (memberDto != null) {
         String id = memberDto.getId();
         String nickname = memberDto.getNickname();

         memberDto.setId(id);
         memberDto.setName(memberDto.getName());
         memberDto.setEmail1(memberDto.getEmail1() + "@" + memberDto.getEmail2());

         if (multipartFile != null && !multipartFile.isEmpty()) {
            String originalPicture = multipartFile.getOriginalFilename();
            String realPath = servletContext.getRealPath("/upload/profile");

            DateFormat df = new SimpleDateFormat("yyMMdd");
            String saveFolder = df.format(new Date());
            String realSaveFolder = realPath + File.separator + saveFolder;

            File dir = new File(realSaveFolder);
            if (!dir.exists()) {
               dir.mkdirs();
            }
            String savePicture = UUID.randomUUID().toString()
                  + originalPicture.substring(originalPicture.lastIndexOf('.'));

            File file = new File(realSaveFolder, savePicture);
            try {
               multipartFile.transferTo(file);
            } catch (IllegalStateException e) {
               e.printStackTrace();
            } catch (IOException e) {
               e.printStackTrace();
            }

            memberDto.setSaveFolder(saveFolder);
            memberDto.setOrigin_proPicture(originalPicture);
            memberDto.setSave_proPicture(savePicture);

         }
         memberService.writeArticle(memberDto);
         session.setAttribute("userInfo", memberDto);

      }
      return "commons/AllListMain";
   }//api프로필설정완료

   //////////////////////////////////////////api
   /* GoogleLogin */
   @Autowired
   private GoogleConnectionFactory googleConnectionFactory;
   @Autowired
   private OAuth2Parameters googleOAuth2Parameters;
   private OAuth2Operations oauthOperations;

   /* NaverLogin*/
   private NaverLoginBO naverLoginBO;
   private String apiResult = null;

   @Autowired
   private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
      this.naverLoginBO = naverLoginBO;
   }

   @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
   public ModelAndView navercallback(@RequestParam String code, @RequestParam String state, HttpSession session)
         throws IOException {
      OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);

      apiResult = naverLoginBO.getUserProfile(oauthToken);
      session.setAttribute("userInfo", apiResult);
      return new ModelAndView("commons/AllListMain", "userInfo", apiResult);
   }

   // 구글 Callback호출 메소드
   @RequestMapping(value = "/googleSignInCallback", method = { RequestMethod.GET, RequestMethod.POST })
   public String doSessionAssignActionPage(HttpServletRequest request, HttpSession session) throws Exception {
      MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
      String code = request.getParameter("code");

      oauthOperations = googleConnectionFactory.getOAuthOperations();
      AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),null);

      String accessToken = accessGrant.getAccessToken();
      Long expireTime = accessGrant.getExpireTime();

      if (expireTime != null && expireTime < System.currentTimeMillis()) {
         accessToken = accessGrant.getRefreshToken();
      }

      Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);
      Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
      System.out.println(connection);

      PlusOperations plusOperations = google.plusOperations();
      Person profile = plusOperations.getGoogleProfile();
     
      //나중에 정보 json decode 처리하기
      memberDto = memberService.getMember(profile.getId());
      if(memberDto ==null) {
         MemberDto memberDto1 = new MemberDto();
         memberDto1.setId(profile.getId());
         memberService.insertApi(profile.getId());
         session.setAttribute("userInfo", memberDto1);
         
          return "redirect:/login/writeApi.dnb";
      }else{
          session.setAttribute("userInfo", memberDto);
          return "commons/AllListMain";
      }
      
   }

}