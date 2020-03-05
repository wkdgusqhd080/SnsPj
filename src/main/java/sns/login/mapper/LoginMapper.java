package sns.login.mapper;

import sns.domain.Member;

public interface LoginMapper {
	Member selectMember(String mem_email);
}
