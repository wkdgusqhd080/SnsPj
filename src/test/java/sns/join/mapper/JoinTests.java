package sns.join.mapper;

import java.util.HashMap;

import org.apache.commons.lang3.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;
import sns.domain.Mail_Auth;
import sns.domain.Member;
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class JoinTests {
	@Autowired
	private JoinMapper mapper;
	/*
	@Test
	public void testList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "a@naver.com";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		Member m = loginMapper.selectMember(mem_email);
		String mem_pwd = "1234";
		String pwdDb = m.getMem_pwd();
		if(pwdDb != null) pwdDb = pwdDb.trim();
		boolean hashPwd = BCrypt.checkpw(mem_pwd, m.getMem_pwd());
		if(hashPwd == false) {
			log.info("비번불일치"); //비밀번호 불일치
		}else {
			log.info("로그인성공");//로그인 성공
		}	
	}
	*/
	/*
	@Test
	public void testList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "a@naver.com";
		//String mem_email = "kk070@hanmail.net";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		String m = loginMapper.selectKakaoMember(mem_email);
		if(m != null) {
			log.info("#m: " + m);
		}else {
			log.info("#m: " + m);
		}
		*/
	/*
	@Test
	public void testInsert() {
		Member m = new Member("email", null, null, "20-29", 1, null, null, 0, 0, 0);
		joinMapper.insertKakaoMember(m);
		log.info("#MemberTests insert(): 수행완료");
	}
	*/
	/*
	@Test
	public void testInsert() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String mem_email = "wkdgusqhd080@naver.com";
		int uuid = 1234;
		map.put("mem_email", mem_email);
		map.put("email_uuid", uuid);
		joinMapper.insertEmailAuth(map);
	}
	*/
	/*
	@Test
	public void selectList() {
		//log.info("#mentoringMapper: " + loginMapper.getClass().getName());
		String mem_email = "wkdgusqhd080@naver.com";
		//String mem_email = "kk070@hanmail.net";
		//log.info("#LoginTests testList(): " + loginMapper.getMembers(mem_email));
		Email_Auth email_auth = joinMapper.selectEmailAuth(mem_email);
		log.info("#email_auth: " + email_auth);
	}
*/
/*
	@Test
	public void testDelete() {
		String mem_email = "wkdgusqhd080@naver.com";
		joinMapper.deleteEmailAuth(mem_email);
		log.info("#JoinTests delete(): 수행완료");
	}
*/
	/*
	@Test
	public void testEmailCheck() {
		String mem_email = "a@naver.com";
		
		String str = mapper.selectEmailCheck(mem_email);
		switch(StringUtils.defaultString(str)) {
		case "": log.info("str1: " + str); return;
		default: log.info("str2: " + str); return;
		}
		
		//HashMap<String, Object> map = new HashMap<String, Object>();
		//map.put("mem_email", mem_email);
		//map.put("mem_gubun", 0);//0은 순수회원
		//String email = joinMapper.selectCheckEmail(map);
		
		//log.info("#email: " + email);
		
		//String mem_email = "wkdgusqhd080@naver.com";
		//String str = joinMapper.selectCheckNick(mem_email);
		//log.info("#str: " + str);
	}
	*/
	
	@Test
	public void joinTest() {
		Member member = new Member("e@naver.com", "1234", null, "defaultProfile.jpg", 0);
		mapper.insertMember(member);
		Mail_Auth mail_auth = new Mail_Auth("e@naver.com", "12345");
		mapper.insertMailAuth(mail_auth);
		
	}
}
