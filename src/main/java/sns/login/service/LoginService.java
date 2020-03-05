package sns.login.service;

import sns.domain.Member;

public interface LoginService {
	int loginCheck(String mem_email, String mem_pwd);
	Member userLogin(String mem_email);
}
