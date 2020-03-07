package sns.join.service;


import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
import sns.domain.Mail_Auth;
import sns.domain.Member;
import sns.join.mapper.JoinMapper;

@Log4j
@Service
public class JoinServiceImpl implements JoinService {
	@Autowired
	JoinMapper mapper;
	
	@Override
	public boolean emailCheckS(String mem_email) {
		String emailCheckStr = mapper.selectEmailCheck(mem_email);
		switch(StringUtils.defaultString(emailCheckStr)) {
		case "": return true;//사용가능
		default: return false;//사용불가
		}
	}
	@Inject    //서비스를 호출하기 위해서 의존성을 주입
    JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.

	@Override
	@Transactional
	public void joinEmailAuth(Member member) throws Exception{
		String mail_authkey = AuthKey.getKey(20);//log.info("#mail_authkey: " + mail_authkey);
		String mem_email = member.getMem_email();
		mapper.insertMember(member);
		mapper.insertMailAuth(new Mail_Auth(mem_email, mail_authkey));
		
		MailUtils sendMail = new MailUtils(mailSender);
		sendMail.setSubject("bong's SNS회원가입 인증 이메일 입니다.");
		sendMail.setText(new StringBuffer().append(System.getProperty("line.separator"))
				.append("안녕하세요 회원님. bong's SNS를 찾아주셔서 감사합니다")
				.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='localhost:8000/join/joinAuthConfirm.do?mail_authkey=")
				.append(mail_authkey)
				.append("&mem_email=")
				.append(mem_email)
				.append("' target='_blank'>인증 확인</a>")
				.toString()
				);
		sendMail.setFrom("wkdgusqhd080@gmail.com", "bons's SNS");
		sendMail.setTo(mem_email);
		sendMail.send();
		
	}

	@Override
	@Transactional
	public boolean joinAuthCheck(String mail_authkey, String mem_email) {
		String authkey = mapper.selectJoinAuthCheck(mem_email);		
		if(authkey.equals(mail_authkey)) {
			mapper.updateMemberState(mem_email);
			mapper.deleteMailAuth(mem_email);
			return true;
		}else {
			return false;
		}
	}
}
