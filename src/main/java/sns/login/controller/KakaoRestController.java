package sns.login.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;
import sns.domain.Member;
import sns.login.service.LoginService;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.node.ObjectNode;

@Log4j
@Controller
@RequestMapping("kakaoLogin")
public class KakaoRestController {
	
	@GetMapping("loginRequest.do")
	public String loginRequest(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName(getAuthorizationUrl(session));
		return "redirect:"+getAuthorizationUrl(session);
	}
	
	@GetMapping("login.do")
	public String login(@RequestParam("code") String code, HttpSession session) {
		log.info("#code: " + code);
		JsonNode kakaoNode = getAccessToken(code);
		log.info("#kakaoNode: " + kakaoNode);
		JsonNode userInfo = getKakaoUserInfo(kakaoNode.get("access_token"));
		log.info("#userInfo: " + userInfo);
		JsonNode kakao_account = userInfo.path("kakao_account");
		JsonNode properties = userInfo.path("properties");
		String email = kakao_account.path("email").asText();//db저장 안함. db구조 재설계필요할듯해서 
		session.setAttribute("loginUser", new Member(email, null, null, null, 1));
		return "board/list";
	}
	

	private String getAuthorizationUrl(HttpSession session) {
		StringBuffer sb = new StringBuffer();
		String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?client_id="+KakaoLoginSet.CLIENT_ID;
		sb.append(kakaoUrl);
		kakaoUrl = "&redirect_uri="+KakaoLoginSet.REDIRECT_URI+"&response_type=code";
		sb.append(kakaoUrl);
		return sb.toString();
	}
	
	private JsonNode getAccessToken(String autorize_code) {
	      final String RequestUrl = "https://kauth.kakao.com/oauth/token";
	      final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	      postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
	      postParams.add(new BasicNameValuePair("client_id", KakaoLoginSet.CLIENT_ID)); // REST API KEY
	      postParams.add(new BasicNameValuePair("redirect_uri", KakaoLoginSet.REDIRECT_URI)); // 리다이렉트 URI                                                              
	      postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정중 얻은 code 값
	      final HttpClient client = HttpClientBuilder.create().build();
	      final HttpPost post = new HttpPost(RequestUrl);
	      JsonNode returnNode = null;
	      try {
	         post.setEntity(new UrlEncodedFormEntity(postParams));
	         final HttpResponse response = client.execute(post);
	         // JSON 형태 반환값 처리
	         ObjectMapper mapper = new ObjectMapper();
	         returnNode = mapper.readTree(response.getEntity().getContent());
	      } catch (UnsupportedEncodingException e) {
	         e.printStackTrace();
	      } catch (ClientProtocolException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      } finally {
	         // clear resources
	      }
	      return returnNode;
	   }
	   
	   private JsonNode getKakaoUserInfo(JsonNode accessToken) {
	      final String RequestUrl = "https://kapi.kakao.com/v2/user/me";
	      final HttpClient client = HttpClientBuilder.create().build();
	      final HttpPost post = new HttpPost(RequestUrl);
	      // add header
	      post.addHeader("Authorization", "Bearer " + accessToken);
	      JsonNode returnNode = null;
	      try {
	         final HttpResponse response = client.execute(post);
	         // JSON 형태 반환값 처리
	         ObjectMapper mapper = new ObjectMapper();
	         returnNode = mapper.readTree(response.getEntity().getContent());
	      } catch (ClientProtocolException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      } finally {
	         // clear resources
	      }
	      return returnNode;
	   }
	

}
