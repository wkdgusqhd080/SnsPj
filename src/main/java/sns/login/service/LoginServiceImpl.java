package sns.login.service;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import lombok.extern.log4j.Log4j;
import sns.domain.Member;
import sns.login.mapper.LoginMapper;

@Service
@Log4j
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginMapper mapper;
	
	@Override
	public int loginCheck(String mem_email, String mem_pwd) {
		mem_email.trim(); mem_pwd.trim();
		Member member = mapper.selectMember(mem_email);
		if(member == null) {
			return LoginSet.NO_ID;
		}else {
			if(member.getMem_pwd().equals(mem_pwd)) {
				if(member.getMem_state() == 0) {
					return LoginSet.NO_PASS;
				}else {
					return LoginSet.PASS;
				}
			}else {
				return LoginSet.NO_PWD;
			}
		}
	}

	@Override
	public Member userLogin(String mem_email) {
		Member member = mapper.selectMember(mem_email);
		return member;
	}

	
}

