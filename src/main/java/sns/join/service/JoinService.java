package sns.join.service;

import sns.domain.Member;

public interface JoinService {
	boolean emailCheckS(String mem_email);
	public void joinEmailAuth(Member member) throws Exception;
	boolean joinAuthCheck(String mail_authkey, String mem_email);
}
